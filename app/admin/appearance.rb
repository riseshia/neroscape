ActiveAdmin.register Appearance do
  permit_params :creator_id, :game_id, :role_id

  index do
    selectable_column
    column 'ID' do |apperance|
      link_to apperance.id, admin_apperance_path(apperance)
    end
    column 'Creator' do |creator|
      link_to creator.name, admin_creator_path(creator)
    end
    column 'Game' do |game|
      link_to game.title, admin_game_path(game)
    end
    column 'Role' do |role|
      link_to role.name, admin_role_path(role)
    end
    column :updated_at
    column :created_at
    actions
  end
end
