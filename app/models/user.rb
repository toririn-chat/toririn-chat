class User < ApplicationRecord
  has_many :messages
  validate :name_cannot_be_blank

 def name_cannot_be_blank
   if !name.present? || name.strip.blank?
     errors.add(:name, 'cannot be blank')
   end
 end

end
