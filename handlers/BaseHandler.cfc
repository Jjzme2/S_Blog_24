/**
 * My RESTFul Event Handler
 */
component extends="coldbox.system.RestHandler" {

	// Don't forget to Map in config/Wirebox.cfc where applicable.

	property name="populator" inject="wirebox:populator";
	property name="logbox"    inject="logbox:logger:api";

	// Create a Utility Importer
	property name="utils" inject="UtilityService";


	/**
	 * -----------------------------------------------
	 * HELPERS
	 * -----------------------------------------------
	 */


	public ErrorLog function NewErrorLog( source, error, messages ){
		var errorLog =
		new models.ServerModels.Logs.ErrorLog( source = source, error = error );

		if ( structKeyExists( arguments, "messages" ) ) {
			errorLog.setMessages( messages );
		}

		return errorLog;
	}


	/**
	 * Evaluate the Server Response
	 *
	 * @param serverResponse The server response object
	 * @param allowEmpty     Whether or not to allow empty responses
	 *
	 * @return The data to return
	 */
	public Array function evaluateResponse( serverResponse, allowEmpty = true ){
		var dataObjects       = serverResponse.getData();
		var dataToReturnArray = [];

		if ( dataObjects.isEmpty() && !allowEmpty ) {
			sendErrorLog(
				additionalMessages = [
					"The server response returned no data",
					"The Allow Empty parameter is set to false."
				]
			);
		} else {
			if ( isArray( dataObjects ) )
				for ( obj in dataObjects ) {
					if ( structKeyExists( obj, "read" ) ) {
						// !This is a hack to get around the fact that the data is returned as an array of structs, and an array of objects. This should be fixed in the future.
						arrayAppend( dataToReturnArray, obj.read() );
					}
				}
				else {
					arrayAppend( dataToReturnArray, dataObjects.read() );
				}
		}
		return dataToReturnArray;
	}


	/**
	 * @hint This is a helper function to send an error log to the server.
	 */

	public void function sendErrorLog(
		ServerResponse serverResponse,
		any additionalInfo       = "",
		array additionalMessages = []
	){
		var customError = { "Type" : "Invalid Data" };

		var error =
		newErrorLog( source = "#variables.dataServerName#Handler", error = customError );

		if ( !isNull( arguments.serverResponse ) ) {
			error.addMessage( "The Server Response Failed. This was called from `#serverResponse.getCaller()#`" );
			error.addMessages( serverResponse.getMessages() );
		}

		if ( !isEmpty( additionalMessages ) ) {
			error.addMessages( additionalMessages );
		}

		if ( !isEmpty( additionalInfo ) ) {
			switch ( additionalInfo ) {
				case isStruct( additionalInfo ):
					serializeJSON( var = additionalInfo );
					error.addMessage( "Additional Info: #additionalInfo#" );
					break;
				case isSimpleValue( value = additionalInfo ):
					error.addMessage( "Additional Info: #additionalInfo#" );
					break;
				case isArray( additionalInfo ):
					error.addMessages( additionalInfo );
					break;
				case structKeyExists( additionalInfo, "ErrNumber" ) && structKeyExists( additionalInfo, "ErrorCode" ):
					// This is very likely a CF Error
					error.addMessage( "Additional Info - Error Message: #additionalInfo.Message#" );
					error.addMessage( "Additional Info - Error StackTrace: #left( additionalInfo.StackTrace, 300 )#" );
					for ( var i = 1; i <= arrayLen( additionalInfo.TagContext ); i++ ) {
						error.addMessage(
							chr( 13 ) & chr( 10 ) &
							"Additional Info - Error TagContext: " &
							chr( 13 ) & chr( 10 ) &
							"Plain Code: #additionalInfo.TagContext[ i ].codePrintPlain#" &
							chr( 13 ) & chr( 10 ) &
							"Line: #additionalInfo.TagContext[ i ].line#" &
							chr( 13 ) & chr( 10 ) &
							"Column: #additionalInfo.TagContext[ i ].column#" &
							chr( 13 ) & chr( 10 ) &
							"Template: #additionalInfo.TagContext[ i ].template#"
						);
					}
					break;
				default:
					writeDump(
						var   = additionalInfo,
						label = "Unable to determine the Additional Info passed. Check `BaseHandler.SendErrorLog()` for more info.",
						abort = true
					);
					break;
			}
		}

		error.writeToLogFile();

		if ( isEmpty( arguments.additionalInfo ) ) {
			throw(
				message = "An Error Log has been created.",
				detail  = "Please check '_logs' folder for more information."
			);
		} else {
			throw(
				message      = "An Error Log has been created.",
				detail       = "Please check '_logs' folder for more information.",
				extendedinfo = additionalInfo
			);
		}
	}

	/**
	 * Consider relocating these functions, as they could be placed better elsewhere.
	 */

	/**
	 * @hint  This is a helper function to determine the truth of a value.
	 * @param value The value to determine the truth of.
	 *
	 * @return BIT Values - 1 if the value is true, 0 if the value is false.
	 */
	public numeric function determineTruth( value ){
		var trueStatements = [ "1", "true", "on", "yes" ];

		if ( arrayFind( trueStatements, value ) ) {
			return 1;
		} else {
			return 0;
		}
	}

}
