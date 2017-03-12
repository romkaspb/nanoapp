class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    message.deliver
  end
end
