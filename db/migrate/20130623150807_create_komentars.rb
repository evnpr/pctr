class CreateKomentars < ActiveRecord::Migration
  def change
    create_table :komentars do |t|
      t.integer :issue_id
      t.text :message
      t.integer :bermutu, :default => 0
      t.integer :biasa, :default => 0
      t.integer :gakmutu, :default => 0

      t.timestamps
    end
  end
end
