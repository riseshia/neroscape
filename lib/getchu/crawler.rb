require 'open-uri'
require 'nokogiri'

class Sinnsi
  module ClassMethods
    def get_title id
      base_url = "http://www.getchu.com/soft.phtml?id="
        
      Nokogiri::HTML(open(base_url + id, "Cookie" => "getchu_adalt_flag=getchu.com; path=/"), nil, 'EUC-JP')
    end

    def get_month day
      page = Nokogiri::HTML(open("http://www.getchu.com/all/month_title.html?genre=pc_soft&gage=adult&year=#{day.year}&month=#{day.month}", "Cookie" => "getchu_adalt_flag=getchu.com; path=/"), nil, 'EUC-JP')
      list = page.css(".product a.black")
    end

    def parse id
      html_piece = get_title id
      data = {}
      
      # Default Information
      soft_title = /(.+)\s\n+$/.match(html_piece.css('#soft-title').text)[1].strip
      data[:title] = soft_title
      data[:getchu_id] = id

      highslide_url = ""
      if html_piece.css('#soft_table a.highslide').size > 0
        highslide_url = 'http://www.getchu.com' + html_piece.css('#soft_table a.highslide')[0].attr('href')[1..-1].strip
      end
      data[:poster_url] = highslide_url

      brand = html_piece.css('td').find{|node| node.css('a#brandsite').size == 1}
      brand_name = ""
      brand_url = ""
      brand_id = ""
      if brand
        brand_name = brand.css('a#brandsite').text.strip
        brand_url = brand.css('a#brandsite').attr('href').text.strip
        brand_id = /search_brand_id=([0-9]+)/.match(brand.css('nobr > a').attr('href').text)[1].strip
      else
        parent = self.find_node_in_table html_piece,'ブランド：'
        brand_name = parent.css('td')[1].text.gsub('（このブランドの作品一覧）', '').strip
        brand_id = /search_brand_id=([0-9]+)/.match(parent.css('td')[1].css('a').attr('href').text)[1]
      end
      data[:brand_getchu_id] = brand_id
      data[:brand_name] = brand_name
      data[:brand_url] = brand_url

      price_node = self.find_node_in_table html_piece,'定価：'
      price = /￥(\S+)/.match(price_node.css('td').last.text)[1].gsub(",","").strip
      data[:price] = price

      release_date = html_piece.css('#tooltip-day').text
      data[:release_date] = release_date

      genre_node = self.find_node_in_table html_piece,'ジャンル：'
      if genre_node
        genre = genre_node.css('td').last.text.strip
        data[:genre] = genre
      end

      # Second Information
      gennga_node = self.find_node_in_table html_piece,'原画：'
      if gennga_node
        gennga = []
        gennga_node.css('a').each do |node|
          name = node.text.strip
          gennga << node.text.strip if name != '他'
        end
        data[:gennga_list] = gennga
      end

      writer_node = self.find_node_in_table html_piece,'シナリオ：'
      if writer_node
        writer = []
        writer_node.css('a').each do |node|
          writer << node.text.strip
        end
        data[:writer_list] = writer
      end

      artist_node = self.find_node_in_table html_piece,'アーティスト：'
      if artist_node
        artist = artist_node.css('td').last.text.strip
        data[:artist] = artist
      end

      sub_genre_node = self.find_node_in_table html_piece,'サブジャンル'
      if sub_genre_node
        sub_genres = sub_genre_node.css('td').last.text.strip.gsub("[一覧]","").split("、")
        
        data[:subgenre_list] = sub_genres.map { |el| el.strip }
      end

      category_node = self.find_node_in_table html_piece,'カテゴリ'
      if category_node
        category = category_node.css('td').last.text.gsub("[一覧]","").split("、")

        data[:category_list] = category.map { |el| el.strip }
      end

      div = html_piece.css('div.tabletitle, div.tablebody')
      div.each_with_index do |node, idx|
        if node.text.include?("ストーリー")
          story = div[idx+1].text.strip
          data[:story] = story
        end
      end
      
      char_table = html_piece.css('div.tabletitle + table tr')
      chars = []
      char_table.each do |tr|
        next if tr.css('td[valign=middle]').size == 0
        nodes = tr.css('td')
        img_node = nodes[0].css('img')
        char_img_url = img_node.size != 0 ? 'http://www.getchu.com' + img_node.attr('src').text[1..-1] : ''
        name_cv = nodes[1].css('.chara-name').text.split('CV：')
        char_name = name_cv[0]
        char_cv = name_cv[1]
        char_text = nodes[1].css('dd').text()

        char = {}
        char[:char_name] = char_name
        char[:char_cv] = char_cv
        char[:char_img_url] = char_img_url
        char[:char_text] = char_text
        chars << char
      end
      data[:char_list] = chars

      data.each do |k, v|
        puts "#{k}: #{v}"
      end
      data
    end

    def find_node_in_table html_piece, key
      html_piece.css('tr').find{ |node|
        if node.css('td').first
          node.css('td').first.text.start_with?(key)
        else
          nil
        end
      }
    end
  end
  extend ClassMethods
end