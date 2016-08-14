class User < ApplicationRecord
  has_many :messages
  validates :name, :icon, presence: true

  def icon_path
    ActionController::Base.helpers.asset_path(File.join('images', 'icons', icon))
  end

end
