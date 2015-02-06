class OperatorsController < ApplicationController
  before_action :set_operator, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /operators
  # GET /operators.json
  def index
    @operators = Operator.all
  end
  
  def magic_index
    @list = Operator.all.decorate
    render template: "layouts/magic_view"
  end

  # GET /operators/1
  # GET /operators/1.json
  def show
    @operator=@operator.decorate
  end

  # GET /operators/new
  def new
    @operator = Operator.new
  end

  # GET /operators/1/edit
  def edit
  end

  # POST /operators
  # POST /operators.json
  def create
    @operator = Operator.new(operator_params)

    respond_to do |format|
      if @operator.save
        format.html { redirect_to operators_path, notice: 'Operator was successfully created.' }
        format.json { render :show, status: :created, location: @operator }
      else
        format.html { render :new }
        format.json { render json: @operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operators/1
  # PATCH/PUT /operators/1.json
  def update
    respond_to do |format|
      if @operator.update(operator_params)
        format.html { redirect_to @operator, notice: 'Operator was successfully updated.' }
        format.json { render :show, status: :ok, location: @operator }
      else
        format.html { render :edit }
        format.json { render json: @operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operators/1
  # DELETE /operators/1.json
  def destroy
    respond_to do |format|
      if can_destroy?
        @operator.destroy
        format.html { redirect_to operators_url, notice: 'Operator was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to operators_url, alert: 'Operator has invoices, destroy them first.' }
        format.json { head :no_content }
      end
    end
  end
  
  def can_destroy?
    @operator.invoice_number==0
  end
  
  def abandoned
    @list = OperatorsHelper.get_abandoned_operators
    render template: "layouts/magic_view"
  end
  
  def open
    @list = Operator.where(closed:false)
    render template: "layouts/magic_view"
  end
  
  def closed
    @list = Operator.where(closed:true)
    render template: "layouts/magic_view"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operator
      @operator = Operator.find(params[:id])
#       POPRAW TO
      #       TODO jak to zrobic aby nie zmienialo wpisow w bazie
#       @operator.invoices = InvoiceDecorator.decorate_collection(is)
#       @operator.assign_attributes({ :invoices => []})
#       @operator.invoices = []
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operator_params
#       params[:operator]
      params.require(:operator).permit(:name, :days_between_invoices, :closed)
    end
end
