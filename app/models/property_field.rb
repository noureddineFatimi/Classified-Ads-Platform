class PropertyField < ApplicationRecord
  belongs_to :category_app
  has_many :property_field_options
  has_many :property_values
end
