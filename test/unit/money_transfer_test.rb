require 'test_helper'

class MoneyTransferTest < ActiveSupport::TestCase

  def setup
    @source = Account.new ledger_entries(:lodged)
    @destination = Account.new [ledger_entries(:lodged), ledger_entries(:withdrawn)]
    @amount = 42.50
    @ctx = MoneyTransfer.new @source, @destination, @amount
  end

  test "maps Source, Destination, Amount roles to init args" do
    assert @ctx.role_player.is_a? Hash
    assert @ctx.role_player[MoneyTransfer::Source] == @source
    assert @ctx.role_player[MoneyTransfer::Destination] == @destination
    assert @ctx.role_player[MoneyTransfer::Amount] == @amount
  end

  test "transfer succeeds" do
    assert_difference('@source.balance', -1 * @amount) { @ctx.trans }
    assert_difference('@destination.balance', @amount) { @ctx.trans }
  end
end
