class Stamp < ApplicationRecord
  belongs_to :stamp_group
  mount_uploader :image, StampUploader
end
