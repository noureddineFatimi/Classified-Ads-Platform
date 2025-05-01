class AnnouncementController < ApplicationController

  def form1
    if session[:id_user] == nil
      flash[:error] = "Veuillez-vous connectez d'abord."
      redirect_to login_path and return
    end
    @liste_des_villes = City.all

    categories_feuilles = CategoryApp.all.select do |cat|
      CategoryApp.where(parent_id: cat.id).empty? 
    end
    
    @categories_feuilles_avec_chemin = categories_feuilles.map { |cat| [cat.nom_complet, cat.id] }
    render :layout => 'add_edit'
  end

  def postForm1
    session[:form1] =  {titre: params[:titre], ville_id: params[:ville], categorie_id: params[:categorie_id], num_tele: params[:num_tele],description: params[:description], prix: params[:prix]}
    session[:postform1] = true
    redirect_to add_2_path and return
  end

  def form2
    if session[:id_user] == nil
      flash[:error] = "Veuillez-vous connectez d'abord."
      redirect_to login_path and return
    end
    if session[:postform1] != true
      flash[:error] = "Veuillez remplire l'étape 1 d'abord."
      redirect_to form1_path and return
    end
    form1 = session[:form1].symbolize_keys
    @liste_des_properties = PropertyField.where(category_app_id: form1[:categorie_id])
    @hash_des_options_pour_chaque_property_select = Hash.new
    @liste_des_properties.each do |caracteristique|
      if caracteristique.field_type == "select"
        @hash_des_options_pour_chaque_property_select[caracteristique.name] = PropertyFieldOption.where(property_field_id: caracteristique.id)
      end
    end
    render :layout => 'add_edit'
  end

  def postForm2
    if params[:announcement] != nil
      session[:form2] = params[:announcement].permit!
    end
    session[:postform2] = true
    redirect_to add_3_path and return
  end

  def form3
    if session[:id_user] == nil
      flash[:error] = "Veuillez-vous connectez d'abord."
      redirect_to login_path and return
    end
    if session[:postform2] != true
      flash[:error] = "Veuillez remplire l'étape 2 d'abord."
      redirect_to form2_path and return
    end
    if session[:postform1] != true
      flash[:error] = "Veuillez remplire l'étape 1 d'abord."
      redirect_to form1_path and return
    end
    render :layout => 'add_edit'
  end

  def postForm3
    
    form1 = session[:form1].symbolize_keys
    form2 = session[:form2]
  
    @annonce = Announcement.new(
      title: form1[:titre],
      description: form1[:description],
      price: form1[:prix],
      pub_date: Date.today,
      status: "actif",
      user_app_id: session[:id_user],
      city_id: form1[:ville_id],
      category_app_id: form1[:categorie_id],
      phone_number: form1[:num_tele]
    )
  
    if @annonce.save
      
      if form2 != nil
        form2.each do |property_name, value|
          property = PropertyField.find_by(name: property_name)
          valeur = value
          if property&.field_type == "select"
            valeur = PropertyFieldOption.find(value).value
          end
    
          PropertyValue.create(
            announcement_id: @annonce.id,
            property_field_id: property.id,
            value: valeur
          )
        end
      end
      
  
     
      if params[:announcement][:images].present?
        params[:announcement][:images].each do |image|
          @annonce.images.attach(image)
        end
      end
  
      
      session.delete(:form1)
      session.delete(:form2)
      session.delete(:postform1)
      session.delete(:postform2)
  
      flash[:success] = "Votre annonce a été créée avec succès !"
      redirect_to myAnnouncements_path and return
    else
      @liste_des_villes = City.all

      categories_feuilles = CategoryApp.all.select do |cat|
        CategoryApp.where(parent_id: cat.id).empty? 
      end
      
      @categories_feuilles_avec_chemin = categories_feuilles.map { |cat| [cat.nom_complet, cat.id] }
      flash.now[:error] = "Une erreur s'est produite lors de la création de votre annonce."
      render :form1, status: :unprocessable_entity, content_type: "text/html"
    end
  end
  

    def display
      @annonce_a_afficher = Announcement.find_by(id: params[:id])
      if @annonce_a_afficher.nil?
        redirect_to not_found_path and return
      end
      @username_annonceur = UserApp.find(@annonce_a_afficher.user_app_id) 
      @nom_ville = City.find(@annonce_a_afficher.city_id)
      @tableau_des_caracteristiques = PropertyValue.joins(:property_field).where(announcement_id: @annonce_a_afficher.id)
    end

    def search
      @tous_les_villes = City.all
      categories_feuilles = CategoryApp.all.select do |cat|
        CategoryApp.where(parent_id: cat.id).empty?
      end
      
      @categories_feuilles_avec_chemin = categories_feuilles.map { |cat| [cat.nom_complet, cat.id] }
      
      @annonces = Announcement.all
    
      if params[:mot_cle].present?
        @annonces = @annonces.where("title LIKE ?", "%#{params[:mot_cle]}%")
      end
    
      if params[:ville].present?
        @annonces = @annonces.joins(:city).where(cities: { name: params[:ville] })
        @nomVille = params[:ville]
      end
    
      if params[:categorie_id].present?
        @annonces = @annonces.where(category_app_id: params[:categorie_id])
        @categorie = CategoryApp.find(params[:categorie_id])
      end

      @annonces = @annonces.reverse



    end
    

    def displayMyAnnouncements
      if session[:id_user]
        @mesAnnonces = Announcement.where(user_app_id: session[:id_user])        
      else
        flash[:error] = "Veuillez-vous connectez d'abord."
        redirect_to login_path and return
      end
    end

    def delete
      if session[:id_user] == nil
        flash[:error] = "Veuillez-vous connectez d'abord."
        redirect_to login_path and return
      end
      @annonce = Announcement.find_by(id: params[:id])
      if @annonce == nil
        redirect_to not_found_path and return
      end
      if @annonce.user_app_id != session[:id_user]
        flash[:error] = "Action impossible"
        redirect_to not_found_path and return
      end
      if @annonce.destroy
        flash[:success] = "Annonce supprimée avec succès"
      else
        flash[:error] = "Impossible de supprimer l'annonce: #{@annonce.errors.full_messages.join(', ')}"
      end
      redirect_to myAnnouncements_path and return
    end

    def edit
      if session[:id_user] == nil
        flash[:error] = "Veuillez-vous connectez d'abord."
        redirect_to login_path and return
      end
      @annonce = Announcement.find_by(id: params[:id])
      if @annonce.nil?
        redirect_to not_found_path and return
      end
      if @annonce.user_app_id != session[:id_user]
        flash[:error] = "Action impossible"
        redirect_to not_found_path and return
      end
      @villes = City.all
      @proprietés = PropertyField.where(category_app_id: @annonce.category_app_id)
      @hash_des_options_property_select = Hash.new
      @proprietés.each do |car|
        if car.field_type == "select"
          @hash_des_options_property_select[car.name] = PropertyFieldOption.where(property_field_id: car.id)
        end
      end
      render :layout => 'add_edit'
    end



    def postEdit
      @annonce = Announcement.find(params[:id])
      
      if @annonce.update(title: params[:titre],city_id: params[:ville],phone_number: params[:num_tele],description: params[:description],price: params[:prix])
      
          params.each do |clé, valeur|
            next if ['id','titre','ville','num_tele','description','prix'].include?(clé.to_s) || clé.to_s.start_with?('remove_image_', 'new_images')
          
            field = PropertyField.find_by(name: clé)
            next if field.nil?  
          
            id_proprieté = field.id
            valeur_propriété = PropertyValue.find_by(announcement_id: params[:id], property_field_id: id_proprieté)
          
            if valeur.nil? || valeur.strip == ''
              valeur_propriété&.destroy
            else
              
              valeur_finale = if field.field_type == "select"
                                PropertyFieldOption.find(valeur).value
                              else
                                valeur
                              end
          
              if valeur_propriété
                valeur_propriété.update(value: valeur_finale)
              else
                PropertyValue.create(
                  announcement_id: params[:id],
                  property_field_id: id_proprieté,
                  value: valeur_finale
                )
              end
            end
          end
          
          
          if params.keys.any? { |k| k.to_s.start_with?('remove_image_') }
            params.keys.each do |key|
              if key.to_s.start_with?('remove_image_') && params[key] == "1"
                image_id = key.to_s.gsub('remove_image_', '').to_i
                image = @annonce.images.find(image_id)
                image.purge if image
              end
            end
          end
          
          if params[:new_images].present?
            @annonce.images.attach(params[:new_images])
          end
          
          redirect_to myAnnouncements_path, notice: 'Annonce modifiée avec succès' and return
      else
        @villes = City.all
        @proprietés = PropertyField.where(category_app_id: @annonce.category_app_id)
        @hash_des_options_property_select = Hash.new
        @proprietés.each do |car|
          if car.field_type == "select"
            @hash_des_options_property_select[car.name] = PropertyFieldOption.where(property_field_id: car.id)
          end
        end
          render :edit, status: :unprocessable_entity, content_type: "text/html"
      end
    end

    def not_found
      render :not_found, status: :not_found
    end

end
