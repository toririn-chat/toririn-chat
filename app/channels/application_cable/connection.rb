module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_chat_person

    def connect
      self.current_chat_person = find_current_chat_person
      logger.add_tags 'actioncable', current_chat_person.id
    end

    protected

      def find_current_chat_person
        person = Person.find_by(id: request.session[:chat_person_id])
        return person.presence || reject_unauthorized_connection
      end

  end
end
