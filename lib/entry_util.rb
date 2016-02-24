# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# HTMLをパースするためのライブラリを読み込む
require 'nokogiri'

class EntryUtil

  OfficialSiteUrl = "http://blog.keyakizaka46.com/mob/news/diarKiji.php?site=k46&cd=member"
  BaseUrl = "http://blog.keyakizaka46.com"

  def self.parsepage(url, need_loop)
    puts "parsepage start"
    # http://blog.keyakizaka46.com/mob/news/diarKiji.php?site=k46&ima=2653&cd=member&ct=01
    page = Nokogiri::HTML(open(url))
    page.css('div.kiji').each do |kiji|
      puts "kiji_parse"
      data = {}
      # title
      data[:yearmonth] =  kiji.css('td.date').css('span.kiji_yearmonth')[0].text
      data[:day] =  kiji.css('td.date').css('span.kiji_day')[0].text
      data[:week] =  kiji.css('td.date').css('span.kiji_week')[0].text

      data[:title] =  kiji.css('td.title').css('span.kiji_title')[0].text
      data[:body] = kiji.css('div.kiji_body')

      data[:image_url_list] = Array.new()
      data[:body].css('img').each do |img|
        if img[:src].empty? then
          # do nothing
        else
          image_url = BaseUrl + img[:src]
          data[:body] = "#{data[:body]}".gsub(img[:src], image_url)
          data[:image_url_list].push(image_url)
        end
      end
      
      data[:member_id] = to_member_id(url)
      data[:published] = kiji.css('div.kiji_foot')[0].text.gsub(/(\r\n|\r|\n|\f)/,"")
      yield(data) if block_given?
    end
    
    return if !need_loop
    
    if page.css('li.next').css('a')[0] != nil then
      puts "nextpage"
      next_url = page.css('li.next').css('a')[0][:href]
      parsepage("#{BaseUrl}#{next_url}", true) { |data|
        yield(data) if block_given?
      } if next_url != nil
    else
      puts "finish"
    end
  end
  
  def self.to_member_id(url)
    url_splited = url.split("=")
    url_id = url_splited[url_splited.length - 1]
    
    Member.all.each do |member|
      splited = member.blog_url.split("=")
      member_id = splited[splited.length - 1]
      return member.id if member_id == url_id
    end
  end

  def self.crawlpage(need_loop)
    Member.all.each do |member|
    puts "crawlpage start"
      parsepage(member.blog_url, need_loop) { |data|
        Entry.create(title: data[:title], body: data[:body], yearmonth: data[:yearmonth], week: data[:week], day: data[:day], member_id: data[:member_id], published: data[:published], image_url_list: data[:image_url_list].to_json.to_s)
      }
    end
  end

  def self.get_all_entry
    crawlpage(true)
  end
  
  def self.clear
    Entry.all.each do |e|
      e.destroy
    end
  end

end