module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verfied_user
    end

    private

    def find_verfied_user
      uid = request.headers['uid']
      cid = request.headers['client']
      token = request.headers['access-token']

      if current_user == env['warden'].user && !current_user.nil?
        current_user
      elsif uid && cid && token
        user = User.find_by(email: cid)
        if user&.valid_token?(token, cid)
          user
        else
          reject_unauthorized_connection
        end
      elsif request.params['token']
        request.params['token']
      else
        reject_unauthorized_connection
      end
    end
  end
end
