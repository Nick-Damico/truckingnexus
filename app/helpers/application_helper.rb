# frozen_string_literal: true

module ApplicationHelper
  BUTTON_CLASSES = {
    small: 'btn--sml',
    medium: 'btn--md',
    large: 'btn--lg'
  }.freeze

  def copyright_div(**options)
    class_options = options[:class] || 'text-center text-gray-500 text-xs'
    content_tag(:p, '&copy;2023 Trucking Nexus. All rights reserved.'.html_safe,
                class: class_options)
  end

  def button_size_class(size = :medium)
    size ||= :medium unless size
    size.to_sym
    BUTTON_CLASSES[size]
  end

  def flash_bg_color(key)
    klasses = ['bg-flash']
    case key.to_sym
    when :alert
      klasses << 'bg-flash--warning'
    when :info
      klasses << 'bg-flash--info'
    when :notice
      klasses << 'bg-flash--notice'
    end

    klasses.join(' ')
  end

  def int_to_char(number)
    (number + 'a'.ord).chr
  end

  def selected_klass(path, **options)
    return unless options[:class]

    check_parameters = options.fetch(:check_parameters, false)
    current_page?(path, check_parameters:) ? options[:class] : ''
  end

  def format_date(date, format: '%b %d, %Y')
    date.strftime(format)
  end

  def render_icon(icon, **kwargs)
    classes = kwargs[:classes] || ''
    render "shared/icons/#{icon}", classes:
  end
end
