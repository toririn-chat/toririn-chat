# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord

  belongs_to :teacher, class_name:'User'
  has_many :messages
  validates :name, {presence: true}

end
