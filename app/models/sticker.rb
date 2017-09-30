class Sticker < ApplicationRecord
  belongs_to :group, class_name: 'StickerGroup', foreign_key: 'sticker_group_id'
  has_many :messages
  mount_uploader :image, StickerUploader
end
