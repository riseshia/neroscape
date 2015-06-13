require_relative '../getchu/crawler.rb'

namespace :getchu do
  task :update => :environment do
    puts '--- Start to Working ---'
    puts '--- Get game list'
    
    today = Date.today
    list = Sinnsi.get_month(today) + Sinnsi.get_month(today.next_month)

    list.each do |game|
      id = /\d+/.match(game.attr('href'))[0]
      data = Sinnsi.parse id

      ActiveRecord::Base.transaction do
        # Hash check
        game = Game.find_by_getchu_id(data[:getchu_id])
        if game &&
            game.page_hash != data.page_hash &&
            game.release_date > Date.today &&
            game.reviews.size == 0
          # Destroy
          game.rel_game_categories.destroy_all
          game.rel_game_subgenres.destroy_all
          game.appearances.destroy_all
          game.characters.destroy_all
          game.destroy!
        elsif game
          # Not changed
          next
        end

        # Brand
        brand = Brand.new
        brand.name = data[:brand_name]
        brand.homepage_url = data[:brand_url]
        brand.getchu_id = data[:brand_getchu_id]
        brand.save!

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
        game.page_hash = data.hash.to_s
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
            role_name = (el.end_with?('（SD原画）') ? '（SD原画）' : '原画')
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
            role_name = 'CV'
            role = Role.find_by_name(role_name) || Role.new(name: role_name)
            role.save!
            creator = nil
            unless el[:char_cv].empty?
              creator = Creator.find_by_name(el[:char_cv]) || Creator.new(name: el[:char_cv])
              creator.save!
            end
            char = Character.new(name: el[:char_name], image_url: el[:char_img_url], game_id: game.id, creator_id: creator.id, description: el[:char_text]).save!

            Appearance.new(game_id: game.id, creator_id: creator.id, role_id: role.id).save!
          end
        end
      end

      sleep 1
    end

    puts '--- Finished ---'
  end
end
# today.strftime "%Y/%m/%d"