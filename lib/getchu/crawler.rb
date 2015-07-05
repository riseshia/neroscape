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

    def get_poster_url html_piece
      if html_piece.css('#soft_table a.highslide').size > 0
        'http://www.getchu.com' + html_piece.css('#soft_table a.highslide')[0].attr('href')[1..-1].strip
      else
        ''
      end
    end

    def get_brand_getchu_id html_piece
      brand_piece = html_piece.css('td').find{|node| node.css('a#brandsite').size == 1}
      if brand_piece
        /search_brand_id=([0-9]+)/.match(brand_piece.css('nobr > a').attr('href').text)[1].strip
      else
        parent = self.find_node_in_table html_piece,'ブランド：'
        /search_brand_id=([0-9]+)/.match(parent.css('td')[1].css('a').attr('href').text)[1]
      end
    end

    def get_brand_name html_piece
      brand_piece = html_piece.css('td').find{|node| node.css('a#brandsite').size == 1}
      if brand_piece
        brand_piece.css('a#brandsite').text.strip
      else
        parent = self.find_node_in_table html_piece,'ブランド：'
        parent.css('td')[1].text.gsub('（このブランドの作品一覧）', '').strip
      end
    end

    def get_brand_url html_piece
      brand_piece = html_piece.css('td').find{|node| node.css('a#brandsite').size == 1}
      if brand_piece
        brand_piece.css('a#brandsite').attr('href').text.strip
      else
        ''
      end
    end

    def get_price html_piece
      price_node = self.find_node_in_table html_piece,'定価：'
      rexp = /￥(\S+)/.match(price_node.css('td').last.text)
      if rexp
        /￥(\S+)/.match(price_node.css('td').last.text)[1].gsub(",","").strip
      else
        nil
      end
    end

    def get_genre html_piece
      genre_node = self.find_node_in_table html_piece,'ジャンル：'
      if genre_node
        genre_node.css('td').last.text.strip
      else
        nil
      end
    end

    def get_gennga html_piece
      gennga_node = self.find_node_in_table html_piece,'原画：'
      if gennga_node
        gennga = []
        gennga_node.css('a').each do |node|
          name = node.text.strip
          gennga << node.text.strip if name != '他'
        end
        gennga
      else
        nil
      end
    end

    def get_writer html_piece
      writer_node = self.find_node_in_table html_piece,'シナリオ：'
      if writer_node
        writer = []
        writer_node.css('a').each do |node|
          writer << node.text.strip
        end
        writer
      else
        nil
      end
    end

    def get_artist html_piece
      artist_node = self.find_node_in_table html_piece,'アーティスト：'
      if artist_node
        artist_node.css('td').last.text.strip
      else
        nil
      end
    end

    def get_subgenre html_piece
      subgenre_node = self.find_node_in_table html_piece,'サブジャンル'
      if subgenre_node
        subgenres = subgenre_node.css('td').last.text.strip.gsub("[一覧]","").split("、")
        subgenres.map { |el| el.strip }
      else
        nil
      end
    end

    def get_category html_piece
      category_node = self.find_node_in_table html_piece,'カテゴリ'
      if category_node
        category = category_node.css('td').last.text.gsub("[一覧]","").split("、")
        category.map { |el| el.strip }
      else
        nil
      end
    end

    def get_story html_piece
      div = html_piece.css('div.tabletitle, div.tablebody')
      story = nil
      div.each_with_index do |node, idx|
        if node.text && node.text.strip.end_with?("ストーリー")
          story = div[idx+1].text.strip
          break
        end
      end
    end

    def get_chars html_piece
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
      chars
    end

    def parse id
      html_piece = get_title id
      data = {}
      
      # Default Information
      data[:title] = html_piece.css('#soft-title').text.gsub(/\n|\s|（このタイトルの関連商品）/," ").strip
      data[:getchu_id] = id
      data[:poster_url] = get_poster_url html_piece

      data[:brand_getchu_id] = get_brand_getchu_id html_piece
      data[:brand_name] = get_brand_name html_piece
      data[:brand_url] = get_brand_url html_piece

      data[:price] = get_price html_piece
      data[:release_date] = html_piece.css('#tooltip-day').text
      data[:genre] = get_genre html_piece

      # Second Information
      data[:gennga_list] = get_gennga html_piece
      data[:writer_list] = get_writer html_piece
      data[:artist] = get_artist html_piece
      data[:subgenre_list] = get_subgenre html_piece
      data[:category_list] = get_category html_piece
      data[:story] = get_story html_piece
      data[:char_list] = get_chars html_piece

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