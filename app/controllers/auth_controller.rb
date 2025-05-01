class AuthController < ApplicationController
  def new
    if session[:id_user] != nil
      @userConnecté = UserApp.find(session[:id_user])
    end
  end

  def create
    if session[:id_user] != nil
      @userConnecté = UserApp.find(session[:id_user])
    end
    user = UserApp.find_by(email: params[:email])
    if user&.authenticate(params[:password_digest])
      session[:id_user] = user.id
      redirect_to root_path, notice: "Connecté !"
    else
      flash.now[:alert] = "Email ou mot de passe incorrect"
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def destroy
    session[:id_user] = nil
    session.delete(:form1)
    session.delete(:form2)
    session.delete(:postform1)
    session.delete(:postform2)
    redirect_to root_path, notice: "Déconnecté." and return
  end
end
