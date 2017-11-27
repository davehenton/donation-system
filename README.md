[![Build Status](https://travis-ci.org/survival/donation-system.svg?branch=master)](https://travis-ci.org/survival/donation-system)
[![Coverage Status](https://coveralls.io/repos/github/survival/donation-system/badge.svg)](https://coveralls.io/github/survival/donation-system)
[![Dependency Status](https://gemnasium.com/badges/github.com/survival/donation-system.svg)](https://gemnasium.com/github.com/survival/donation-system)


# Donation System

This is the new donation system for the Survival International site.


## Installation

This gem is still under development and in an unstable state.
Hence, it is not in rubygems yet.

To use it, add this line to your application's Gemfile:

```ruby
gem 'donation-system', git: 'https://github.com/survival/donation-system'
```

Then, in your code, do:

```ruby
require 'donation_system'

Data = Struct.new(
  :amount, :currency, :giftaid, :token,
  :name, :email,
  :address, :city, :state, :zip, :country
)

data = Data.new(
  '10.50', 'gbp', true, 'tok_visa',
  'Jane Doe', 'jane@doe.com',
  'Main Street, 1', 'London', 'London', 'Z1PC0D3', 'UK'
)

errors = DonationSystem::Payment.attempt(data)

if errors.empty?
  # Do something cool
else
  # Log errors, maybe
end
```

If there are no errors, it means that:
* The payment was saved in your Stripe account
* A thank you email was sent to the donor
* The relevant records were saved in Salesforce (a one-off donation and a new supporter if they didn't exist in the database)

The `data` that the gem consumes can be anything that responds to at least the following (all these should return strings except the giftaid, which is a boolean):

* `data.amount`: The amount of money to be donated, in currency units. This can be a floating number (amount with cents) and will be converted to cents by the gem. For example: 10.50
* `data.currency`: The currency that the amount is in, should be a valid ISO 4217 code for currencies and supported by the Money gem that this gem uses to handle money. [Check here for a list of supported currencies in JSON format]((https://github.com/RubyMoney/money/tree/e2773f7859b268965fa003e2630ed58e7e96ac58/config)
* `data.giftaid`: This can be true or false, depending if you allow the donors to [Gift Aid](https://en.wikipedia.org/wiki/Gift_Aid) their donation to you
* `data.token` is a one-use valid token generated by Stripe using their JavaScript library in the frontend.
* `data.name`: the name of the donor
* `data.email`: the email of the donor
* `data.address`: the address of the donor
* `data.city`: the city of the donor
* `data.state`: the state of the donor
* `data.zip`: the zip code of the donor
* `data.country`: the country of the donor

For the gem to work you need to set some environment variables:

1. The Stripe API keys of your Stripe account:

```bash
export STRIPE_SECRET_KEY=...
export STRIPE_PUBLIC_KEY=...
```

1. Your email server data:

```bash
export EMAIL_SERVER=...
export EMAIL_USERNAME=...
export EMAIL_PASSWORD=...
```

1. Some data from your Salesforce account:

```bash
export SALESFORCE_HOST=...
export SALESFORCE_USERNAME=...
export SALESFORCE_PASSWORD=...
export SALESFORCE_SECURITY_TOKEN=...
export SALESFORCE_CLIENT_ID=...
export SALESFORCE_CLIENT_SECRET=...
export SALESFORCE_API_VERSION=...
```

Remember to append `bundle exec` in front of any CLI command that requires this gem.



# Development


## To initialise the project

You need to have `git` and `bundler` installed.

Run the setup script (**Beware:** Needs permissions to access the credentials repo):

```
. scripts/setup.sh
```

This script will:
* download the credentials
* run the credentials to set the environment
* run `bundle install` to install gems.
* run `bundle exec rake` to run the tests.


## Tests

You need to set your environment by running the credentials. These will be run when you run the `setup.sh` script, but in any case before running the tests ensure that you remember to do:

```
. credentials/.env_test
. credentials/.email_server
```


### To run all tests and rubocop

```bash
bundle exec rake
```


### To run one file


```bash
bundle exec rspec path/to/test/file.rb && rubocop
```


### To run one test

```bash
bundle exec rspec path/to/test/file.rb:TESTLINENUMBER && rubocop
```


### To release a new version


To release a new version, update the version number in `version.rb`, and describe your changes in the changelog. Then run:

```bash
git tag -a VERSION_HERE -m "DESCRIPTION_HERE"
```

which will create a git tag for the version. Then push git commits and tags:

```bash
git push origin master --tags
```

and push the `.gem` file to [rubygems.org](https://rubygems.org):

```bash
gem build donation_system.gemspec
gem push donation_system-VERSION_HERE.gem
```


## Testing emails in production

You can send an email to any email address using the `test_email_server.rb` script, and making sure that you set your environment with an email server, username and password, by running the credentials:

```bash
. credentials/.email_server
bundle exec ruby scripts/test_email_server.rb 'YOUR_EMAIL_HERE'
```


## Contributing

Please check out our [contribution guides](https://github.com/survival/contributing-guides) and our [code of conduct](https://github.com/survival/contributing-guides/blob/master/code-of-conduct.md)


## License

[![License](https://img.shields.io/badge/mit-license-green.svg?style=flat)](https://opensource.org/licenses/mit)
MIT License
