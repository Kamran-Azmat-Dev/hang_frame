require 'rake'

desc 'Import Products'
namespace 'products' do
  task import: :environment do
    ::Import::Products.call
  end

  task import_custom: :environment do
    ::Import::CustomProducts.call
  end
end
