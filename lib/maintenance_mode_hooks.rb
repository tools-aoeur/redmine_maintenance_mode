class MaintenanceModeHook < Redmine::Hook::ViewListener
  require 'maintenance_mode_functions'

  # add css and javascript if we're in the middle of a maintenance
  def view_layouts_base_html_head(context = {})
    tags = stylesheet_link_tag('admin', :plugin => 'redmine_maintenance_mode')

    # read plugin settings
    settings = MaintenanceModeFunctions.get_maintenance_plugin_settings

    if settings[:maintenance_active] || settings[:maintenance_scheduled] || MaintenanceModeFunctions.is_now_scheduled_maintenance
      tags += stylesheet_link_tag 'maintenance_mode', :plugin => 'redmine_maintenance_mode'
    end

    tags
  end

end
