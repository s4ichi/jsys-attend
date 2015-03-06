# coding: utf-8
module Ruboty
  module Handlers
    class Pong < Base
      
      on(
        /pong\z/i,
        name: "ping",
        description: "Return PONG to PING"
      )

      def ping(message)
        table[:pong] ||= ""
        table[:pong] += "ping"
        message.reply(table[:pong])
      end
    end
  end
end
