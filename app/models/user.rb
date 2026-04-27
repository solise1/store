class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, uniqueness: true
  validates :address, uniqueness: true
  validates :email, presence: true, uniqueness: true

  scope :admin, -> { where(role: "admin") }
  scope :regular, -> { where.not(role: "admin") }

  def admin?
    role == "admin"
  end

  # When I add option to create from order, simply make new user and call this
  def update_fields_from_order(order)
    self.name = order.name
    self.address = order.address
    self.email = order.email
    self
  end
end
