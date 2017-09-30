class Avatar < ApplicationRecord
  belongs_to :group, class_name: 'AvatarGroup', foreign_key: 'avatar_group_id'
  has_many :people
  mount_uploader :image, AvatarUploader
end
