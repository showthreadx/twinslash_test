require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminPublish
end
 
module RailsAdmin
  module Config
    module Actions
      class Approve < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
 
        register_instance_option :bulkable? do
          true
        end
 
        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
 
            # Update field status to new_ad
            @objects.each do |object|
              object.update_attribute(:status, 'approved_ad')
            end
 
            flash[:success] = "Selected #{@model_config.label}s was successfully approved."
 
            redirect_to back_or_index
          end
        end
      end
    end
  end
end