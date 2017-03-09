class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references 	:user, index: true
      t.text 		:body
      t.string 		:recipient, index: true
      t.integer 	:recipient_messager_cd
      t.boolean 	:sended

      t.timestamps
    end

    add_index :messages, [ :user_id, :sended ]
  end
end
