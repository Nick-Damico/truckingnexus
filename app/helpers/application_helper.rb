# frozen_string_literal: true

module ApplicationHelper
  def copyright_div(**options)
    class_options = options[:class] || 'text-center text-gray-500 text-xs'
    content_tag(:p, '&copy;2023 Trucking Nexus. All rights reserved.'.html_safe,
                class: class_options)
  end
end
