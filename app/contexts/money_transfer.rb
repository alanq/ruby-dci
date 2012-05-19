class MoneyTransfer
  include Context

  attr_accessor :source, :destination

  def initialize(source, destination, amount)
    @source = source
    assign_role Source, @source

    @destination = destination
    assign_role Destination, @destination

    @amount = amount
    assign_role Amount, @amount
  end
  
  def trans
    execute_in_context do
      @source.transfer @amount
    end
  end

  module Source
    include Role
    extend Role::ClassMethods

    def transfer(amount) 
      log = Logger.new(STDOUT)
      log.info "Source balance is #{self.balance}"
      log.info "Destination balance is #{Destination.balance}"
      Destination.deposit amount
      self.withdraw amount
      log.info "Source balance is now #{self.balance}"
      log.info "Destination balance is now #{Destination.balance}"
    end
    def withdraw(amount)
      self.decrease_balance amount
    end
  end

  module Destination
    include Role
    extend Role::ClassMethods

    def deposit(amount) 
      self.increase_balance amount
    end
  end

  module Amount
    include Role
    extend Role::ClassMethods
  end
end
