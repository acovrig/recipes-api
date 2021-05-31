class LoginChannel < ApplicationCable::Channel
  def subscribed
    stream_from "login_#{current_user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
