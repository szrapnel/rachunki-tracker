class ShowsController < MyMagicController
  
  private
  
    def configure
      @default_model = Show
      @default_redirect_path = :back
    end
  
    def item_params
      params.require(:show).permit(:title, :ended, :description, :seasins_number)
    end
  
end
