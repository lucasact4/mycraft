class SessionsController < ApplicationController

  def new

  end

  def create
    player = Player.find_by(email: params[:session][:email].downcase)
    if player && player.authenticate(params[:session][:password])
      session[:player_id] = player.id
      flash[:success] = "Você fez login com sucesso!"
      redirect_to player
    else
      redirect_to login_path, flash: { danger: "Há algo de errado com as informações de login digitadas!" }
    end
  end

  def destroy
    session[:player_id] = nil
    flash[:success] = "Você deslogou!"
    redirect_to root_path
  end

end