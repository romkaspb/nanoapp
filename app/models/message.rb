class Message < ApplicationRecord
	as_enum :status, [:new, :delivered, :failed]

	attr_accessor :delivery_at

	belongs_to :messenger
	belongs_to :sender, class_name: 'User'
	belongs_to :reciver, class_name: 'User'

	validates :messenger, :sender, :reciver, presence: true
	validate :prevent_dublicate
	validate :recipient_has_such_messenger

	def prevent_dublicate
		unless Message.where( sender: sender, recipient: reciver, messenger: messenger ).select(:body).limit(1).order(:created_at).first.eql?(body)
			errors.add(:body, "Dublicate message")
		end
	end

	def recipient_has_such_messenger
		unless User::Identifier.where(user_id: recipient_id, messenger_id: messenger_id).exists?
			errors.add(:recipient_messenger_id, "no such messenger")
		end
	end

	def deliver
		if messenger.class.send_message
			status = :delivered
			touch :deliveried_at
		else
			status = :failed
			increment(:failed_delivery_count)
		end

		save
	end
end
