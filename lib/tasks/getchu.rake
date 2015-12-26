require_relative '../getchu/sinnsi.rb'

def md5(data)
  Digest::MD5.hexdigest(data.to_s)
end

def update_one_month(date)
  list = Sinnsi.get_month(date)

  list.each do |game|
    id = /\d+/.match(game.attr('href'))[0]
    puts "- Getchu Game '#{id}' is checking...."
    if id == '829543'
      puts 'This game html cannot be parsed. skipped.'
      next
    end
    data = Sinnsi.parse id

    ActiveRecord::Base.transaction do
      # Hash check
      game = Game.find_by_getchu_id(data[:getchu_id])
      if game &&
         game.page_hash != md5(data) &&
         game.reviews.size == 0
        puts '- Need to update.'
      elsif game
        puts '- No need to update. go to Next.'
        # Not changed
        next
      end

      puts '- Insert data to DB.'
      # Brand
      brand = Brand.find_or_create_by!(name: data[:brand_name]) do |obj|
        obj.name = data[:brand_name]
        obj.homepage_url = data[:brand_url]
        obj.getchu_id = data[:brand_getchu_id]
      end

      # Some data on 2001 has 0001.
      if data[:release_date].start_with?('0001/01/01')
        data[:release_date].gsub('0001', '2001')
      end

      # Game
      game = Game.find_or_create_by!(getchu_id: data[:getchu_id]) do |obj|
        obj.title = data[:title]
        obj.poster_url = data[:poster_url]
        obj.price = data[:price]
        obj.genre = data[:genre]
        obj.story = data[:story]
        obj.brand_id = brand.id
        obj.getchu_id = data[:getchu_id]
        obj.release_date = Date.strptime(data[:release_date], '%Y/%m/%d')
        obj.page_hash = md5(data)
      end

      # Sub Genre
      if data[:subgenre_list]
        RelGameSubgenre.where(game_id: game.id).destroy_all
        data[:subgenre_list].each do |el|
          next if el.empty?
          sg = Subgenre.find_or_create_by!(name: el)
          RelGameSubgenre.create!(game_id: game.id, subgenre_id: sg.id)
        end
      end

      # Category
      if data[:category_list]
        RelGameCategory.where(game_id: game.id).destroy_all
        data[:category_list].each do |el|
          next if el.empty?
          ct = Category.find_or_create_by!(name: el)
          RelGameCategory.create!(game_id: game.id, category_id: ct.id)
        end
      end

      Appearance.where(game_id: game.id).destroy_all

      # writer
      if data[:writer_list]
        data[:writer_list].each do |el|
          next if el.empty?
          role_name = 'シナリオ'
          role = Role.find_or_create_by!(name: role_name)
          creator = Creator.find_or_create_by!(name: el)
          Appearance.create!(
            game_id: game.id,
            creator_id: creator.id,
            role_id: role.id
          )
        end
      end

      # gennga
      if data[:gennga_list]
        data[:gennga_list].each do |el|
          next if el.empty?
          role_name = (el.end_with?('（SD原画）') ? 'SD原画' : '原画')
          el.gsub!('（SD原画）', '')

          role = Role.find_or_create_by!(name: role_name)
          creator = Creator.find_or_create_by!(name: el)
          Appearance.create!(
            game_id: game.id,
            creator_id: creator.id,
            role_id: role.id
          )
        end
      end

      # artist
      if data[:artist]
        next if data[:artist].empty?
        role_name = 'アーティスト'
        role = Role.find_or_create_by!(name: role_name)
        creator = Creator.find_or_create_by!(name: data[:artist])
        Appearance.create!(
          game_id: game.id,
          creator_id: creator.id,
          role_id: role.id
        )
      end

      # Char
      if data[:char_list]
        Character.where(game_id: game.id).destroy_all
        data[:char_list].each do |el|
          creator = nil
          if el[:char_cv] && !el[:char_cv].empty?
            role_name = 'CV'
            role = Role.find_or_create_by!(name: role_name)
            creator = Creator.find_or_create_by!(name: el[:char_cv])
            Appearance.create!(
              game_id: game.id,
              creator_id: creator.try(:id),
              role_id: role.try(:id)
            )
          end
          Character.create!(
            name: el[:char_name],
            image_url: el[:char_img_url],
            game_id: game.id,
            creator_id: creator.try(:id),
            description: el[:char_text]
          )
        end
      end

      puts "- '#{game.title}' is updated."
    end

    sleep 1
  end
end

namespace :getchu do
  task update: :environment do
    puts '--- Start to Working ---'
    puts '--- Get game list'

    today = Time.zone.today

    update_one_month(today)
    sleep 1
    update_one_month(today.next_month)

    puts '--- Finished ---'
  end

  task update_all: :environment do
    puts '--- Start to Working ---'

    date = Date.new(2002, 12, 1)
    today = Time.zone.today

    while date < today
      update_one_month(date)
      sleep 1
      date = date.next_month
    end

    puts '--- Finished ---'
  end
end
