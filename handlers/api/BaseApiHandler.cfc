component extends="../BaseHandler" {

	/**
	 * Handle PreFlight Requests
	 */
	remote function preFlight( event, rc, prc ){
		var message = "PreFlight Request Made @ #now()#";
		// logService.sendLog(message="PreFlight Request Made @ #now()#", prefix="BaseHandler");
		if ( logbox.canInfo() ) {
			logbox.info( message );
		}
	}

	/**
	 * Remotely get the empty data object
	 */
	remote function getEmpty( event, rc, prc ){
		var dataObject = dataServer.getEmpty( dataServerName = variables.dataServerName );
		event.renderData( type = "json", data = dataObject.read() );
	}


	/**
	 * Main entry point for the handler, Lists all ACTIVE entries
	 */
	remote function index( event, rc, prc ){
		if ( isNull( dataServer ) ) {
			throw( "Data Server is not defined. Please ensure we are only calling index from a page that should index the data." );
		}


		var activeStatus = determineTruth( structKeyExists( rc, "status" ) ? rc.status : 1 );

		// Try to get a response from the server
		try {
			var serverResponse =
			dataServer.getRecordsByActivity( status = activeStatus, dataServerName = variables.dataServerName );

			if ( serverResponse.getSuccess() ) {
				var dataToReturn = evaluateResponse( serverResponse = serverResponse );
				event.renderData( type = "json", data = dataToReturn );
			} else {
				sendErrorLog( serverResponse = serverResponse );
			}
		} catch ( any e ) {
			sendErrorLog( additionalInfo = e );
		}
	}


	/**
	 * Create a new entry
	 */
	remote function createNew( event, rc, prc ){
		var serverResponse =
		dataServer.create( dataServerName = variables.dataServerName, payload = rc );

		if ( serverResponse.getSuccess() ) {
			var dataToReturn = evaluateResponse( serverResponse = serverResponse );
			event.renderData( type = "json", data = dataToReturn );
		} else {
			sendErrorLog( serverResponse = serverResponse );
		}
	}

	/**
	 * return a single entry, by id
	 */
	remote any function getById( event, rc, prc ){
		var serverResponse =
		dataServer.getById( dataServerName = variables.dataServerName, id = rc.id );

		if ( serverResponse.getSuccess() ) {
			var dataToReturn = evaluateResponse( serverResponse = serverResponse );
			event.renderData( type = "json", data = dataToReturn );
		} else {
			sendErrorLog( serverResponse = serverResponse );
		}
	}

}
