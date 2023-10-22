# frozen_string_literal: true

module ApplicationHelper
  def copyright_div(**options)
    class_options = options[:class] || 'text-center text-gray-500 text-xs'
    content_tag(:p, '&copy;2023 Trucking Nexus. All rights reserved.'.html_safe,
                class: class_options)
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

  def selected_klass(path, **options)
    nil unless options[:class]

    current_page?(path) ? options[:class] : ''
  end
end
