class TasksController < MyMagicController
   
 
  private
  
    def configure
      @default_model = Task
      @default_redirect_path = '/'
    end
  
    def item_params
      params.require(:task).permit(:title, :description)
    end
  
end
