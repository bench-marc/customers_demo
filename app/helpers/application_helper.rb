# frozen_string_literal: true

module ApplicationHelper
  def display_errors(model, attribute)
    return unless model.errors[attribute].any?

    content_tag(:div, model.errors[attribute].join(', '), class: 'text-red-500 text-sm mt-1')
  end
end
