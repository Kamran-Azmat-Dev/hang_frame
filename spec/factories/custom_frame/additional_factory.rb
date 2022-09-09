# frozen_string_literal: true

FactoryBot.define do
  factory :foil_blocking, class: CustomFrame::Additional do
    name              { 'foil_blocking' }
    label             { 'Personalised foil blocking' }
    presentation_type { CustomFrame::Additional.presentation_types['input'] }
    price             { 15.0 }
  end
end
