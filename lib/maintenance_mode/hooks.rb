require_relative 'functions'

module MaintenanceMode
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_account_login_top, partial: 'maintenance/login'
    render_on :view_layouts_base_body_top, partial: 'maintenance/base'

    # add css and javascript if we're in the middle of a maintenance
    def view_layouts_base_html_head(_context = {})
      tags = stylesheet_link_tag('admin', plugin: 'redmine_maintenance_mode')
      tags += stylesheet_link_tag 'maintenance_mode', plugin: 'redmine_maintenance_mode' if Functions.notification?
      tags
    end
  end
end
