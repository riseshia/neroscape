ActiveAdmin.register Appearance do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :creator_id, :game_id, :role_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
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
