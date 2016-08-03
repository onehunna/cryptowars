schedule_file = File.expand_path('../../schedule.yml', __FILE__)

if File.exists?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
