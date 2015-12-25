module Sinnsi
  # BrandParser
  module BrandParser
    def get_brand_getchu_id(html_piece)
      brand_piece = get_brand_node html_piece
      regexp = /search_brand_id=([0-9]+)/
      if brand_piece
        regexp.match(brand_piece.css('nobr > a').attr('href').text)[1].strip
      else
        parent = find_node_in_table html_piece, 'ブランド：'
        regexp.match(parent.css('td')[1].css('a').attr('href').text)[1]
      end
    end

    def get_brand_name(html_piece)
      brand_piece = get_brand_node html_piece
      if brand_piece
        brand_piece.css('a#brandsite').text.strip
      else
        parent = find_node_in_table html_piece, 'ブランド：'
        parent.css('td')[1].text.delete('（このブランドの作品一覧）').strip
      end
    end

    def get_brand_url(html_piece)
      brand_piece = get_brand_node html_piece
      if brand_piece
        brand_piece.css('a#brandsite').attr('href').text.strip
      else
        ''
      end
    end

    def get_brand_node(html_piece)
      html_piece.css('td').find { |node| node.css('a#brandsite').size == 1 }
    end
  end
end
