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

  def logout_button
    link_to('Log Out', destroy_user_session_path, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' },
                                                  class: 'inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-teal-500 hover:bg-white mt-4 lg:mt-0')
  end

  def login_button
    link_to('Login', new_user_session_path,
            class: 'inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-teal-500 hover:bg-white mt-4 lg:mt-0')
  end

  def profile_button(user: current_user)
    link_to(user_path(user)) do
      raw('<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1" class="stroke-white w-10 h-10 mr-4"> <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" /></svg>')
    end
  end

  def selected_klass(path, **options)
    nil unless options[:class]

    current_page?(path) ? options[:class] : ''
  end
end
