require 'digest/sha2'

# AvatarGroup
avatar_group_irasutoya = AvatarGroup.find_or_create_by({
  title: 'Irasutoya',
  author: 'Takashi Mifune',
  url: 'http://www.irasutoya.com/',
  license_name: 'Terms of Use',
  license_url: 'http://www.irasutoya.com/p/terms.html'
})

# Avatar
avatar_sha256s = Avatar.all.map{ |avatar| Digest::SHA256.hexdigest(avatar.image.read) }.uniq
Rails.root.join('db/seeds/files/avatars/irasutoya').children.select{ |path|
  path.extname =~ /png/
}.each do |path|
  avatar_sha256 = Digest::SHA256.hexdigest(open(path).read)
  if !avatar_sha256s.include?(avatar_sha256)
    Avatar.create({
      image: open(path),
      group: avatar_group_irasutoya
    })
  end
end

# StickerGroup
sticker_group_rubicle = StickerGroup.find_or_create_by({
  title: 'Rubicle LINE Stamps',
  author: 'rubicle-net Production Staff & Wu',
  url: 'http://rubicle.net/line_stamp.html',
  license_name: 'CC-BY-NC-4.0',
  license_url: 'https://creativecommons.org/licenses/by-nc/4.0/'
})

# Sticker
sticker_sha256s = Sticker.all.map{ |sticker| Digest::SHA256.hexdigest(sticker.image.read) }.uniq
Rails.root.join('db/seeds/files/stickers/rubicle').children.select{ |path|
  path.extname =~ /png/
}.each do |path|
  sticker_sha256 = Digest::SHA256.hexdigest(open(path).read)
  if !sticker_sha256s.include?(sticker_sha256)
    Sticker.create({
      image: open(path),
      group: sticker_group_rubicle
    })
  end
end
