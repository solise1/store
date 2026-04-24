class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # TODO: add name, address and consider other order related fields, for autocompleting orders
  # validates :name, presence: true, uniqueness: true
  # validates :address, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def admin?
    role == "admin"
  end
end
