# Rubocop::Temporal

Is your test suite suddenly failing randomly? Do you use `travel_to` without blocks? The Department of Temporal Investigations is here to ~~stop~~ help you.

TLDR: This cop checks for calls to `travel_to` without a block. This is dangerous because a test where this happen might break other tests subtely because now the code runs either in the future or in the past. Using a block will protect you, because after running the block, you will be returned to real time.

## The problem

So what is the problem? Let's explore this a bit.

Imagine you have the following spec:

```ruby
describe 'Enable discounts on New Years Eve' do
    context 'when it is new years' do
        it 'shows fireworks' do
            travel_to '2021-12-31'

            expect(product.price).to eq 100 * 0.5
        end
    end
end
```

Looks good, ship it!

Oh no, random failures:

```ruby

# Mail is not enqueued suddenly, but only sometimes. When you run this spec individually, it is always sent
describe 'Special member invite' do
    it 'invites people who spent at least €1000 to become special members' do
        10.times { user.purchase(create(:product, price: 100)) }

        expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with('UserMailer', 'special_member_invite', 'deliver_now', user)
    end
end

# This also passes individually, but sometimes we see:
# Luke: Noooooooooooooo
# Darth: No. I am your father
describe 'Message view' do
    it 'displays messages from old to new' do
        travel_to 2.days.ago
        darth_message = send_message(to: 'Luke', 'No. I am your father')

        travel_back
        luke_message = send_message(to: 'Darth', 'Noooooooooooooo')

        expect(page).to have_content(<~~MESSAGE)
            Darth: No. I am your father
            Luke: Noooooooooooooo
        MESSAGE
    end
end

```

Why?

Many 🕐🕑🕒🕓 hours, later 🧽.

It turns out, whenever the `Enable discounts on New Years Eve` spec runs, it sets the date to the end of this year, but we never return to the current date. The random fails then only happen when the NYE spec runs before them, hence 'random'.

The spec `Special member invite` fails because on New Years Eve all prices are cut in half, so the user never reaches the treshold of €1000.

The spec `Message view` fails because when we did `travel_to 2.days.ago` we went to the 29th of December, not `2.days.ago` from the current date. Then when we do `travel_back` we go back to the current date, lets say the 15th of May and send the second message, or so we think. In reality it is now the first message.

Side note: this does not randomly fail after the 31st of December 2021.

The solution? Passing a block to `travel_to`. After the block runs, you will be returned to real time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-temporal', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubocop-temporal

## Usage

Add the following to your `.rubocop.yml` config:

```
require:
  - rubocop-temporal
```

If `require:` was already there, just add `  - rubocop-temporal` nested underneath it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abuisman/rubocop-temporal.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
