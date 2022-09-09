# frozen_string_literal: true

FactoryBot.define do
  factory :custom_mount_type, class: CustomFrame::MountType do
    name { 'custom' }
    label { 'Custom' }
  end

  factory :standard_mount_type, class: CustomFrame::MountType do
    name { 'standard' }
    label { 'Standard' }
    width { 6.5 }
  end
end
