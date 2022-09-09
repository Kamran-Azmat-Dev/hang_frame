release: rails db:migrate && rails cache:invalidate
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 2
