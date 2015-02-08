class TasksController < MyMagicController
   
  def initialize
    @default_model = Task
    @default_redirect_path = '/tasks'
  end
  
  private
  
    def item_params
      params.require(:task).permit(:title, :description)
    end
  
end
