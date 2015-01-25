class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    #     on heroku this not worked
    #     magic_index
    redirect_to "/banks/magic_index"
  end
  
  def magic_index
    @list = Bank.all
    render template: "layouts/magic_view"
  end

  def show
    @item=@bank
    render template: "layouts/_magic_show"
  end

  def new
    @bank = Bank.new
    @item = @bank
    render template: "magic/new"
  end

  def edit
    @item = @bank
    render template: "magic/edit"
  end

  def create
    @bank = Bank.new(bank_params)

    if @bank.save
      redirect_to banks_path, notice: 'Bank was successfully created.'
    else
      render :new
    end
  end

  def update
    if @bank.update(bank_params)
      redirect_to @bank, notice: 'Bank was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bank.destroy
    redirect_to banks_url, notice: 'Bank was successfully destroyed.'
  end
  
  private
    def set_bank
      @bank = Bank.find(params[:id])
    end

    def bank_params
      params.require(:bank).permit(:name)
    end
end
