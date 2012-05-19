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
      Source.transfer @amount
    end
  end

  module Source
    extend Role::ClassMethods

    def self.transfer(amount) 
      log = Logger.new(STDOUT)
      log.info "Source balance is #{Source.balance}"
      log.info "Destination balance is #{Destination.balance}"
      Destination.deposit amount
      Source.withdraw amount
      log.info "Source balance is now #{Source.balance}"
      log.info "Destination balance is now #{Destination.balance}"
    end
    def self.withdraw(amount)
      Source.decrease_balance amount
    end
  end

  module Destination
    extend Role::ClassMethods

    def self.deposit(amount) 
      Destination.increase_balance amount
    end
  end

  module Amount
    extend Role::ClassMethods
  end
end
