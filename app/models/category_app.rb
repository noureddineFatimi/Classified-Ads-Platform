class CategoryApp < ApplicationRecord
  belongs_to :parent, class_name: "CategoryApp", optional: true
  has_many :subcategories, class_name: "CategoryApp", foreign_key: "parent_id", dependent: :destroy
  has_many :announcements
  has_many :property_fields
  def nom_complet
    parent ? "#{parent.nom_complet} > #{name}" : name
  end
end
