class User < ActiveRecord::Base
  has_one :account
  has_many :sent_transfers, through: :account
  has_many :received_transfers, through: :account

end
