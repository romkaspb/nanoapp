class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer     :sender_id,    index: true
      t.integer     :recipient_id, index: true
      t.references  :messenger
      t.text 		    :body
      t.integer     :status_cd, default: 0
      t.integer     :failed_delivery_count, default: 0
      t.datetime    :delivered_at, default: nil 

      t.timestamps
    end

    add_index :messages, [ :sender_id, :recipient_id ]
  end
end
