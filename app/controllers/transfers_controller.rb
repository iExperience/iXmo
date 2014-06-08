class TransfersController < ApplicationController
  def index
  end

  def create
    # Create a transfer
    @user = User.last
    result = Transfer.create_transfer(transfer_params)
    if result[0]
      flash[:success] = result[1]
      redirect_to "/"
    else
      @transfer = Transfer.new(transfer_params)
      flash[:error] = result[1]
      render "new"
    end
  end

  def new
    @user = User.last
    @account_ids = Account.pluck(:id)
    @transfer = Transfer.new
  end

  def delete
  end

  private

  def transfer_params
    params.require(:transfer).permit(:receiver_id,
      :amount, :message)
  end
end
