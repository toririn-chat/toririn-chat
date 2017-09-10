class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, {presence: true}

  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  # TODO refactor
  # has_many :messages
  # has_many :user_messages
  # validates :name, :icon, {presence: true}
  # def icon_path
  #   ActionController::Base.helpers.asset_path(File.join('images', 'icons', icon))
  # end

end
