module Sinnsi
  # HeadParser
  module HeadParser
    def get_genre(html_piece)
      genre_node = find_node_in_table html_piece, 'ジャンル：'
      return unless genre_node

      genre_node.css('td').last.text.strip
    end

    def get_poster_url(html_piece)
      if html_piece.css('#soft_table a.highslide').size > 0
        'http://www.getchu.com' + html_piece.css('#soft_table a.highslide')[0]
          .attr('href')[1..-1].strip
      else
        ''
      end
    end

    def get_price(html_piece)
      price_node = find_node_in_table html_piece, '定価：'
      rexp = /￥(\S+)/.match(price_node.css('td').last.text)
      return unless rexp
      /￥(\S+)/.match(price_node.css('td').last.text)[1].delete(',').strip
    end
  end
end
