class SeasonsController < MyMagicController
   
  def create_next_episode
    s=Season.find(params[:id])
    if s.create_next_episode
      #       TODO back albo defaultep
      redirect_to @default_redirect_path, notice: "Next season was successfully created."
    else
      #       TODO back albo default
      redirect_to @default_redirect_path, alert: "Failed to create next season"
    end
  end
  
  private
  
    def configure
      @default_model = Season
      @default_redirect_path = :back
    end
  
    def item_params
      params.require(:season).permit(:number, :description, :ended, :episodes_number, :show_id)
    end
  
end
