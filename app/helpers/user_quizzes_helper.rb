# frozen_string_literal: true

module UserQuizzesHelper
  include ApplicationHelper

  def user_quiz_button(user_quiz:, user: current_user, size: :medium)
    return '' unless user && user_quiz

    return quiz_resume_button(user_quiz:, size:) if user_quiz.active?

    quiz_result_button(user_quiz:, size:) if user_quiz.completed?
  end

  def quiz_resume_button(user_quiz:, size:)
    content_tag(:div,
                class: 'flex inline-flex w-fit items-center pl-3 text-sm font-medium text-center text-white bg-sky-500 rounded-l-lg focus:ring-4 focus:outline-none focus:ring-blue-300') do
      content_tag(:span, 'Resume Quiz?', class: 'mr-6') +
        link_to('Yes', user_quiz_path(user_quiz),
                class: "#{button_size_class(size)} bg-emerald-400 hover:bg-emerald-500 btn--sml") +
        button_to('No', user_quiz_path(user_quiz), method: :delete, data: { confirm: 'Are you sure? Progress will be lost.', turbo_confirm: 'Are you sure? Progress will be lost.' },
                                                   class: "#{button_size_class(size)} btn--alert")
    end
  end

  def quiz_result_button(user_quiz:, size:)
    link_to('View Results', user_quizzes_result_path(user_quiz), class: "btn #{button_size_class(size)} btn--primary")
  end
end
