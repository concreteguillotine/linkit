class AddCachedVotesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cached_votes_total, :integer, :default => 0
    add_index  :users, :cached_votes_total

    User.find_each { |p| p.update_cached_votes("like") }
  end
end
