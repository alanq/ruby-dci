class Account
  include Context

  def initialize(ledgers = [])
    @ledgers = Array(ledgers)
    assign_role Ledgers, @ledgers
  end

  def balance()
    execute_in_context do
      @ledgers.balance
    end
  end
  def increase_balance(amount)
    execute_in_context do
      @ledgers.add_entry 'depositing', amount
    end
  end
  def decrease_balance(amount)
    execute_in_context do
      @ledgers.add_entry 'withdrawing', -1 * amount
    end
  end

  module Ledgers 
    extend Role::ClassMethods

    def add_entry(msg, amount) 
      self << LedgerEntry.new(:message => msg, :amount => amount)
    end
    def balance
      self.collect(&:amount).sum
    end
  end # Role

end # Context
