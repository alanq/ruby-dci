class Account
  include Context

  def initialize(ledgers = [])
    @role_player = {} # eg { 'role1_name' => object1, 'role2_name' => object1 }
    @role_player[Ledgers] = Array(ledgers) # association of the role Ledgers with the object ledgers
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
      debugger
      Ledgers.add_entry 'withdrawing', -1 * amount
    end
  end

  # A role can use self or player to reference the obj associated with it
  class Ledgers < Role
    class << self
      def add_entry(msg, amount) 
        player << LedgerEntry.new(:message => msg, :amount => amount)
      end
      def balance
        player.collect(&:amount).sum
      end
    end # Role class methods
  end # Role

end # Context
