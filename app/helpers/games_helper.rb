module GamesHelper
  def character_info char
    str = ""
    str += "<strong>#{char.name}</strong>"
    if char.creator_id
      str += " CV: #{char.creator.name}"
    end
    str += '<br>'
    if char.description
      str += char.description.gsub("\n", '<br>')
    end
    str + '<br>'
  end
end
