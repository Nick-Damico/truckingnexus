# frozen_string_literal: true

module QuizzesHelper
  include ApplicationHelper
  def answer_index_to_letter(idx)
    int_to_char(idx)
  end

  def quiz_start_button(quiz:, user: current_user, **kwargs)
    text = kwargs[:text] || 'Start Quiz'
    icon_name = kwargs[:icon] || 'right_arrow'

    button_to(user_quizzes_path(user_quiz: { quiz_id: quiz.id, user_id: user.id }),
              class: 'btn btn--save') do
      content_tag(:span, text, class: 'mr-2') +
        content_tag(:span, render_icon(icon_name, classes: 'w-4'))
    end
  end

  def quiz_submit_btn_text(quiz)
    quiz.persisted? ? 'Update Quiz' : 'Save Draft'
  end
end
