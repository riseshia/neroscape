# GamesHelper
module GamesHelper
  def character_info(char)
    str = ''
    str += "<strong>#{char.name}</strong>"
    str += " CV: #{link_to char.creator.name, char.creator}" if char.creator_id
    str += '<br>'
    str += char.description.gsub("\n", '<br>') if char.description
    str + '<br>'
  end

  def categories_tag(categories)
    categories.map do |category|
      link_to category.name, category
    end.join('、').html_safe
  end
end
