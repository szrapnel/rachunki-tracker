class SeasonsController < MyMagicController
   
  def initialize
    @default_model = Season
    @default_redirect_path = '/'
  end
  
  private
  
    def item_params
      params.require(:season).permit(:number, :description, :ended, :episodes_number, :show_id)
    end
  
end
