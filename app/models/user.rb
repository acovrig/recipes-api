class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :recipes, foreign_key: 'author_id'
  has_many :pictures, foreign_key: 'uploaded_by_id'

  validates :name, presence: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user ||= User.create(
      name: data['name'],
      email: data['email'],
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  private

  def set_provider
    self[:provider] = 'email' if self[:provider].blank?
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
