$( document ).ready(function() {
	
	var errorClass = 'settingsErrorBox';
	var datetime_pattern = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/;
	var variable_pattern = /%\{.*?\}/;
	
	var maint_active = $('#settings_maintenance_active');
	var maint_active_msg = $('#settings_maintenance_message');
	var maint_schedule = $('#settings_maintenance_schedule');
	var maint_schedule_msg = $('#settings_schedule_message');
	var maint_schedule_start = $('#settings_schedule_start');
	var maint_schedule_end = $('#settings_schedule_end');
	
	
	
	function check_field(field) {	
		!field.val() ? field.addClass(errorClass) : field.removeClass(errorClass);
		
		if(field.val() && field.val().match(variable_pattern)) {
			$('#required_scheduled_time').show();
		}
	}
	
	function check_date(field) {
		field.val().match(datetime_pattern) ? field.removeClass(errorClass) : field.addClass(errorClass);
	}
	
	function check_date_range(start, end) {
		if( start.val().match(datetime_pattern) && end.val().match(datetime_pattern)
			&& start.val().replace(/[^0-9.]/g, '') < end.val().replace(/[^0-9.]/g, '') ) {
			start.removeClass(errorClass);
			end.removeClass(errorClass);
		} else {
			end.addClass(errorClass);
		}
	}
	
	function check_all_dates() {
		check_date(maint_schedule_start);
		check_date(maint_schedule_end);
		check_date_range(maint_schedule_start, maint_schedule_end);
	}
	
	function check_all() {
		check_field(maint_active_msg);
		
		if(maint_schedule.is(':checked')) {
			check_field(maint_schedule_msg);
			check_all_dates();
			$('#required_scheduled_msg, #required_scheduled_time').show();
			
		} else if(maint_active_msg.val().match(variable_pattern) || maint_schedule_msg.val().match(variable_pattern)) {
			check_all_dates();
			$('#required_scheduled_msg').hide();
			
		} else {
			$('#required_scheduled_msg, #required_scheduled_time').hide();
		}
	}
	
	
	
	// event listener for required fields
	maint_active.change(check_all);
	maint_schedule.change(check_all);
	
	maint_active_msg.keyup(check_all);
	maint_schedule_msg.keyup(check_all);
	maint_schedule_start.keyup(check_all);
	maint_schedule_end.keyup(check_all);
	
	
	
	// check for required fields when submitting the form
	maint_schedule.closest("form").submit(function(e) {
		
		// check all fields once more...
		check_all();
		
		// no form submit if maintenance message is empty
		if(maint_active_msg.hasClass(errorClass)) {
			e.preventDefault();
			
		// no form submit if schedule message or timestamps are empty or invalid
		} else if(maint_schedule_msg.hasClass(errorClass) || maint_schedule_start.hasClass(errorClass) || maint_schedule_end.hasClass(errorClass)) {
			e.preventDefault();
		
		// submit the form if everything is okay...
		} else {
			$(this).unbind('submit').submit();
		}
	});
	
	
	
	// initial check
	check_all();
});