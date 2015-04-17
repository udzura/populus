require 'populus/helpers'
require 'slack-notifier'

Populus::Helpers.define_helper :notify_to_slack do |message, options={}|
  notifier = Slack::Notifier.new Populus.config.slack_webhook
  notifier.channel  = options[:channel]  if options[:channel]
  notifier.username = options[:username] if options[:username]

  notifier.ping message
end
