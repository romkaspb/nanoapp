class CreateMessengers < ActiveRecord::Migration[5.0]
  def change
    create_table :messengers do |t|
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
