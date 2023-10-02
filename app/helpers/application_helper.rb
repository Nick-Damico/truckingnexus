# frozen_string_literal: true

module ApplicationHelper
  def copyright_div
    content_tag(:p, '&copy;2023 Trucking Nexus. All rights reserved.'.html_safe,
                class: 'text-center text-gray-500 text-xs')
  end
end
