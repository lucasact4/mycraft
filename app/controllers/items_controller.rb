class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy, :update, :show]
  before_action :set_error, only: [:new, :edit]
  before_action :require_admin, except: [:show, :index]
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "O item foi criado com sucesso"
      redirect_to item_path(@item)
    else
      if @item.errors.any?
        @errors = true
        @count = @item.errors.count
        @error = @item.errors.messages
      end
      redirect_to new_item_path(item: @item, errors: @errors, count: @count, error: @error)
    end
  end

  def edit
    @item = Item.find(params[:id]) if params[:id]
  end

  def update
    if @item.update(item_params)
      flash[:success] = "O nome do item foi atualizado com sucesso"
      redirect_to @item
    else
      if @item.errors.any?
        @errors = true
        @count = @item.errors.count
        @error = @item.errors.messages
      end
      redirect_to edit_item_path(item: @item, errors: @errors, count: @count, error: @error)
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item excluído com sucesso!"
    redirect_to items_path
  end

  def show
    @item_posts = @item.posts.paginate(page: params[:page], per_page: 5)
  end

  def index
    @items = Item.paginate(page: params[:page], per_page: 5)
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

  def set_error
    @error = params[:error]
    @count = params[:count]
    @errors = params[:errors] == 'true'
    @item = params[:item] || Item.new
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_player.admin?)
      flash[:danger] = "Somente usuários administradores podem executar essa ação"
      redirect_to items_path
    end
  end

end