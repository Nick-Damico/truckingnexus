# frozen_string_literal: true

module QuizzesHelper
  def answer_index_to_letter(idx)
    int_to_char(idx)
  end

  def quiz_start_button(quiz:)
    button_to(user_quizzes_path(user_quiz: { quiz_id: quiz.id, user_id: current_user.id }),
              class: 'btn btn--save') do
      content_tag(:span, 'Start Quiz') +
        content_tag(:span,
                    raw('<svg class="w-3.5 h-3.5 ml-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10"> <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/> </svg>'))
    end
  end
end
