# lib/messaging.rb
#

module Messaging
  def write(message, speed = 0.05)
    message.each_char do |c|
      putc c
      sleep speed
    end
  end
end
