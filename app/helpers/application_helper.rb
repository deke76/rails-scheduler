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

  def lorem_ipsum(type: :paragraph, count: 1)
    lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    case type
    when :paragraph
      Array.new(count) { lorem }.join("\n\n")
    when :sentence
      sentences = lorem.split('. ')
      sentences.first(count).join('. ') + '.'
    when :word
      words = lorem.split(' ')
      words.first(count).join(' ')
    end
  end

  def nav_active?(controller_name)
    controller.controller_name == controller_name.to_s
  end
end
