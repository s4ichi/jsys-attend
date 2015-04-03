# coding: utf-8
module Ruboty
  module Handlers
    class Attend < Base
      NAMESPACE = "attend"
      ROLE = { attend: "出席", absent: "欠席" }
      ADMIN = []

      on(
        /出席\s?(?<desc>.+?)\z/,
        name: "new_attend",
        description: "新たに出席をとります"
      )

      on(
        /状態\s?(?<ch>(\d)+?)\z/,
        name: "current_state",
        description: "指定したChの出席状況を確認します"
      )
      
      on(
        /締切\s?(?<ch>(\d)+?)\z/,
        name: "end_attend",
        description: "指定したChの出席受付を締め切ります"
      )

      on(
        /一覧\z/,
        name: "dash_board",
        description: "Chごとの出席状況を確認します"
      )

      on(
        /出\s?(?<ch>(\d)+?)\z/,
        name: "attend_user",
        description: "指定したChに出席します"
      )

      on(
        /欠\s?(?<ch>(\d)+?)\z/,
        name: "absent_user",
        description: "指定したChに欠席します"
      )

      on(
        /闇の炎に抱かれて消えろ\z/,
        name: "clear_all",
        description: "危険"
      )

      def new_attend(message)
        begin 
          new_ch_num = create_new_ch
          attend_table[new_ch_num] = {}
          attend_ch[new_ch_num] = message[:desc]
          message.reply("新規出席Chを設立しました！\n Ch.No. -> #{new_ch_num}, Detail -> #{attend_ch[new_ch_num]}")
        rescue => e
          message.reply(e.message)
        end
      end

      def current_state(message)
        begin 
          current_ch = message[:ch].to_i
          message.reply(current_message(current_ch))
        rescue => e
          message.reply(e.message)
        end
      end

      def end_attend(message)
        begin 
          current_ch = message[:ch].to_i
          result_message = current_message(current_ch)
          attend_table.delete(current_ch)
          attend_ch.delete(current_ch)
          message.reply(result_message)
        rescue => e
          message.reply(e.message)
        end
      end

      def dash_board(message)
        begin
          result_message = "Ch毎の出席一覧だよ！\n"
          attend_ch.keys.each do |ch_num|
            result_message += current_message(ch_num)
          end
          message.reply(result_message)
        rescue => e
          message.reply(e.message)
        end
      end
      
      def attend_user(message)
        begin
          message.reply(divide_user(:attend, message))
        rescue => e
          message.reply(e.message)
        end
      end

      def absent_user(message)
        begin
          message.reply(divide_user(:absent, message))
        rescue => e
          message.reply(e.message)
        end
      end

      def clear_all(message)
        if ADMIN.index(message.from_name).nil?
          message.reply('君に権限はないよ！')
        else
          robot.brain.data[NAMESPACE + "_table"] = {}
          robot.brain.data[NAMESPACE + "_ch"] = {}
          message.reply("ダークフレイムマスター！！！！！！！！！")
        end
      end
      
      private

      def divide_user(state, message)
        current_ch = message[:ch].to_i
        
        if ch_exist?(current_ch)
          return "Ch.#{current_ch}は存在しないよっ！"
        end
        
        attend_table[current_ch].merge!({ message.from_name => state })
        "#{attend_ch[current_ch]}に#{ROLE[state]}っ！"
      end

      def ch_exist?(ch_num)
        attend_table[ch_num].nil?
      end

      def current_message(current_ch)
        if ch_exist?(current_ch)
          return "Ch.#{current_ch}は存在しないよっ！"
        end

        attend_counter = 0
        ret_message = "[Ch.#{current_ch}, #{attend_ch[current_ch]}]\n"
        attend_table[current_ch].each do |key, val|
          ret_message += "#{key.to_s}: #{ROLE[val]}\n"
          attend_counter += 1 if val == :attend
        end
        
        ret_message + "出席人数: #{attend_counter}\n"
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

      def sanitize_message_body(message)
        message.body.slice!("@attendbot: ")
      end
    end
  end
end
