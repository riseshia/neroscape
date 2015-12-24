ActiveAdmin.register Role do
  permit_params :name

  index do
    selectable_column
    column 'ID' do |role|
      link_to role.id, admin_role_path(role)
    end
    column :name
    column :updated_at
    column :created_at
    actions
  end
end
