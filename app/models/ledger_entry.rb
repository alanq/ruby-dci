class LedgerEntry < ActiveRecord::Base
  attr_accessible :amount, :message
end
