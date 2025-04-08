# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Allow only browsers natively supporting webp images, web push, badges, import maps, CSS nesting + :has
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.present?
      resource || root_path
    else
      super
    end
  end
end
