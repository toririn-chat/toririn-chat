class Person < ApplicationRecord

  belongs_to :avatar, optional: true
  has_many :messages
  has_secure_token :token

  validates :name,
    presence: true,
    on: :update

end
