# frozen_string_literal: true

module QuizzesHelper
  def quiz_card_button_html(quiz:, user: current_user)
    return nil if user.nil?

    if (active_user_quiz = user.user_quizzes.active.find_by(quiz_id: quiz.id))
      return resume_quiz_button_html(user_quiz: active_user_quiz)
    end

    start_button_html(quiz:)
  end

  def start_button_html(quiz:)
    button_to(user_quizzes_path(user_quiz: { quiz_id: quiz.id, user_id: current_user.id }),
              class: 'btn btn--save') do
      content_tag(:span, 'Start Quiz') +
        content_tag(:span,
                    raw('<svg class="w-3.5 h-3.5 ml-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10"> <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/> </svg>'))
    end
  end

  def resume_quiz_button_html(user_quiz:)
    content_tag(:div,
                class: 'flex inline-flex w-fit items-center pl-3 text-sm font-medium text-center text-white bg-sky-500 rounded-l-lg focus:ring-4 focus:outline-none focus:ring-blue-300') do
      content_tag(:span, 'Resume Quiz?', class: 'mr-6') +
        link_to('Yes', user_quiz_path(user_quiz), class: 'bg-emerald-400 hover:bg-emerald-500 px-3 py-2') +
        button_to('No', user_quiz_path(user_quiz), method: :delete, data: { confirm: 'Are you sure? Progress will be lost.', turbo_confirm: 'Are you sure? Progress will be lost.' },
                                                   class: 'bg-red-400 hover:bg-red-500 px-3 py-2')
    end
  end

  def answer_index_to_letter(idx)
    int_to_char(idx)
  end

  def int_to_char(number)
    (number + 'a'.ord).chr
  end
end
