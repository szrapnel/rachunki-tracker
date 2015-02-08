class ShowsController < MyMagicController
   
  def initialize
    @default_model = Show
    @default_redirect_path = '/'
  end
  
  private
  
    def item_params
      params.require(:show).permit(:title, :ended, :description, :seasins_number)
    end
  
end
