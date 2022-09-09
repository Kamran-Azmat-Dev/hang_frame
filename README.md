# README

## Architecture overview

The application is based on Spree 4.2, which provides the core e-commerce functionality. For a full reference, please see the [Spree documentation](https://spreecommerce.com/).

Major customizations compared to stock Spree:
- LineItems can have a HangPhoto attached to them, which represents the photo that's to be printed and put inside the frame.
- CustomFrame module contains models used to configure available options and their pricing for custom frames.
- Products have a "Custom Frame?" flag. If set, the price is calculated based on uploaded photo and customization options selected by the customer. Customization options are added to LineItems as Spree::Adjustment. On the frontend, custom frames use a preview component that builds an SVG preview based on the uploaded photo and selected customization options.

On the frontend, the application uses Vue.js components compiled by the Webpacker. The entry point is located in `app/javascript/packs/components.js`. These components can be used in Rails templates.

For background job processing, the application uses Sidekiq. For a full reference, please see the [Sidekiq documentation](https://sidekiq.org/). The main jobs running in sidekiq are related to image processing during upload and cropping.

## Database schema

The schema is available in `config/schema.rb` file.

## Setting up local development environment

Install Node v10 (required by webpacker)

`nvm install 10`
`nvm use 10`

Install dependencies

`bundle install`
`yarn install`

Install imagemagick (for processing photos)

`sudo apt-get install imagemagick`
or
`brew install imagemagick`

Run docker containers with dependencies

`docker-compose up`

Copy template database config (and edit if necessary)

`cp config/database.example.yml config/database.yml`

Create database

`bin/rails db:create`

Load database schema

`bin/rails db:schema:load`

Load seed data and create admin user

`bin/rails db:seed`

(Optional) Load sample data

`bin/rails spree_sample:load`

Run application and webpack dev server (for frontend assets)
`bin/rails server`
`bundle exec sidekiq`
`bin/webpack-dev-server`

## Environment variables

For redis:
```bash
REDIS_URL=redis://127.0.0.1:11001/0
```

For storage in production:
```bash
S3_ACCESS_KEY_ID=xxxx
S3_SECRET_ACCESS_KEY=xxxx
S3_REGION=xxxx
S3_BUCKET=xxxx
```

For Google Analytics tracking
```bash
GOOGLE_ANALYTICS_TRACKING_ID=UA-xxxx
```

For Google Analytics embedded reporting
```bash
GOOGLE_ANALYTICS_VIEW_ID=xxxx
GOOGLE_ANALYTICS_SERVICE_ACCOUNT_JSON_PATH=xxxx
```

For Facebook Pixel
```bash
FACEBOOK_PIXEL_ID=xxxx
```

For Klaviyo:
```bash
KLAVIYO_PUBLIC_API_KEY=xxxx
KLAVIYO_PRIVATE_API_KEY=xxxx
```

For Hotjar
```bash
HOTJAR_ID=xxxx
```

## Hosting

The application is currently hosted on Heroku.
In Procfile, you can find definitions of two dynos: web (for the webserver) and worker (sidekiq queue).

The application uses the following dependencies:
- Bucketeer - for provisioning S3 bucket in Heroku, this can also be replaced by using S3 directly).
- Heroku Postgres - for hosting the database.
- Heroku Redis - for Sidekiq's job queue.
- Memcached cloud - for caching.
- Coralogix Logging - for log persistence.

## Database backups

Production database has [continuous protection](https://devcenter.heroku.com/articles/heroku-postgres-data-safety-and-continuous-protection) option enabled, with a rolling window of 4 days.
Manual backups can be created and downloaded via the [Heroku PGBackups tool](https://devcenter.heroku.com/articles/heroku-postgres-backups) or via the panel in the [Heroku dashboard](https://data.heroku.com).

## Deployment

### Staging

Staging is configured to auto deploy any changes made to `master`, no further interaction required.
The usual workflow:

1. Checkout a new branch, like `feature/product_bundles` or `fix/missing_links`
2. Make your changes
3. Open a pull request to `master`, mark somebody for code review
4. Merge PR after it's reviewed

Updated `master` branch will be deployed to staging automatically (takes a few minutes).

There's an option to manually deploy any branch if the need arises. It can be done by opening staging app
admin panel in Heroku and navigating to 'Deploy' tab and 'Manual deploy' section. [Documentation](https://devcenter.heroku.com/articles/github-integration#manual-deploys).

### Production

Done by promoting tested staging application to production, as per [Heroku documentation](https://devcenter.heroku.com/articles/pipelines#promoting).
