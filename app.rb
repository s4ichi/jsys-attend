# coding: utf-8
module Ruboty
  module Handlers
    class Pong < Base
      on(
        /pong\z/i,                         # "@ellen ping"に反応して
        name: "ping",                      # #pingメソッドが呼ばれる
        description: "Return PONG to PING" # これは"@ellen help"でhelpを表示したとき説明文として表示される
      )

      def ping(message)
        message.reply("pong")
      end
    end
  end
end
