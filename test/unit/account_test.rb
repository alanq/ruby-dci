require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "can initialise" do
   a = Account.new
   assert_instance_of Account, a
  end
  test "maps Ledger role to array object" do
    ctx = Account.new
    assert ctx.role_player.is_a? Hash
    assert ctx.role_player[Account::Ledgers].is_a? Array
  end
  test "init Account with ledger, role player for ledger" do
    ctx = Account.new(ledger_entries(:lodged))
    ledgers = ctx.role_player[Account::Ledgers]
    assert ledgers.count == 1
    assert_instance_of LedgerEntry, ledgers[0]
  end

  def init
    @ctx = Account.new([ledger_entries(:lodged), ledger_entries(:withdrawn)])
  end
  test "balance matches ledgers" do
    init
    assert @ctx.balance == ledger_entries(:lodged).amount + ledger_entries(:withdrawn).amount
  end
  test "increase balances" do
    init
    assert_difference('@ctx.balance', 92) { @ctx.increase_balance 92 }
  end
  test "decrease balance" do
    init
    assert_difference('@ctx.balance', -12.75) { @ctx.decrease_balance 12.75 }
  end
end
