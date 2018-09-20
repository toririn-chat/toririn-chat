module FixtureUtils
  def self.file(path)
    File::open(path, 'rb'){ |f|
      '!!binary "' + Base64.strict_encode64(f.read) + '"'
    }
  end
end
