set :output, "#{path}/log/cron.log"

every :day, :at => '1:53am' do
  rake "wishes:add"
end
