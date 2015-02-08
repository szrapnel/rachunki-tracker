class EpisodesController < MyMagicController
   
  def initialize
    @default_model = Episode
    @default_redirect_path = '/'
  end
  
  private
  
    def item_params
      params.require(:episode).permit(:number, :description, :aired, :season_id)
    end
  
end
