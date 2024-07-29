# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.present?
      resource || root_path
    else
      super
    end
  end
end
