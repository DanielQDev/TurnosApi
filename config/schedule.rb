# Use this file to easily define all of your cron jobs.

set :output, "/log/cron_log.log"

every :sunday, at: '12pm' do\
  rake "shift:generate_shifts"
end
