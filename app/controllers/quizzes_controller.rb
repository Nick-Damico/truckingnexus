# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :authenticate_user!, only: %i[new]

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end
end
