class HandleMessageJob < ApplicationJob
  queue_as :default

  def perform(messages)
    messages.each do |message|
    	delivery_at = message.delete(:delivery_at)

    	if message.save
    		if delivery_at.present? and delivered_at.to_datetime
    			SendMessageJob.set(wait_until: delivery_at.to_datetime).perform_later(message)
    		else
    			SendMessageJob.perform_later(message)
    		end
    	end
    end
  end
end
