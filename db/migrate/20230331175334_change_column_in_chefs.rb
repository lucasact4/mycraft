class ChangeColumnInChefs < ActiveRecord::Migration[7.0]
  def change
    rename_column :chefs, :name, :chefname
  end
end
