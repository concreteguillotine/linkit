class AddYoutubeUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :youtubeurl, :text
  end
end
