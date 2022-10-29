class AddReplyToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :reply, foreign_key: { to_table: :comments }
  end
end
