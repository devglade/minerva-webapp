module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verfied_user
    end

    protected

    def find_verfied_user
      if current_user = env['warden'].user
        current_user
      else
        reject_unauthorized_connection
      end
    end

  end
end
