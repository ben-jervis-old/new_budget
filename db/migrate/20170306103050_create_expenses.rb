class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.float :amount
      t.string :frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
