class EpisodesController < MyMagicController
   
  def create_next_episode
    e=Episode.find(params[:id])
    if e.create_next
      #       TODO back albo default
      redirect_to @default_redirect_path, notice: "Next episode was successfully created."
    else
      #       TODO back albo default
      redirect_to @default_redirect_path, alert: "Failed to create next episode"
    end
  end
  
  private
  
    def configure
      @default_model = Episode
      @default_redirect_path = :back
    end
  
    def item_params
      params.require(:episode).permit(:number, :description, :aired, :season_id, :seen)
    end
  
end
