# Canary

Canary is an acceptance testing test suite meant for outside-in production monitoring of web
applications and APIs.

## Setup

1. [Install direnv](https://z-o-z-i.atlassian.net/wiki/display/EN/direnv+setup)


2. Run the setup script

  ```
  setup
  ```

## Usage

1. Add canary to a repo's Gemfile

  ```
  gem 'canary'
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
  bin/canary
  ```
