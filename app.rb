# coding: utf-8
module Ruboty
  module Handlers
    class Attend < Base
      NAMESPACE = "attend"
      ROLE = { attend: "出席", absent: "欠席" }
      
      on(
        /出席/i,
        name: "new_attend",
        description: "Return PONG to PING"
      )

      on(
        /状態\s?(\d){1,}/i,
        name: "current_state",
        description: "Return PONG to PING"
      )
      
      on(
        /締切\s?(,?(\d){1,})+/i,
        name: "end_attend",
        description: "Return PONG to PING"
      )

      on(
        /一覧/i,
        name: "dash_board",
        description: "Return PONG to PING"
      )

      on(
        /出\s?(,?(\d){1,})+/i,
        name: "attend_user",
        description: "attend target groups"
      )

      on(
        /欠\s?(,?(\d){1,})+/i,
        name: "absent_user",
        description: "absent target groups"
      )

      def new_attend(message)
        new_ch_num = create_new_ch
        attend_table[new_ch_num] = {}
        attend_ch[new_ch_num] = message.body[2..(message.body.length)].strip
        message.reply("新規出席Chを設立しました！\n Ch.No. -> #{new_ch_num}, Detail -> #{attend_ch[new_ch_num]}")
      end

      def current_state(message)
        current_ch = message.body.to_i
        message.reply(current_message(current_ch))
      end

      def end_attend(message)
        current_ch = message.to_i
        result_message = current_messag(current_ch)
        attend_table[current_ch] = nil
        attend_ch[current_ch] = nil
        message.reply(result_message)
      end

      def dash_board(message)
        result_message = "Ch毎の出席一覧だよ！\n"
        attend_ch.keys.each do |ch_num|
          result_message += current_message(ch_num)
        end
        message.reply(result_message)
      end
     
      def attend_user(message)
        begin
          message.reply(divide_user(:attend))
        rescue => e
          message.reply("エラーっぽいっ!")
        end
      end

      def absent_user(message)
        begin
          message.reply(divide_user(:absent))
        rescue => e
          message.reply("エラーっぽいっ!")
        end
      end

      private
      def divide_user(state)
        groups = message.body.split(",").map! {|hoge| hoge.to_i}.compact
        groups.each do |group_num|
          if ch_exist?(group_num)
            return "Ch.#{group_num}は存在しないよっ！"
          end

          attend_table[group_num].merge({ message.from_name => state })
        end
        groups.join(",") + "に#{ROLE[state]}っ！"
      end

      def ch_exist?(ch_num)
        attend_table[ch_num].nil?
      end

      def current_message(current_ch)
        if ch_exist?(current_hch)
          message.reply("Ch.#{group_num}は存在しないよっ！")
        end

        ret_message = "[Ch.#{current_ch}, #{attend_ch[current_ch]}]\n"
        attend_table[current_ch].each do |key, val|
          ret_message += "#{key.to_s}: #{ROLE[val]}\n"
        end
        
        ret_message
      end
      
      def attend_table
        robot.brain.data[NAMESPACE + "_table"] ||= {}
      end

      def attend_ch
        robot.brain.data[NAMESPACE + "_ch"] ||= {}
      end

      def create_new_ch
        (1..100).to_a.select {|num| !attend_ch.keys.include?(num)}.first
      end
    end
  end
end
