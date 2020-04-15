require 'line/bot'
class ButtonsController < ApplicationController
  protect_from_forgery :except => [:line_message]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def line_message

    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when "予約"
            message = {
                type: 'text',
                text: "予約ですね。 こちらからどうぞ　https://yago.host/"
            }
          when "決済"
            message = {
                type: 'text',
                text: "決済ですね。 YAGOはStripeを使っています。"
            }
          when "君じゃ話にならん！"
            message = {
                type: 'text',
                text: "社長を読んで参ります。"
            }
          end
          client.reply_message(event['replyToken'], message)
        end
      end

    end

    head :ok
  end
end
