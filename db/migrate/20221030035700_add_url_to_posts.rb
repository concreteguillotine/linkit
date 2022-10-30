class AddUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :url, :text
  end
end
