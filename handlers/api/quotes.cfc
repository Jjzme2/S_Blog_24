/**
 * @Author Jj Zettler
 * @Description This will be the API Handler for the Quote Object
 * @date 12/9/2023
 * @version 0.1
 * @Find = Quote
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="QuoteServer";
	property name="response"  inject="ServerModels/Responses/BaseResponse";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};


	variables.dataServerName = "Quotes";
	variables.pathToThis = "handlers/api/#variables.dataServerName#/";




	/**
	 * Main entry point for the handler, Lists all gratitude entries
	 */
	remote function index( event, rc, prc ){

	// Try to get a response from the server
		try{
			var serverResponse = dataServer
				.getRecordsByActivity(
					status=1
					,dataServerName=variables.dataServerName
				);

			if( serverResponse.getSuccess() ) {
				var dataObjects = serverResponse.getData();

				if( !arrayLen(dataObjects) ){
					return new models.ServerModels.Logs.ErrorLog().init(
						message="No Records Found"
						,source="QuoteHandler"
						,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
						.dump();
				}

				var dataToReturn = [];

				for( obj in dataObjects ){
					arrayAppend(dataToReturn, obj.read());
				}
				event.renderData( type="json", data=dataToReturn );
			}
			else { return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="QuoteHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				.dump();
			}
		}catch( any e ){
			writeDump(var=e, abort=true);
			return new models.ServerModels.Logs.ErrorLog().init(message="ERROR", source="QuoteHandler", error=e).dump();
		}
	}
}
