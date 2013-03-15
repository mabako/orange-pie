module ApplicationHelper
  def nav_active? page
    'active' if params[:controller] == page
  end
end
