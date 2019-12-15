require "sinatra"
require 'twilio-ruby'
require 'dotenv/load'

account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
client = Twilio::REST::Client.new(account_sid, auth_token)

from = ENV['TWILIO_FROM_PHONE']
to = ENV['TWILIO_TO_PHONE']

post "/send-sms" do
    request.body.rewind
    data = JSON.parse request.body.read
    client.messages.create(
        from: from,
        to: to,
        body: data['message']
    )
end