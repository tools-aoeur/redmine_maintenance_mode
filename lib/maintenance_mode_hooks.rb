class MaintenanceModeHook < Redmine::Hook::ViewListener
  require 'maintenance_mode_functions'
  
  # add css and javascript if we're in the middle of a maintenance
  def view_layouts_base_html_head(context = {})
    # read plugin settings
    settings = MaintenanceModeFunctions.get_maintenance_plugin_settings
        
    if settings[:maintenance_active] || settings[:maintenance_scheduled] || MaintenanceModeFunctions.is_now_scheduled_maintenance
      tags = stylesheet_link_tag 'maintenance_mode', :plugin => 'redmine_maintenance_mode'
      tags += javascript_include_tag 'banner.js', :plugin => 'redmine_maintenance_mode'
      return tags
    end
  end
  
  
  # put admin message at the body_bottom as there is no body_top (#17454)
  # a javascript function will then bring it up to the top
  def view_layouts_base_body_bottom(context = {})
        
    # read plugin settings
    settings = MaintenanceModeFunctions.get_maintenance_plugin_settings
        
    # only show banner for logged in users
    if User.current.login?
          
      # if maintenance mode is activated or if we are in the middle of a scheduled maintenance
      if settings[:maintenance_active] || MaintenanceModeFunctions.is_now_scheduled_maintenance
        plugin_url = Setting.protocol + "://" + Setting.host_name + "/settings/plugin/redmine_maintenance_mode"
        div_banner l(:maintenance_mode_admin_message) % [ :pluginurl => plugin_url ]
          
        # if maintenance is scheduled and current time is before the scheduled maintenance start time
      elsif settings[:maintenance_scheduled] && settings.has_key?(:schedule_start) && Time.now < Time.parse(settings[:schedule_start])
        div_banner settings[:scheduled_message_f]
      end
     
    else

      if settings[:maintenance_active] || MaintenanceModeFunctions.is_now_scheduled_maintenance
        div_banner settings[:maintenance_message_f]
      end

    end
  end
    
  # html code for the banner notification with custom message
  def div_banner(message)
    "<div id=\"maintenance_mode_banner\">" + message + "</div>"
  end
  
end
