class AddPayPeriodToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pay_period, :string
  end
end
