class AddIndexToCustomersEmail < ActiveRecord::Migration[7.1]
  def change
    add_index :customers, :email, unique: true
  end
end
