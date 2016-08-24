# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  user_id    :integer
#  text       :text
#  stamp      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord

  belongs_to :room
  belongs_to :user
  has_many :user_messages
  validates :text_or_stamp, {presence: true}
  after_create_commit {
    MessageBroadcastJob.perform_later('append', self)
  }

  def readers
    User.find(user_messages.where(read:true).pluck(:user_id))
  end

  def read?(user_id)
    user_messages.where(user_id:user_id, read:true).exists?
  end

  private

    def text_or_stamp
      text.presence or stamp.presence
    end

    def stamp_path
      ActionController::Base.helpers.asset_path(File.join('images', 'stamps', stamp))
    end

end
