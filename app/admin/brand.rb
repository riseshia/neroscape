ActiveAdmin.register Brand do
  permit_params :name, :homepage_url, :getchu_id

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
