component {

	/**
	 * Converts a string to a date object
	 * @param {string} dateString - The date string to convert
	 * @return {date} - The date object
	 */
	public date function convertStringToDate(dateString, format="yyyy-mm-dd"){
		var date = parseDateTime(dateString);
		return date.Format(format);
	}

	// !Check this function
	/**
	 * Gets the time until a date
	 * @param {string} dateString - The date string to convert
	 * @return {string} - The time until the date in a human-readable format.
	 */
	public string function getTimeUntil(dateString){
		var date = parseDateTime(dateString);
		var now = parseDateTime(now());
		var diff = dateDiff("s", now, date);
		var time = "";
		if(diff > 0){
			var days = int(diff / 86400);
			diff -= days * 86400;
			var hours = int(diff / 3600);
			diff -= hours * 3600;
			var minutes = int(diff / 60);
			diff -= minutes * 60;
			var seconds = diff;
			if(days > 0){
				time = days & " days, ";
			}
			if(hours > 0){
				time &= hours & " hours, ";
			}
			if(minutes > 0){
				time &= minutes & " minutes, ";
			}
			if(seconds > 0){
				time &= seconds & " seconds";
			}
		}
		return time;
	}

	/**
	 * Gets the time since a date
	 * @param {string} dateString - The date string to convert
	 * @return {string} - The time since the date in a human-readable format.
	 */
	public string function getTimeSince(dateString){
		var date = parseDateTime(dateString);
		var now = parseDateTime(now());
		var diff = dateDiff("s", date, now);
		var time = "";
		if(diff > 0){
			var days = int(diff / 86400);
			diff -= days * 86400;
			var hours = int(diff / 3600);
			diff -= hours * 3600;
			var minutes = int(diff / 60);
			diff -= minutes * 60;
			var seconds = diff;
			if(days > 0){
				time = days & " days, ";
			}
			if(hours > 0){
				time &= hours & " hours, ";
			}
			if(minutes > 0){
				time &= minutes & " minutes, ";
			}
			if(seconds > 0){
				time &= seconds & " seconds";
			}
		}
		return time;

	}

	/**
	 * Gets the current time
	 * @return {string} - Current time in a human-readable format.
	 */
	public string function getNow(format="yyyy-mm-dd hh:mm:ss"){
		var date = parseDateTime(now());
		return date.Format(format);
	}

}