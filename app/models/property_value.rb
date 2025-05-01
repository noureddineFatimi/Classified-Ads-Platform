class PropertyValue < ApplicationRecord
  belongs_to :announcement
  belongs_to :property_field
end
