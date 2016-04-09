require 'open-uri'
require 'nokogiri'

require 'getchu/parser/body_parser'
require 'getchu/parser/brand_parser'
require 'getchu/parser/head_parser'

# Sinnsi
module Sinnsi
  @base_url = 'http://www.getchu.com/soft.phtml?id='
  @search_url = 'http://www.getchu.com/all/month_title.html?genre=pc_soft&gage=adult'

  # ClassMethods
  module ClassMethods
    include Sinnsi::HeadParser
    include Sinnsi::BrandParser
    include Sinnsi::BodyParser

    def get_title(id)
      tries ||= 3
      begin
        Nokogiri::HTML(
          open(@base_url + id, 'Cookie' => 'getchu_adalt_flag=getchu.com; path=/'),
          nil, 'EUC-JP'
        )
      rescue
        retry unless (tries -= 1).zero?
      end
    end

    def get_month(day)
      tries ||= 3
      begin
        Nokogiri::HTML(
          open(
            @search_url + "&year=#{day.year}&month=#{day.month}",
            'Cookie' => 'getchu_adalt_flag=getchu.com; path=/'
          ), nil, 'EUC-JP').css('.product a.black')
      rescue
        retry unless (tries -= 1).zero?
      end
    end

    def parse_head(html_piece, id, data)
      data[:title] = html_piece.css('#soft-title').text
                               .gsub(/\n|\s|（このタイトルの関連商品）/, ' ').strip
      data[:getchu_id] = id
      data[:poster_url] = get_poster_url html_piece

      data[:price] = get_price html_piece
      data[:release_date] = html_piece.css('#tooltip-day').text
      data[:genre] = get_genre html_piece
      data
    end

    def parse_brand(html_piece, data)
      data[:brand_getchu_id] = get_brand_getchu_id html_piece
      data[:brand_name] = get_brand_name html_piece
      data[:brand_url] = get_brand_url html_piece
      data
    end

    def parse_body(html_piece, data)
      data[:gennga_list] = get_gennga html_piece
      data[:writer_list] = get_writer html_piece
      data[:artist] = get_artist html_piece
      data[:subgenre_list] = get_subgenre html_piece
      data[:category_list] = get_category html_piece
      data[:story] = get_story html_piece
      data[:char_list] = get_chars html_piece
      data
    end

    def parse(id)
      html_piece = get_title id
      data = {}

      parse_head html_piece, id, data
      parse_brand html_piece, data
      parse_body html_piece, data

      data
    end

    def find_node_in_table(html_piece, key)
      html_piece.css('tr').find do |node|
        node.css('td').first.text.start_with?(key) if node.css('td').first
      end
    end
  end

  extend ClassMethods
end
