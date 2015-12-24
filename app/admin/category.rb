ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    column 'ID' do |category|
      link_to category.id, admin_category_path(category)
    end
    column :name
    column :updated_at
    column :created_at
    actions
  end
end
