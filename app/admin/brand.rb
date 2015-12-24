ActiveAdmin.register Brand do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :homepage_url, :getchu_id
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
    column 'ID' do |brand|
      link_to brand.id, admin_brand_path(brand)
    end
    column :name
    column :homepage_url
    column :getchu_id
    column :updated_at
    column :created_at
    actions
  end
end
