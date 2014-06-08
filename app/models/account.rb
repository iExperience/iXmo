class Account < ActiveRecord::Base
  belongs_to :user

  has_many :sent_transfers, class_name: "Transfer",
    foreign_key: :sender_id
  has_many :received_transfers, class_name: "Transfer",
    foreign_key: :receiver_id

  def transfers
    sent_transfers + received_transfers
  end

  # account.sent_transfers
  # account.recieved_transfers
  # account.transfers

  # account = Account.find(1)
  # account.transfers

  # => Look through the transfers table
  # =>  and get me all the transfers that have account_id 1
end
