class Announcement < ApplicationRecord
  belongs_to :user_app
  belongs_to :city
  belongs_to :category_app
  has_many_attached :images
  has_many :property_values, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "doit contenir exactement 10 chiffres" }
end
