ActiveAdmin.register User do
  permit_params :email, :name, :level

  index do
    selectable_column
    column 'ID' do |user|
      link_to user.id, admin_user_path(user)
    end
    column :email
    column :name
    column :level
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs 'Details' do
      input :email
      input :name
      input :level
    end
    f.actions
  end
end
