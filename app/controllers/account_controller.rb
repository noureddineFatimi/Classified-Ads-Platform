class AccountController < ApplicationController

  def new
    if session[:id_user] != nil
      @userConnecté = UserApp.find(session[:id_user])
    end
    @user = UserApp.new
  end

  def create
    if session[:id_user] != nil
      @userConnecté = UserApp.find(session[:id_user])
    end
    autre_infos = {"role_id" => 1, "premium" => false}
    infos_new_user = user_app_params.merge(autre_infos)
    @user = UserApp.new(infos_new_user)
    if @user.save 
      session[:id_user] = @user.id
      redirect_to root_path and return
    else
      flash.now[:alert] = "Erreur lors de creation du compte !"
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private
  
  def user_app_params
    params.require(:user_app).permit(:username, :email, :password)
  end
end
