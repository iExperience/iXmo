class Transfer < ActiveRecord::Base
  belongs_to :sender, class_name: "Account"
  belongs_to :receiver, class_name: "Account"

  # Return [transfer, message] if succeeded
  # Return [false, message] if failed
  def self.create_transfer(transfer_params)
    user = User.last
    transfer = Transfer.new(transfer_params)
    # Make sure the destination is valid
    receiver = Account.find_by(
      id: transfer_params[:receiver_id])
    if receiver.nil?
      return [false, "That account doesn't exist!"]
    else
      # If amount > 0
      amount = transfer_params[:amount].to_i
      if amount > 0
        # Make sure I have enough money
        if user.account.balance > amount
          # Deduct
          user.account.balance -= amount
          user.account.save
          # receiver is an Account
          receiver.balance += amount
          receiver.save
          # Sets the transfer to complete
          transfer.completed = true
        else
          return [false, "Not enough money :("]
        end
      # Otherwise
      else
        # Set transfer to incomplete
        transfer.complete = false
        # DON'T deduct
      end
      if transfer.save
        return [transfer, "Transfer created for 
          #{transfer.amount}"]
      else
        return [false,
          transfer.errors.full_messages.join("\n")]
      end
    end 
  end
end
