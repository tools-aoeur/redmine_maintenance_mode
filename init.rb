Rails.autoloaders.main.ignore("#{__dir__}/lib") if Rails::VERSION::MAJOR >= 6

require_relative 'lib/maintenance_mode_hooks'
require_relative 'lib/maintenance_mode/functions'
require_relative 'lib/maintenance_mode/hooks'
require_relative 'lib/maintenance_mode'

Rails.logger.info 'Starting Maintenance Mode plugin for Redmine'

Redmine::Plugin.register :redmine_maintenance_mode do
  name 'Redmine Maintenance Mode'
  author 'Tobias Fischer (orig)'
  description 'This is a plugin to schedule and announce maintenance downtimes as well as disable user access to redmine during maintenance times.'
  version '3.0.0'
  url 'https://github.com/tofi86/redmine_maintenance_mode'
  author_url 'https://github.com/tofi86'

  requires_redmine version_or_higher: '3.0.0'

  menu :admin_menu, :redmine_maintenance_mode,
       { controller: 'settings', action: 'plugin', id: :redmine_maintenance_mode },
       caption: :maintenance_mode,
       after: :auth_sources,
       html: { class: 'icon icon-maintenance_mode' }

  settings default: {
    'maintenance_active' => false,
    'maintenance_message' => '',
    'maintenance_schedule' => false,
    'schedule_message' => '',
    'schedule_start' => '2019-02-09 11:00',
    'schedule_end' => '2019-02-09 13:00'
  }, partial: 'redmine_maintenance_mode_settings'
end

# Patches to the Redmine core.
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 6
  Rails.application.config.after_initialize do
    require_dependency 'application_controller'
    ApplicationController.include MaintenanceMode
  end
elsif Rails::VERSION::MAJOR >= 5
  ActiveSupport::Reloader.to_prepare do
    require_dependency 'application_controller'
    ApplicationController.include MaintenanceMode
  end
elsif Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'application_controller'
    ApplicationController.include MaintenanceMode
  end
else
  Dispatcher.to_prepare do
    require_dependency 'application_controller'
    ApplicationController.include MaintenanceMode
  end
end
