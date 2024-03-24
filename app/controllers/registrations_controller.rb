# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def after_update_path_for(resource)
    user_path(resource, page_content: 'profile')
  end
end
