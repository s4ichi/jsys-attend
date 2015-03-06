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
        @reps ||= []
        @reps << "ping"
        message.reply(reps.join(","))
      end
    end
  end
end
