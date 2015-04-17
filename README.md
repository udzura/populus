# Populus

[WIP][Will breaking change] Consul event handlers definition DSL

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'populus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install populus

## Usage

### Usages below are just a draft

```ruby
Populus.config do
  set :slack_webhook, "https://hooks.slack.com/services/XXXXXX"
end

Populus.watch :event, name: "echo" do
  cond {|data| data.any?{|d| d.has_key?('Payload')} }
  runs do |data|
    event = data.find{|d| d.has_key?('Payload')}
    Populus.logger.info "From populus!!!"
    Populus.logger.info Base64.decode64(event['Payload'])
  end
end

Populus.watch :event, name: slack do
  cond {|data| data.any?{|d| d.has_key?('Payload')} }
  runs do |data|
    event = data.first

    notify_to_slack("Hello!!!\nConsul event payload:\n>>> `#{event.inspect}`", channel: '#test', username: "Populus")
  end
end
```

```bash
bundle exec populus watch sample.popl
```

### TODOs

* [ ] Deployment switching by node name
* [x] Condition phrase against JSON
* [ ] Local/remote execution by specinfra
* [ ] More helpers
* [ ] Omnibusify

## Contributing

1. Fork it ( https://github.com/udzura/populus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
