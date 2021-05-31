class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def google_oauth2
      auth_params = request.env['omniauth.auth']
      app_token = (request.env['omniauth.params'] || {})['token']
      existing_user = current_user || User.where('email = ?', auth_params['info']['email']).first

      if app_token
        if existing_user
          @client_id = SecureRandom.urlsafe_base64(nil, false)
          @token     = SecureRandom.urlsafe_base64(nil, false)
          token = BCrypt::Password.create(@token)
          expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i
          existing_user.tokens[@client_id] = {
            token: token,
            expiry: expiry
          }
          existing_user.save

          ActionCable.server.broadcast "login_#{app_token}", {user: existing_user, auth: {
                                                                'access-token': @token,
                                                                client: @client_id,
                                                                expiry: expiry,
                                                                uid: existing_user.email,
                                                                'token-type': 'Bearer'
                                                              }}.as_json
          render inline: "<script>window.close();</script>You should be logged in, please close this page.".html_safe and return
        end
      end

      @user = User.from_omniauth(auth_params)

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end
  
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end
