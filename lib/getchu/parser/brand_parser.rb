module Sinnsi
  # BrandParser
  module BrandParser
    def get_brand_getchu_id(html_piece)
      parent = find_node_in_table html_piece, 'ブランド：'
      result = /search_brand_id=([0-9]+)/.match(parent.css('td')[1].css('a').last.attr('href'))
      result[1].strip if result
    end

    def get_brand_name(html_piece)
      parent = find_node_in_table html_piece, 'ブランド：'
      parent.css('td')[1].text.delete('（このブランドの作品一覧）').strip
    end

    def get_brand_url(html_piece)
      brand_piece = get_brand_node html_piece
      brand_piece.css('a#brandsite').attr('href').text.strip if brand_piece
    end

    def get_brand_node(html_piece)
      html_piece.css('td').find { |node| node.css('a#brandsite').size == 1 }
    end
  end
end
