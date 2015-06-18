require_relative '../getchu/crawler.rb'

def md5(data)
  Digest::MD5.hexdigest(data.to_s)
end

def update_one_month(date)
  list = Sinnsi.get_month(date)

  list.each do |game|
    id = /\d+/.match(game.attr('href'))[0]
    puts "- Getchu Game '#{id}' is checking...."
    if id == '829543'
      puts "This game html cannot be parsed. skipped."
      next
    end
    data = Sinnsi.parse id

    ActiveRecord::Base.transaction do

      # Hash check
      game = Game.find_by_getchu_id(data[:getchu_id])
      if game &&
          game.page_hash != md5(data) &&
          game.reviews.size == 0
        puts "- Need to update. Destroy data..."
        # Destroy
        game.rel_game_categories.destroy_all
        game.rel_game_subgenres.destroy_all
        game.appearances.destroy_all
        game.characters.destroy_all
        game.destroy!
      elsif game
        puts "- No need to update. go to Next."
        # Not changed
        next
      end

      puts "- Insert data to DB."
      # Brand
      brand = Brand.find_by_name(data[:brand_name]) || Brand.new
      brand.name = data[:brand_name]
      brand.homepage_url = data[:brand_url]
      brand.getchu_id = data[:brand_getchu_id]
      brand.save!

      # Some data on 2001 has 0001.
      data[:release_date].gsub('0001','2001') if data[:release_date].start_with?('0001/01/01')

      # Game
      game = Game.new
      game.title = data[:title]
      game.poster_url = data[:poster_url]
      game.price = data[:price]
      game.genre = data[:genre]
      game.story = data[:story]
      game.brand_id = brand.id
      game.getchu_id = data[:getchu_id]
      game.release_date = Date.strptime(data[:release_date],'%Y/%m/%d')
      game.page_hash = md5(data)
      game.save!

      # Sub Genre
      if data[:subgenre_list]
        data[:subgenre_list].each do |el|
          next if el.empty?
          sg = Subgenre.find_by_name(el) || Subgenre.new(name: el)
          sg.save!
          RelGameSubgenre.new(game_id: game.id, subgenre_id: sg.id).save!
        end
      end

      # Category
      if data[:category_list]
        data[:category_list].each do |el|
          next if el.empty?
          ct = Category.find_by_name(el) || Category.new(name: el)
          ct.save!
          RelGameCategory.new(game_id: game.id, category_id: ct.id).save!
        end
      end

      # writer
      if data[:writer_list]
        data[:writer_list].each do |el|
          next if el.empty?
          role_name = 'シナリオ'
          role = Role.find_by_name(role_name) || Role.new(name: role_name)
          role.save!
          creator = Creator.find_by_name(el) || Creator.new(name: el)
          creator.save!
          Appearance.new(game_id: game.id, creator_id: creator.id, role_id: role.id).save!
        end
      end

      # gennga
      if data[:gennga_list]
        data[:gennga_list].each do |el|
          next if el.empty?
          role_name = (el.end_with?('（SD原画）') ? 'SD原画' : '原画')
          el.gsub!('（SD原画）','')

          role = Role.find_by_name(role_name) || Role.new(name: role_name)
          role.save!
          creator = Creator.find_by_name(el) || Creator.new(name: el)
          creator.save!
          Appearance.new(game_id: game.id, creator_id: creator.id, role_id: role.id).save!
        end
      end
      
      # artist
      if data[:artist]
        next if data[:artist].empty?
        role_name = 'アーティスト'
        role = Role.find_by_name(role_name) || Role.new(name: role_name)
        role.save!
        creator = Creator.find_by_name(data[:artist]) || Creator.new(name: data[:artist])
        creator.save!
        Appearance.new(game_id: game.id, creator_id: creator.id, role_id: role.id).save!
      end

      # Char
      if data[:char_list]
        data[:char_list].each do |el|
          creator = nil
          if el[:char_cv] && !el[:char_cv].empty?
            role_name = 'CV'
            role = Role.find_by_name(role_name) || Role.new(name: role_name)
            role.save!
            creator = Creator.find_by_name(el[:char_cv]) || Creator.new(name: el[:char_cv])
            creator.save!
            Appearance.new(game_id: game.id, creator_id: creator.try(:id), role_id: role.try(:id)).save!
          end
          char = Character.new(name: el[:char_name], image_url: el[:char_img_url], game_id: game.id, creator_id: creator.try(:id), description: el[:char_text]).save!
        end
      end

      puts "- '#{game.title}' is updated."
    end

    sleep 1
  end
end

namespace :getchu do
  task :update => :environment do
    puts '--- Start to Working ---'
    puts '--- Get game list'

    today = Date.today

    update_one_month(today)
    sleep 1
    # update_one_month(today.next_month)

    puts '--- Finished ---'
  end

  task :update_all => :environment do
    puts '--- Start to Working ---'

    date = Date.new(2002,12,1)
    today = Date.today

    while date < today
      update_one_month(date)
      sleep 1
      date = date.next_month
    end

    puts '--- Finished ---'
  end
end
# today.strftime "%Y/%m/%d"