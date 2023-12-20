/**
 * @Author Jj Zettler
 * @Description This will be the API Handler for the Post Object
 * @date 9/21/2023
 * @version 0.1
 * @Find = Post
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="PostServer";
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


	variables.dataServerName = "Posts";
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
				var dataToReturn = [];

				if(dataObjects.isEmpty())
					return new models.ServerModels.Logs.ErrorLog()
					.init(
						error={'Server Messages': serverResponse.getMessages(),
								"Consider: ": "The Server response returned successfully."
						},
						message="Data returned an empty string.",
						source="PostHandler")
					.dump();

				if( isArray(dataObjects))
					for( obj in dataObjects ){
						arrayAppend(dataToReturn, obj.read());
					}
				else{
					arrayAppend(dataToReturn, dataObjects.read());
				}
				event.renderData( type="json", data=dataToReturn );
			} else { return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="PostHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				.dump();
			}
		}catch( any e ){
			writeDump(var=e, abort=true);
			return new models.ServerModels.Logs.ErrorLog().init(message="ERROR", source="PostHandler", error=e).dump();
		}
	}

	remote function createNew( event, rc, prc ){

		var propertyArray = [
			'name'
			,'description'
			,'active'
			,'bodyContent'
		];

		var objectData = {};

		for( property in propertyArray ){
			if( structKeyExists(rc, property) ){
				objectData[property] = rc[property];
			}
		}

		// writeDump(var=objectData, abort=true);

		var serverResponse = dataServer.create( dataServerName=variables.dataServerName, data=objectData );

		if( serverResponse.getSuccess() ){
			event.renderData( type="json", data=serverResponse.getData().read() );
		} else {
			return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="PostHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				// !Create an error struct that will return if successful, and a custom error (See above) if not.
				// ,error=serverResponse.getErrorStruct())
				.dump();
		}
	}


	remote function getEmpty( event, rc, prc ){
		var dataObject = dataServer.getEmpty( dataServerName=variables.dataServerName );
		event.renderData( type="json", data=dataObject.read() );
	}


	remote function getPostById( event, rc, prc ){
		var serverResponse = dataServer.getRecordById( id=rc.id, dataServerName=variables.dataServerName );

		if( serverResponse.getSuccess() ){
			event.renderData( type="json", data=serverResponse.getData().read() );
		} else {
			return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="PostHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				// !Create an error struct that will return if successful, and a custom error (See above) if not.
				// ,error=serverResponse.getErrorStruct())
				.dump();
		}
	}
}
