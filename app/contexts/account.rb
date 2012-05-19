class Account
  include Context

  def initialize(ledgers = [])
    assign_role Ledgers, Array(ledgers)
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
    extend Role::ClassMethods

    def self.add_entry(msg, amount) 
      player << LedgerEntry.new(:message => msg, :amount => amount)
    end
    def self.balance
      player.collect(&:amount).sum
    end
  end # Role

end # Context
