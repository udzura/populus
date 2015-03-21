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
Populus.watch 'node' do
  on_receive do |nodes|
    if nodes.count < 10
	  logger.warn "nodes are too short!"
	end
  end
end
```

```bash
consul watch -type node "bundle exec populus accept sample.popl"
```

### TODOs

* Deployment switching by node name
* Condition phrase against JSON
* Local/remote execution by specinfra

## Contributing

1. Fork it ( https://github.com/udzura/populus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
