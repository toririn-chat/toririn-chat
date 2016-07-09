class User < ApplicationRecord
  has_many :messages
  validate :name_cannot_be_blank

  def icon_path
    ActionController::Base.helpers.asset_path(icon)
  end

  def name_cannot_be_blank
   if !name.present? || name.strip.blank?
     errors.add(:name, 'cannot be blank')
   end
  end

end
