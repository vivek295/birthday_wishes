set :output, "#{path}/log/cron.log"

every :day, :at => '1:09pm' do
  rake "wishes:add"
end
