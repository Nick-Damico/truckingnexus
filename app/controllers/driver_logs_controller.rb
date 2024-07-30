# frozen_string_literal: true

class DriverLogsController < ApplicationController
  def index; end

  def new
    @driver_log = current_user.driver_logs.build
  end
end
