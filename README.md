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
args:
- `text`: Text to evaluate

kwargs:
- `api_key`: OpenAI api key
- `model`: OpenAI model to use
- `agents`: Number of "chats" to query (max 20)

```ruby
Gpt::Spam::Classifier.classify('call this number for free stuff', api_key: 'redacted', model: 'gpt-3.5-turbo', agents:3)

=> {:spam_level=>8, :reason=> "Promotional text with offer of free items, Promotional text with offer of free items, Promotional text with offer of free items, "}
```
Results Hash:
- `spam_level`: averages value from agents (0-10)
- `reason`: appends reasons together from agents

____
## Errors example:
```ruby
Gpt::Spam::Classifier.classify('call this number for free stuff', api_key: 'redacted', model: 'gpt-10', agents:3)

=> {:error=> "The model `gpt-10` does not exist, The model `gpt-10` does not exist, The model `gpt-10` does not exist, "}
```
Results Hash: 
- `error`: appends errors together from agents

## TODO
- [ ] setup using config to set api key + handle error case


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gpt-spam-classifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/gpt-spam-classifier/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gpt::Spam::Classifier project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gpt-spam-classifier/blob/master/CODE_OF_CONDUCT.md).
