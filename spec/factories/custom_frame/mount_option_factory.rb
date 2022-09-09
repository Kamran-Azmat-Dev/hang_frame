# frozen_string_literal: true

FactoryBot.define do
  factory :standard_mount_option, class: CustomFrame::MountOption do
    name { 'standard' }
    label { 'Standard' }
    price { 20.0 }
    left { 6.5 }
    top { 6.5 }
    right { 6.5 }
    bottom { 6.5 }
  end
end
