class MoneyTransfer < Context

  def initialize(source, destination, amount)
    @role_player = {} # eg { 'role1_name' => object1, 'role2_name' => object1 }
    @role_player['Source'] = source
    @role_player['Destination'] = destination
    @role_player['Amount'] = amount
  end
  
  def trans
    execute_in_context do
      Source.transfer Amount
    end
  end

  class Source < Role
    class << self
      def transfer(amount) 
        logger.info "Source balance is #{Source.balance}"
        logger.info "Destination balance is #{Destination.balance}"
        Destination.deposit amount
        Source.withdraw amount
        logger.info "Source balance is now #{Source.balance}"
        logger.info "Destination balance is now #{Destination.balance}"
      end
      def withdraw(amount)
        Source.decrease_balance amount
      end
    end
  end
  class Destination < Role
    class << self
      def deposit(amount) 
        Destination.increase_balance amount
      end
    end
  end
  class Amount < Role
  end
end
