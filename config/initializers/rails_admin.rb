RailsAdmin.config do |config|
  config.authorize_with :cancancan
  config.parent_controller = 'ApplicationController'
  config.current_user_method { current_user } # refers to the current_user

  config.model 'Ad' do
    edit do
      configure :title do
        hide
      end
      configure :description do
        hide
      end
      configure :user do
        hide
      end
      configure :images do
        hide
      end
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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
