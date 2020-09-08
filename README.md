# Canary

Canary is a gem that makes it easy to use Rspec acceptance specs for production monitoring. Canary
captures both Rspec's run results and formatted report. The formatted report is mapped to simple
Ruby objects. This makes it easy to notify other systems of the Rspec run's results. Currently the
two notifications available are:

* [Amazon CloudWatch](https://aws.amazon.com/cloudwatch)
* [Slack Incoming Webhooks](https://api.slack.com/incoming-webhooks)

## Setup

1. Install, setup [direnv](https://direnv.net/)


2. Run the setup script

  ```
  setup
  ```

## [Example Usage](./example)

## Notifiers

The 2 currently available "Notifiers" are used by listing them in the `CANARY_NOTIFIERS` environment
variable, for example to use both of them the setting would like:

  ```
  CANARY_NOTIFIERS="slack,cloud_watch"
  ```

1. CloudWatch

  The AWS Ruby SDK will use your system's
  [AWS credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
  to authenticate. In order to use CloudWatch, ensure you have you your desired AWS region set in
  the Canary environment.:

   ```
   AWS_REGION=us-east-1
   ```

2. Slack

  The Slack notification sends a Slack attachment only upon failure. To use it, make sure you set the
  `CANARY_SLACK_WEBHOOK_URL`.

In order to add a notifier that does not exist, the code
[here](https://github.com/alkema/canary/tree/master/lib/canary/notifiers) will provide a good starting
point.

## Usage

1. Add canary to a repo's Gemfile

  ```
  gem 'canary', git: 'git@github.com:alkema/canary.git'
  ```

2. Create a spec directory

  ```
  mkdir spec
  ```

3. Add your acceptance specs

  In order to add a new acceptance spec follow these guidelines:

* Place spec in `spec/<APP_NAME>/features`. The convention for the spec location within that
directory allows Canary to deduce the app name.

* Ensure the spec has the following shared context:

  ```
  include_context 'capybara app host'
  ```

* Add ENV vars for both the app cluster and app URL.

  ```
  CANARY_GOOGLE_CLUSTER=foo
  CANARY_GOOGLE_URL=https://example.com
  ```

  Note: Any other needed variables, like username and password can be passed into the spec via an
  environment variable too. e.g. `CANARY_COOLAPP_PASSWORD=awes`. This variable is accessible in the spec via:

  ```
  Canary.config.coolapp_password
  ```

4. Run the bin script

  ```
  bundle exec canary
  ```

## License

Canary is released under the [MIT License](http://www.opensource.org/licenses/MIT).
