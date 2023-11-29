module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert-notice"
    when :alert then "alert-alert"
    else "alert"
    end
  end
end
