require 'rake'

namespace :cache do
  desc 'Updates last updated flag on each store to force asset refresh for clients'
  task invalidate: :environment do
    ::Spree::Store.all.each(&:touch)
  end
end
