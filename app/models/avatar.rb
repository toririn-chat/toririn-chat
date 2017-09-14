class Avatar < ApplicationRecord
  belongs_to :avatar_group
  mount_uploader :image, AvatarUploader
end
