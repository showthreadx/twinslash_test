RailsAdmin.config do |config|
  config.main_app_name = ["Advertising Project", "Admin"]
  config.authorize_with :cancancan, AdminAbility
  config.parent_controller = 'ApplicationController'
  config.current_user_method { current_user }

  config.model 'Ad' do
    edit do
      field :status
      field :ad_type
    end
    list do
      exclude_fields :created_at
      exclude_fields :updated_at
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Ad']
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
