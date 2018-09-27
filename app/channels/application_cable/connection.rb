module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_chat_person

    def connect
      pp 'aaa'
      pp 'aaa'
      pp 'aaa'
      pp 'aaa'
      pp 'aaa'
      pp 'aaa'
      pp 'aaa'
      pp find_current_chat_person
      self.current_chat_person = find_current_chat_person
      pp 'aaa>>>'
      # TODO: logger
      # logger.add_tags 'ActionCable', 'Connection'
      # logger.info "Connected to #{current_user.id}"
    end

    protected

      def find_current_chat_person
        if verified_person = Person.find_by(id: request.session[:chat_person_id])
          verified_person
        else
          reject_unauthorized_connection
        end
      end

  end
end
