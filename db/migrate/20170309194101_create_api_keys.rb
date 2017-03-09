class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
     create_table :api_keys, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.string :access_token
      t.datetime :expires_at
      t.datetime :last_access
      t.datetime :created_at
      t.boolean :locked, default: false
    end

    add_index :api_keys, :access_token, unique: true
  end
end
