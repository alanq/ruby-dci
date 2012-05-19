require 'test_helper'

class LedgerEntryTest < ActiveSupport::TestCase
   test "ledger saves" do
     l = ledger_entries(:lodged)
     assert l.save
     assert_instance_of LedgerEntry, l 
     assert_equal 'a lodgement', l.message
     assert is_numeric(l.amount)
     assert_operator l.amount, :>, 0
   end

end
