class RenameChefsToPlayers < ActiveRecord::Migration[7.0]
  def change
    rename_table :chefs, :players
    rename_column :players, :chefname, :playername
    rename_table :ingredients, :items
    rename_table :recipe_ingredients, :post_items
    rename_column :post_items, :recipe_id, :post_id
    rename_column :post_items, :ingredient_id, :item_id
    rename_table :recipes, :posts
    rename_column :posts, :chef_id, :player_id
    rename_column :comments, :chef_id, :player_id
    rename_column :comments, :recipe_id, :post_id
  end
end