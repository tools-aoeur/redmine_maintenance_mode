module MaintenanceMode
  require 'maintenance_mode_functions'
  
  def self.included(base)
    base.class_eval do
      unloadable
      
      # show maintenance message for all "normal" users (except admins)
      def show_maintenance_mode_page
        
        # read plugin settings
        settings = MaintenanceModeFunctions.get_maintenance_plugin_settings
                
        # only activate maintenance message if maintenance mode is activated or if we're in the middle of a scheduled maintenance 
        if settings[:maintenance_active] || MaintenanceModeFunctions.is_now_scheduled_maintenance
          # and only activate it for non-admin users (or sudoers if 'redmine_sudo' plugin is installed)
          unless User.current.admin? || (Redmine::Plugin.installed?("redmine_sudo") && User.current.sudoer?)
            logout_user if User.current.logged?
            require_login unless params[:controller] == "account" && params[:action] == "login"
            return false
          end
        end
      end
      
      before_filter(:show_maintenance_mode_page)
      
    end
  end
end