class Message < ApplicationRecord

  belongs_to :room
  belongs_to :person
  belongs_to :sticker, required: false

  def type
    return :text    if text.present? && sticker.blank?
    return :sticker if text.blank?   && sticker.present?
  end

  # has_many :user_messages
  # validates :text_or_sticker, {presence: true}

  after_create_commit {
    MessageBroadcastJob.perform_later('append', self)
  }
  #
  # def readers
  #   User.find(user_messages.where(read:true).pluck(:user_id))
  # end
  #
  # def read?(user_id)
  #   user_messages.where(user_id:user_id, read:true).exists?
  # end
  #
  private

    def text_or_sticker
      text.presence or sticker.presence
    end

end
