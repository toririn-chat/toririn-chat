# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  icon       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :messages
  validates :name, :icon, presence: true

  def icon_path
    ActionController::Base.helpers.asset_path(File.join('images', 'icons', icon))
  end

end
