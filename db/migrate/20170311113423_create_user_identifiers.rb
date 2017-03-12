class CreateUserIdentifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_identifiers do |t|
      t.references :user, index: true
      t.references :messenger, index: true
      t.string 	   :identifier
      t.timestamps
    end

     add_index :user_identifiers, [:user_id, :messenger_id], unique: true
  end
end
