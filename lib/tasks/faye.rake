namespace :faye do
  desc 'publish message to clients'
  task :publish, [:message] => :environment do |t, args|
    message = { channel: '/messages/new', data: args[:message] }
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end
