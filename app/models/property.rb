class Property < ApplicationRecord
  belongs_to :user, optional: true
  has_many_attached :images

  validates :name, :address, :city, :price, presence: :true
end
