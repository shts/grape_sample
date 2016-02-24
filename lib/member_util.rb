# -*- coding: utf-8 -*-

# URLにアクセスするためのライブラリを読み込む
require 'open-uri'

# HTMLをパースするためのライブラリを読み込む
require 'nokogiri'

# メンバーを作成するクラス
# https://hackhands.com/rails-nameerror-uninitialized-constant-class-solution/
class MemberUtil
    
    
  BaseUrl = "http://www.keyakizaka46.com"
  BaseBlogUrl = "http://blog.keyakizaka46.com/mob/news/diarKiji.php?site=k46&ima=2653&cd=member&ct="
  ParseClassName = "Member"
  
  def self.initialize
    member_counter = 0
    fetch { |data|
      member_counter = member_counter + 1
      # 辞退したメンバーのidはスキップする
      if member_counter == 16
        member_counter = member_counter + 1
      end

      data[:blog_url] = to_blog_url(member_counter)
      if Member.where("blog_url = ?", data[:blog_url]).count == 0 then
        Member.create(birthday: data[:birthday], birthplace: data[:birthplace], blog_url: data[:blog_url], blood_type: data[:blood_type], constellation: data[:constellation], height: data[:height], image_url: data[:image_url], name_main: data[:name_main], name_sub: data[:mane_sub])
      else
        puts "already registration"
      end
    }
  end
  
  def self.clear
    Member.all.each do |member|
      member.destroy
    end
  end

  def self.fetch
    doc = Nokogiri::HTML(open(BaseUrl))
    doc.css('div#member').css('div.popup_win').each do |member|
      data = { :name_sub => nil,
               :name_main => nil,
               :image_url => nil,
               :birthday => nil,
               :bloodtype => nil,
               :constellation => nil,
               :height => nil
      }
      data[:name_sub] = member.css('p.popup_title_en').text
      data[:name_main] = member.css('p.popup_title').text
      data[:image_url] = BaseUrl + "/#{member.css('div.popup_img').css('img').first[:src]}"
      counter = 0
      member.css('div.popup_detail').css('dl').css('dd').each do |child|
        if counter == 0 then
          data[:birthday] = child.text.gsub("年", "/").gsub("月", "/").gsub("日", "")
        elsif counter == 1
          data[:bloodtype] = child.text
        elsif counter == 2
          data[:constellation] = child.text
        elsif counter == 3
          data[:birthplace] = child.text
        elsif counter == 4
          data[:height] = child.text
        end
        counter = counter + 1
      end
      yield(data) if block_given?
    end
  end

  def self.to_blog_url(member_counter)
    if member_counter < 10
      return "#{BaseBlogUrl}0#{member_counter}"
    else
      return "#{BaseBlogUrl}#{member_counter}"
    end
  end

end
