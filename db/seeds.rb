Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

categories = Spree::Taxonomy.where(name: I18n.t('spree.taxonomy_categories_name')).first_or_create!
categories_taxon = Spree::Taxon.where(name: I18n.t('spree.taxonomy_categories_name')).first_or_create!

['Standard', 'Custom'].each do |taxon_name|
  taxon = categories_taxon.children.where(name: taxon_name).first_or_create!
  taxon.permalink = taxon.permalink.gsub('categories/', '')
  taxon.taxonomy = categories
  taxon.save!
end

print_size_attributes = {
  name: 'print_size',
  presentation: 'Print Size',
  position: 1,
  filterable: false,
}
print_size_option_type = Spree::OptionType.where(print_size_attributes).first_or_create!

print_sizes = ['30x40', '45x60', '40x30', '60x45']
print_sizes.each_with_index do |value, index|
  print_size_option_type.option_values.find_or_create_by!(
    name: value,
    presentation: value,
    position: index + 1
  )
end

colors = {
  black: '#000',
  white: '#fff',
  brown: '#8B5F4D',
  gold: '#DAA520',
  silver: '#C0C0C0'
}

color_attributes = {
  name: 'color',
  presentation: 'Color',
  position: 2,
}
color_option_type = Spree::OptionType.where(color_attributes).first_or_create!

colors.each_with_index do |value, index|
  color_option_type.option_values.find_or_create_by!(
    name: value.first,
    presentation: value.last,
    position: index + 1
  )
end

default_mount_types = [
  { name: 'standard', label: 'Standard', price: 0.00, width: 6.5 },
  { name: 'standard', label: 'Standard', price: 0.00, width: 8.0 },
  { name: 'float_mount', label: 'Float Mount', price: 20.00 },
  { name: 'double_mount', label: 'Double Mount', price: 15.00 },
  { name: 'custom', label: 'Custom Mount', price: 0.0 }
]

default_mount_types.each do |mount_type|
  CustomFrame::MountType.where(mount_type).first_or_create!
end

default_mount_options = [
  { name: 'standard', label: 'Standard', price: 0.00, left: 6.5, top: 6.5, right: 6.5, bottom: 6.5 },
  { name: 'weighted', label: 'Bottom Weighted', price: 25.00, left: 6.5, top: 6.5, right: 6.5, bottom: 12.0 },
  { name: 'weighted', label: 'Bottom Weighted', price: 25.00, left: 8, top: 8, right: 8, bottom: 14.0 },
  { name: 'thin', label: 'Thin', price: 0.00, left: 4, top: 4, right: 4, bottom: 4 },
  { name: 'wide', label: 'Wide', price: 15.00, left: 10, top: 10, right: 10, bottom: 10 },
  { name: 'thin', label: 'Thin', price: 25.00, left: 12, top: 12, right: 12, bottom: 12 },
]

default_mount_options.each do |mount_option|
  CustomFrame::MountOption.where(mount_option).first_or_create!
end

default_moulding_types = [
  { name: 'Standard' },
  { name: 'Premium' },
  { name: 'Hardwood' }
]
default_moulding_types.each do |moulding_type|
  CustomFrame::MouldingType.where(moulding_type).first_or_create!
end

default_print_sizes = [
  { name: 'mini_square', label: 'Mini Square', longest_side: 12, shortest_side: 12, visible: true },
  { name: 'x_small', label: 'Xtra Small', longest_side: 18, shortest_side: 12, visible: true },
  { name: 'small', label: 'Small', longest_side: 30, shortest_side: 23, visible: true },
  { name: 'medium', label: 'Medium', longest_side: 45, shortest_side: 30, visible: true },
  { name: 'large', label: 'Large', longest_side: 60, shortest_side: 45, visible: true },
  { name: 'x_large', label: 'Xtra Large', longest_side: 45, shortest_side: 85, visible: true },
  { name: 'super_size', label: 'Supersize', longest_side: 100, shortest_side: 80, visible: true }
]

default_print_sizes.each do |print_size|
  CustomFrame::PrintSize.where(print_size).first_or_create!
end

default_frame_additionals = [
  { name: 'foil_blocking', label: 'Personalised foil blocking', presentation_type: CustomFrame::Additional.presentation_types['input'], price: 15.0 },
  { name: 'linen', label: 'linen', presentation_type: CustomFrame::Additional.presentation_types['checkbox'], price: 15.0 }
]

default_frame_additionals.each do |frame_additional|
  CustomFrame::Additional.where(frame_additional).first_or_create!
end

mount_type_scope = CustomFrame::PrintSize.all
standard_mount_type = mount_type_scope

standard_mount_type.each do |item|
  item.mount_types = [
    CustomFrame::MountType.find_by(name:'standard'),
    CustomFrame::MountType.find_by(name:'float_mount'),
    CustomFrame::MountType.find_by(name:'double_mount'),
    CustomFrame::MountType.find_by(name:'custom'),
  ]
  item.mount_options = [
    CustomFrame::MountOption.find_by(name: 'standard'),
    CustomFrame::MountOption.find_by(name: 'weighted'),
    CustomFrame::MountOption.find_by(name: 'thin'),
  ]
  item.additionals = [
    CustomFrame::Additional.find_by(name: 'foil_blocking'),
    CustomFrame::Additional.find_by(name: 'linen')
  ]
  item.save
end

custom_mount_type = CustomFrame::MountType.find_by(name: 'custom')

default_preference = { mount_type_id: custom_mount_type.id, default_size: 6.5, min_value: 13, max_value: 20, price: 15.00 }
middle_preference = { mount_type_id: custom_mount_type.id, default_size: 6.5, min_value: 20, max_value: 40, price: 25.00 }
large_preference = { mount_type_id: custom_mount_type.id, default_size: 6.5, min_value: 40, max_value: 200, price: 35.00 }

CustomFrame::CustomMountPreference.find_or_create_by!(default_preference)
CustomFrame::CustomMountPreference.find_or_create_by!(middle_preference)
CustomFrame::CustomMountPreference.find_or_create_by!(large_preference)

OriginalArt::Type.find_or_create_by!({ name: 'Original photograph' })
OriginalArt::Type.find_or_create_by!({ name: 'Original print' })
