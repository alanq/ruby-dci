class Account < Context

  def initialize(ledgers = [])
    @ledgers = Array(ledgers)
    @role_player = {} # eg { 'role1_name' => object1, 'role2_name' => object1 }
    @role_player['Ledgers'] = @ledgers # association of the role Ledgers with the object @ledgers
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

  class Ledgers < Role
    class << self
      # can use self or player to reference the obj associated with this role
      def add_entry(msg, amount) 
        player << LedgerEntry.new(:message => msg, :amount => amount)
      end
      def balance
        player.collect(&:amount).sum
      end
    end # Role class methods
  end # Role

end # Context
