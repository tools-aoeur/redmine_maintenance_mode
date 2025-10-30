Rails.autoloaders.main.ignore("#{__dir__}/lib")

require_relative 'lib/maintenance_mode'

Redmine::Plugin.register :redmine_maintenance_mode do
  name 'Redmine Maintenance Mode'
  author 'Tobias Fischer (orig)'
  description 'Schedule maintenance downtimes and control user access during maintenance.'
  version '6.1.0'
  url 'https://github.com/tofi86/redmine_maintenance_mode'
  author_url 'https://github.com/tofi86'

  requires_redmine version_or_higher: '6.1'

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
    'schedule_start' => '2025-08-19 11:00',
    'schedule_end' => '2025-08-19 13:00'
  }, partial: 'redmine_maintenance_mode_settings'
end

Rails.application.config.after_initialize do
  require_dependency 'application_controller'
  ApplicationController.include MaintenanceMode
end
