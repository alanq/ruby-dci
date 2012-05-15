class CreateLedgerEntries < ActiveRecord::Migration
  def change
    create_table :ledger_entries do |t|
      t.string :message
      t.decimal :amount

      t.timestamps
    end
  end
end
