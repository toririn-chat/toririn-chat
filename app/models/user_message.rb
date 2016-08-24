# == Schema Information
#
# Table name: user_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message_id :integer
#  read       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserMessage < ApplicationRecord

  belongs_to :user
  belongs_to :message
  validates :read, {presence: true}
  after_create_commit {
    MessageBroadcastJob.perform_later('update', message)
  }

end
