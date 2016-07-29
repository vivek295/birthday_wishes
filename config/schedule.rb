set :output, "#{path}/log/cron.log"

every :day, :at => '11:58am' do
  rake "wishes:add"
end
