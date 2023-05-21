class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]
  before_action :set_error, only: [:new, :edit]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @players = Player.paginate(page: params[:page], per_page: 5)
  end

  def new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      session[:player_id] = @player.id
      flash[:success] = "Bem-vindo #{@player.playername} ao MyCraft Blog!"
      redirect_to player_path(@player)
    else
      if @player.errors.any?
        @errors = true
        @count = @player.errors.count
        @error = @player.errors.messages
      end
      redirect_to signup_path(player: @player, errors: @errors, count: @count, error: @error)
    end
  end

  def show
    @player_posts = @player.posts.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @player = Player.find(params[:id]) if params[:id]
  end

  def update
    if @player.update(player_params)
      flash[:success] = "Sua conta foi atualizada com sucesso!"
      redirect_to @player
    else
      if @player.errors.any?
        @errors = true
        @count = @player.errors.count
        @error = @player.errors.messages
      end
      redirect_to edit_player_path(player: @player, errors: @errors, count: @count, error: @error)
    end
  end

  def destroy
    if !@player.admin?
      @player.destroy
      flash[:danger] = "Jogador e todas as postagens associadas foram deletadas!"
      redirect_to players_path
    end
  end

  private

  def player_params
    params.require(:player).permit(:playername, :email, :password, :password_confirmation)
  end

  def set_player
    @player = Player.find(params[:id])
  end
  
  def set_error
    @error = params[:error]
    @count = params[:count]
    @errors = params[:errors] == 'true'
    @player = params[:player] || Player.new
  end

  def require_same_user
    @player = Player.find(params[:id])
    if current_player != @player and !current_player.admin?
      flash[:danger] = "Você só pode editar ou excluir sua própria conta!"
      redirect_to players_path
    end
  end

  def require_admin
    if logged_in? && !current_player.admin?
      flash[:danger] = "Somente usuários administradores podem executar essa ação!"
      redirect_to root_path
    end
  end

end