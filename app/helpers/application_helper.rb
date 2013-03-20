module ApplicationHelper
  def nav_active? *pages
    'active' if pages.include?(params[:controller])
  end

  # returns a fancy string for dates:
  def timely time
    return "#{time_ago_in_words(time)} ago" if time > 30.days.ago
    "#{time.strftime("%B %Y")}"
  end
end
