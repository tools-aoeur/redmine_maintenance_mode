module MaintenanceMode
  def self.included(base)
    base.class_eval do
      unloadable
      before_filter(:show_maintenance_mode_page)

      def show_maintenance_mode_page
        unless User.current.admin?
          render :text => "This site is currently under maintenance. Please check back later"
          return false
        end
      end
    end
  end
end


# Patches to the Redmine core.
require 'dispatcher'  unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'application_controller'
    ApplicationController.send(:include, MaintenanceMode)
  end
else
  Dispatcher.to_prepare do
    require_dependency 'application_controller'
    ApplicationController.send(:include, MaintenanceMode)
  end
end
