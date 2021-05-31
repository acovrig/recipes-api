class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.1]
  def change
    ## Required
    User.where(provider: nil).update_all(provider: 'email')
    change_column :users, :provider, :string, null: false, default: 'email'
    User.where(uid: nil).update_all('uid=email')
    change_column :users, :uid, :string, null: false, default: ''

    ## Recoverable
    add_column :users, :allow_password_change, :boolean, default: false

    ## Confirmable
    # add_column :users, :confirmation_token, :string
    # add_column :users, :confirmed_at, :datetime
    # add_column :users, :confirmation_sent_at, :datetime
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable

    ## Lockable
    # add_column :users, :failed_attempts, :integer, :default => 0, :null => false # Only if lock strategy is :failed_attempts
    # add_column :users, :unlock_token, :string # Only if unlock strategy is :email or :both
    # add_column :users, :locked_at, :datetime

    ## User Info
    add_column :users, :nickname, :string
    add_column :users, :image, :string

    ## Tokens
    add_column :users, :tokens, :json

    add_index :users, :email, unique: true
    add_index :users, %i[uid provider], unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
