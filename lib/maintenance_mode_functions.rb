class MaintenanceModeFunctions
  include Redmine::I18n

  def self.get_maintenance_plugin_settings

    settings = {}

  	settings[:maintenance_active] = Setting.plugin_redmine_maintenance_mode['maintenance_active']
  	settings[:maintenance_message] = Setting.plugin_redmine_maintenance_mode['maintenance_message']
  	settings[:maintenance_scheduled] = Setting.plugin_redmine_maintenance_mode['maintenance_schedule']
  	settings[:scheduled_message] = Setting.plugin_redmine_maintenance_mode['schedule_message']

  	time_start = Setting.plugin_redmine_maintenance_mode['schedule_start']
  	time_end = Setting.plugin_redmine_maintenance_mode['schedule_end']
    datetime_regex = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/

	# only set dates, times and formatted strings if $start and $end are not empty and match the format %Y-%m-%d %H:%M
	if !time_start.nil? && time_start =~ datetime_regex  &&  !time_end.nil? && time_end =~ datetime_regex
		settings[:schedule_start] = time_start + Time.now.formatted_offset
		settings[:schedule_start_f] = format_time(settings[:schedule_start], true)
		settings[:schedule_startDate] = format_date(settings[:schedule_start])
		settings[:schedule_startTime] = format_time(settings[:schedule_start], false)

		settings[:schedule_end] = time_end + Time.now.formatted_offset
		settings[:schedule_end_f] = format_time(settings[:schedule_end], true)
		settings[:schedule_endDate] = format_date(settings[:schedule_end])
		settings[:schedule_endTime] = format_time(settings[:schedule_end], false)

		searchReplaceVariables = [ :start => settings[:schedule_start_f], :startDate => settings[:schedule_startDate], :startTime => settings[:schedule_startTime], :end => settings[:schedule_end_f], :endDate => settings[:schedule_endDate], :endTime => settings[:schedule_endTime] ]

		settings[:maintenance_message_f] = settings[:maintenance_message] % searchReplaceVariables
		settings[:scheduled_message_f] = settings[:scheduled_message] % searchReplaceVariables
	end

  	settings

  end


  def self.is_now_scheduled_maintenance
    s = get_maintenance_plugin_settings
    t = Time.now

	if s.has_key?(:schedule_start)
		s[:maintenance_scheduled] && t > Time.parse(s[:schedule_start]) && t < Time.parse(s[:schedule_end])
	else
		return false
	end
  end

end
