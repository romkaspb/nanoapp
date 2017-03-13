class Message < ApplicationRecord
	as_enum :status, [:new, :delivered, :failed]

	attr_accessor :delivery_at

	belongs_to :messenger
	belongs_to :sender, class_name: 'User'
	belongs_to :recipient, class_name: 'User'

	validates :messenger, :sender, :recipient, presence: true
	validate :prevent_dublicate
	validate :recipient_has_such_messenger

	def prevent_dublicate
		if Message.where( sender: sender, recipient: recipient, messenger: messenger ).select(:body).last.body.eql?(body)
			errors.add(:body, "Dublicate message")
		end
	end

	def recipient_has_such_messenger
		unless User::Identifier.where(user_id: recipient_id, messenger_id: messenger_id).exists?
			errors.add(:recipient_messenger_id, "no such messenger")
		end
	end

	def deliver
		return if self.delivered?

		if messenger.class.send_message
			self.status = :delivered
			self.delivered_at = Time.now
			self.failed_delivery_count = 0
		else
			self.status = :failed
			self.failed_delivery_count ||= 0
			self.failed_delivery_count += 1
		end

		self.save
	end
end
