def seeds_avatars(group)
  manifest = YAML::load((IO.read("public/uploads/images/avatars/#{group}/manifest.yml")))
  avatar_group = AvatarGroup.find_or_create_by({
    slug: manifest['slug'],
    title: manifest['title']
  })
  manifest['materials'].each do |path, values|
    slug = File.basename(path, File.extname(path))
    if !Avatar.exists?(slug:slug)
      Avatar.create({
        slug: slug,
        title: values['title'].presence || '',
        description: values['description'].presence || '',
        image: File.open("public/uploads/images/avatars/#{group}/#{path}"),
        avatar_group_id: avatar_group.id,
      })
    end
  end
end

def seeds_stamps(group)
  manifest = YAML::load((IO.read("public/uploads/images/stamps/#{group}/manifest.yml")))
  stamp_group = StampGroup.find_or_create_by({
    slug: manifest['slug'],
    title: manifest['title']
  })
  manifest['materials'].each do |path, values|
    slug = File.basename(path, File.extname(path))
    if !Stamp.exists?(slug:slug)
      Stamp.create({
        slug: slug,
        title: values['title'].presence || '',
        description: values['description'].presence || '',
        image: File.open("public/uploads/images/stamps/#{group}/#{path}"),
        stamp_group_id: stamp_group.id,
      })
    end
  end
end

seeds_avatars('irasutoya')
seeds_stamps('rubicle')
