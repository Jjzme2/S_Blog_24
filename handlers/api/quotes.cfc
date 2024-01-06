/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the Quote Object
 * @date        12/9/2023
 * @version     0.1
 * @Find        = Quote
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="QuoteServer";
	property name="response"   inject="ServerModels/Responses/BaseResponse";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.QuoteHandler_only     = "";
	this.QuoteHandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};


	variables.dataServerName = "Quotes";
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";




	/**
	 * Main entry point for the handler, Lists all gratitude entries
	 */
	remote function index( event, rc, prc ){
		// Try to get a response from the server
		try {
			var serverResponse = dataServer.getRecordsByActivity( status = 1, dataServerName = variables.dataServerName );

			if ( serverResponse.getSuccess() ) {
				var dataObjects = serverResponse.getData();
				var dataToReturn = [];

				if( dataObjects.isEmpty() )
					return new models.ServerModels.Logs.ErrorLog()
						.init(
							message = "Data returned an empty value.",
							source  = "QuoteHandler",
							error   = {
								"Messages"   : serverResponse.getMessages(),
								"Consider: " : "The Server response returned successfully."
							}).dump();

				if ( isArray( dataObjects ) ) {
					for ( obj in dataObjects ){
						if( structKeyExists(obj, 'read') )
						// !This is a hack to get around the fact that the data is returned as an array of structs, and an array of objects. This should be fixed in the future.
							arrayAppend( dataToReturn, obj.read() );
					}
				}
				else arrayAppend( dataToReturn, dataObjects.read() );


				event.renderData( type = "json", data = dataToReturn );
			} else {
				return new models.ServerModels.Logs.ErrorLog()
					.init(
						message = "The Server Response has encountered an error",
						source  = "QuoteHandler",
						error   = {
							"Messages"  : serverResponse.getMessages(),
							"Called By" : serverResponse.getCaller()
						}
					)
					.dump();
			}
		} catch ( any e ) {
			writeDump( var = e, abort = true );
			return new models.ServerModels.Logs.ErrorLog()
				.init(
					message = "ERROR",
					source  = "QuoteHandler",
					error   = e
				)
				.dump();
		}
	}

}
