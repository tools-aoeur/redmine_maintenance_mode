module MaintenanceMode
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_account_login_top, partial: 'maintenance/login'
    render_on :view_layouts_base_body_top, partial: 'maintenance/base'
  end
end
