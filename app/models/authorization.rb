class Authorization < ApplicationRecord

  belongs_to :room
  extend Enumerize
  enumerize :factor, in: { url: 1, code: 1 }

  def available
    now = Time.zone.now
    return false if now < begin_at
    return false if end_at < now
    return true
  end

end
