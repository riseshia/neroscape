module Sinnsi
  # BodyParser
  module BodyParser
    def get_gennga(html_piece)
      gennga_node = find_node_in_table html_piece, '原画：'
      return unless gennga_node
      gennga = []
      gennga_node.css('a').each do |node|
        name = node.text.strip
        gennga << node.text.strip if name != '他'
      end
      gennga
    end

    def get_writer(html_piece)
      writer_node = find_node_in_table html_piece, 'シナリオ：'
      return unless writer_node
      writer = []
      writer_node.css('a').each do |node|
        writer << node.text.strip
      end
      writer
    end

    def get_artist(html_piece)
      artist_node = find_node_in_table html_piece, 'アーティスト：'
      artist_node.css('td').last.text.strip if artist_node
    end

    def get_subgenre(html_piece)
      subgenre_node = find_node_in_table html_piece, 'サブジャンル'
      return unless subgenre_node

      subgenres = subgenre_node.css('td').last.text
                  .strip.gsub('[一覧]', '').split('、')
      subgenres.map(&:strip)
    end

    def get_category(html_piece)
      category_node = find_node_in_table html_piece, 'カテゴリ'
      return unless category_node

      category = category_node.css('td').last.text.delete('[一覧]').split('、')
      category.map(&:strip)
    end

    def get_story(html_piece)
      div = html_piece.css('div.tabletitle, div.tablebody')
      story = nil
      div.each_with_index do |node, idx|
        if node.text && node.text.strip.end_with?('ストーリー')
          story = div[idx + 1].text.strip
          break
        end
      end
      story
    end

    def extract_img_url_from_char(img_node)
      if img_node.size != 0
        'http://www.getchu.com' +
          img_node.attr('src').text[1..-1]
      else
        ''
      end
    end

    def get_char(tr)
      nodes = tr.css('td')
      char_img_url = extract_img_url_from_char nodes[0].css('img')
      name_cv = nodes[1].css('.chara-name').text.split('CV：')

      {
        char_name: name_cv[0],
        char_cv: name_cv[1],
        char_img_url: char_img_url,
        char_text: nodes[1].css('dd').text
      }
    end

    def get_chars(html_piece)
      char_table = html_piece.css('div.tabletitle + table tr')
      chars = []
      char_table.each do |tr|
        next if tr.css('td[valign=middle]').size == 0
        chars << get_char(tr)
      end
      chars
    end
  end
end
