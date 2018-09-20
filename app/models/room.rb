class Room < ApplicationRecord

  has_many :user_rooms
  has_many :users, through: :user_rooms

  validates :name,
    presence: true

  def self.generate_token
    salt = ToririnChat::Application.secrets.secret_key_base
    token = Hashids.new(salt, 20).encode(SecureRandom.random_number(1 << 64))
    if Room.where(token: token).exists?
      return generate_token
    else
      token
    end
  end

  def self.generate_code
    code = 6.times.map{ Random.rand(0..9) }.join
    if Room.where(code: code).exists?
      return generate_code
    else
      code
    end
  end

end
