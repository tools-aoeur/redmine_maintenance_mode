require_relative 'maintenance_mode/hooks'
require_relative 'maintenance_mode/functions'

module MaintenanceMode
  def self.included(base)
    base.class_eval do
      unloadable

      # show maintenance message for all "normal" users (except admins)
      def show_maintenance_mode_page
        return unless Functions.maintenance_ongoing?

        is_sudo_admin = (Redmine::Plugin.installed?('redmine_sudo') && User.current.sudoer?)
        is_admin = User.current.admin?
        return if is_admin || is_sudo_admin

        logout_user if User.current.logged?
        require_login unless params[:controller] == 'account' && params[:action] == 'login'
        false
      end

      before_action(:show_maintenance_mode_page)
    end
  end
end
