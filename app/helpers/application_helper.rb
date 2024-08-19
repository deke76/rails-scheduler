module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice
      'bg-primary border border-primary'
    when :success
      'bg-success border border-success'
    when :alert
      'bg-warning border border-warning'
    when :error
      'bg-danger border border-danger'
    else
      'bg-info border border-info'
    end
  end
end
