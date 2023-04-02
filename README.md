# Gpt::Spam::Classifier

Integrate a simulated spam classifier that interacts with OpenAI gpt models into an existing ruby application. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gpt-spam-classifier'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gpt-spam-classifier

## Usage

Basic usage:
```ruby
    irb(main):001:0>     Gpt::Spam::Classifier.classify('my non spammy text', api_key: 'removed', model: 'gpt-3.5-turbo')

    => {"spam_level"=>0, "reason"=>"No spam or promotional content detected."}
```

Error example:
```ruby
    irb(main):003:0>     Gpt::Spam::Classifier.classify('my non spammy text', api_key: 'removed_invalid_key', model: 'gpt-3.5-turbo')
    => 
    {:error=>
    "Incorrect API key provided: removed_invalid_key. You can find your API key at https://platform.openai.com/account/api-keys."}
```

## TODO
- [ ] setup using config + handle error case


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gpt-spam-classifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/gpt-spam-classifier/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gpt::Spam::Classifier project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gpt-spam-classifier/blob/master/CODE_OF_CONDUCT.md).
