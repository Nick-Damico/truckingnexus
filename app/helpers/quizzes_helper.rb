# frozen_string_literal: true

module QuizzesHelper
  def answer_index_to_letter(idx)
    int_to_char(idx)
  end

  def int_to_char(number)
    (number + 'a'.ord).chr
  end

  def start_button_html(quiz:)
    button_to(user_quizzes_path(user_quiz: { quiz_id: quiz.id, user_id: current_user.id }),
              class: 'btn btn--save') do
      content_tag(:span, 'Start Quiz') +
        content_tag(:span,
                    raw('<svg class="w-3.5 h-3.5 ml-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10"> <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/> </svg>'))
    end
  end

  def quiz_button(user_quiz:, user: current_user, size: :medium)
    return nil unless user && user_quiz

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
                                                   class: "#{button_size_class(size)} bg-red-400 hover:bg-red-500")
    end
  end

  def quiz_result_button(user_quiz:, size:)
    link_to('View Results', user_quizzes_result_path(user_quiz), class: "btn #{button_size_class(size)} btn--primary")
  end
end
