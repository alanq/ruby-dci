class MoneyTransfer
  include Context

  def initialize(source, destination, amount)
    @source = source
    @source.extend(Source)

    @destination = destination
    @destination.extend(Destination)

    @amount = amount
    @amount.extend(Amount)
  end
  
  def trans
    execute_in_context do
      @source.transfer @amount
    end
  end

  module Source
    include Role

    def transfer(amount) 
      log = Logger.new(STDOUT)
      log.info "Source balance is #{@source.balance}"
      log.info "Destination balance is #{@destination.balance}"
      @destination.deposit amount
      @source.withdraw amount
      log.info "Source balance is now #{@source.balance}"
      log.info "Destination balance is now #{@destination.balance}"
    end
    def withdraw(amount)
      @source.decrease_balance amount
    end
  end

  module Destination
    include Role

    def deposit(amount) 
      @destination.increase_balance amount
    end
  end

  module Amount
    include Role
  end
end
