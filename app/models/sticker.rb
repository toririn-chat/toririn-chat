class Sticker < ApplicationRecord
  belongs_to :group, class_name: 'StickerGroup', foreign_key: 'sticker_group_id'
  mount_uploader :image, StickerUploader
end
