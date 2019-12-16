require "sinatra"
require 'twilio-ruby'
require 'dotenv/load'

account_sid = ENV['TWILIO_ACCOUNT_SID']
from = ENV['TWILIO_FROM_PHONE']

post '/send' do
    request.body.rewind
    data = JSON.parse(request.body.read)
    client = Twilio::REST::Client.new(account_sid, data['authToken'])
    case data['type']
    when 'sms'
        client.messages.create(
            from: from,
            to: data['to'],
            body: data['message']
        )
    when 'whatsapp'
        client.messages.create(
            from: "whatsapp:#{from}",
            to: "whatsapp:#{data['to']}",
            media_url: data['mediaUrl'],
            body: data['message']
        )
    end
end