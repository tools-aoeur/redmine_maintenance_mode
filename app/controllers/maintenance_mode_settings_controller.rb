class MaintenanceModeSettingsController < ApplicationController
  layout 'admin'
  before_action :require_admin
  menu_item :redmine_maintenance_mode

  def index
    @plugin = Redmine::Plugin.find(:redmine_maintenance_mode)
    @settings = Setting.plugin_redmine_maintenance_mode || {}

    if request.post?
      settings = params[:settings] ? params[:settings].to_unsafe_hash : {}
      Setting.plugin_redmine_maintenance_mode = settings
      flash[:notice] = l(:notice_successful_update)
      redirect_to action: 'index'
    end
  end

  private

  def require_admin
    (render_403; return false) unless User.current.admin?
  end
end
