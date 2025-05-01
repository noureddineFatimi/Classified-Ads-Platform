class HomeController < ApplicationController
  before_action :charger_villes_et_categories_feuilles

  def index

    @top_categs = CategoryApp.where(name: ["Voitures d'occasion","Maisons à vendre","Appartements à louer","Maison avec Jardin", "T-shirts","Téléphones","Bureaux à louer"])

    categories = CategoryApp.where(name: ["Téléphones", "Maisons à vendre","Voitures d'occasion"]).index_by(&:name)
    @coll_annonces_Voitures_occasion = announcements_for_category(categories["Voitures d'occasion"]).reverse
    @coll_annonces_Telephones = announcements_for_category(categories["Téléphones"]).reverse
    @coll_annonces_maison_a_vendre = announcements_for_category(categories["Maisons à vendre"]).reverse
  end

  private

  def charger_villes_et_categories_feuilles
    @tous_les_villes = City.all

    categories_feuilles = CategoryApp.all.select do |cat|
      CategoryApp.where(parent_id: cat.id).empty? 
    end
    
    @categories_feuilles_avec_chemin = categories_feuilles.map { |cat| [cat.nom_complet, cat.id] }
  end

  private

  def announcements_for_category(category)
    category.present? ? Announcement.where(category_app_id: category.id).order(created_at: :desc).limit(4) : Announcement.none
  end  
end
