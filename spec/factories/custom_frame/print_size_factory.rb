# frozen_string_literal: true

FactoryBot.define do
  factory :standard_print_size, class: CustomFrame::PrintSize do
    name { 'standard' }
    label { 'Standard' }
    longest_side { 45 }
    shortest_side { 30 }
    visible { true }
  end

  factory :medium_print_size, class: CustomFrame::PrintSize do
    name { 'medium' }
    label { 'Medium' }
    longest_side { 45 }
    shortest_side { 30 }
    visible { true }
  end
end
