class MyMagicController < ApplicationController
  before_action :set_item, only: [:destroy, :edit, :update, :show]
   
  def initialize
    super
    configure
  end
    
  def index
    @list = @default_model.all
    render template: 'layouts/magic_view'
  end
  
  def show
    @item=@item
    render template: 'layouts/_magic_show'
  end

  def new
    @item = @default_model.new
    render template: 'magic/new'
  end
  
  def edit
    render template: 'magic/edit'
  end
  
  def create
    @item = @default_model.new(item_params)
    if @item.save
      redirect_to get_redirect_location, notice: "#{@default_model} created successfully."
    else
      render action: 'new'
    end
  end
  
  def update
    if @item.update(item_params)
      redirect_to get_redirect_location, notice: "#{@default_model} was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    @item.destroy
    redirect_to get_redirect_location, notice: "#{@default_model} was successfully destroyed."
  end
  
  private
  
    def get_redirect_location
      @default_redirect_path
    end
  
    def configure
      raise 'needs overwrite'
      raise 'item_params needs it too'
  #     @default_model = Task
  #     @default_redirect_path = '/tasks'
    end
  
    def set_item
      @item = @default_model.find(params[:id])
    end
  
    def item_params
      raise 'needs overwrite'
#       params.require(:task).permit(:title, :description)
    end

end
