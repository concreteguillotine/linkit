class AddScopeToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :scope, :text, default: "orderedt"
  end
end
