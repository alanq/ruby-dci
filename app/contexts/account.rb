class Account
  include Context

  def initialize(ledgers = [])
    @ledgers = ledgers
    @ledgers.extend(Ledgers)
  end

  def balance()
    execute_in_context do
      Ledgers.balance
    end
  end
  def increase_balance(amount)
    execute_in_context do
      Ledgers.add_entry 'depositing', amount
    end
  end
  def decrease_balance(amount)
    execute_in_context do
      Ledgers.add_entry 'withdrawing', -1 * amount
    end
  end

  module Ledgers 
    include Role

    def add_entry(msg, amount) 
      @ledgers << LedgerEntry.new(:message => msg, :amount => amount)
    end
    def balance
      @ledgers.collect(&:amount).sum
    end
  end # Role

end # Context
