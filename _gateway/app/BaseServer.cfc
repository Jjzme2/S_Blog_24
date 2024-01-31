/**
 * This will be the service that will handle all the BASE SERVER(SERVICE) functions.
 *
 * @Authors Jj Zettler
 * @date    12/9/2023
 * @version 0.1
 */
component singleton accessors="true" name="BaseServer" {

	// property name="populator" inject="wirebox:populator";
	// property name="wirebox"   inject="Wirebox";

	property name="utils" inject="UtilityService";

	property name="objectUtil" inject="WireboxService";

	// public any function init(){
	// 	return this;
	// }

	/**
	 * Instantiate a ServerResponse object.
	 */
	public ServerResponse function serverResponse(){
		var newResponse = utils
			.getWireboxUtils()
			.getObject( "ServerResponse" );
		return newResponse;
	}


	/**
	 * --------------------------------------------------------
	 * Helper Functions
	 * --------------------------------------------------------
	 */

	/**
	 * Evaluate the records from the query handler.
	 *
	 * @param {ServerResponse} res        Response object.
	 * @param {QueryHandler}   qryHandler Query handler object.
	 * @param {Number}         records    Number of records.
	 */
	public ServerResponse function evaluateRecordsFromQueryHandler(
		required ServerResponse res,
		required QueryHandler qryHandler,
		required Number records
	){
		switch ( records ) {
			case 0:
				res.addMessage( "No records found." );
				res.setData( [] );
				break;
			case 1:
				res.addMessage( "Found one record in BaseServer.getRecordsByActivity" );
				res.setData( [ qryHandler.getAsEntity( this.getEmpty() ) ] );
				break;
			default:
				res.addMessage( "Found #records# records in BaseServer.getRecordsByActivity" );
				res.setData( qryHandler.getArrayOfObjects( this.getEmpty() ) );
				break;
		}
		return res;
	}

	private function createResponseFromError( any e, required ServerResponse res ){
		res.addMessage( "Error Message: #e.message#" );
		res.addMessage( "Error Details: #e.detail#" );
		// additional, code, Detail, ErrorCode, Extended_Info, ExtendedInfo, Message, StackTrace, TagContext, type
		for ( context in e.TagContext ) {
			var msg = "
				|LOCATION|       = #context.Template# --
				|LINE|           = #context.Line# --
				|CODEPRINTPLAIN| = #context.CodePrintPlain#
			";
			res.addMessage( msg );
		}
		res.addMessage( "Error Details: #e.message#" );
		res.setSuccess( false );
	}

	/**
	 * Get records by activity status and data server name.
	 *
	 * @param status           Required boolean, activity status.
	 * @param dataServerName   Required string, data server name.
	 *
	 * @return ServerResponse  Response object with query results.
	 */
	public ServerResponse function getRecordsByActivity( required boolean status, required string dataServerName ){
		var res = serverResponse().init(
			server = arguments.dataServerName,
			caller = "BaseServer.getRecordsByActivity"
		);

		try {
			var qryHandler = accessPoint.getByActivityStatus( status );
			res            = evaluateRecordsFromQueryHandler( res, qryHandler, qryHandler.getRecordCount() );
		} catch ( any e ) {
			createResponseFromError( e, res );
		}
		return res;
	}

	public ServerResponse function getRecordById( required string id, required string dataServerName ){
		var res = serverResponse().init( server = arguments.dataServerName, caller = "BaseServer.getRecordById" );

		try {
			var qryHandler = accessPoint.getById( id );
			res            = evaluateRecordsFromQueryHandler( res, qryHandler, qryHandler.getRecordCount() );
		} catch ( any e ) {
			createResponseFromError( e, res );
		}
		return res;
	}


	public ServerResponse function create( required any dataServerName, required any payload ){
		var res = serverResponse().init( server = arguments.dataServerName, caller = "BaseServer.create" );

		var payloadAsDTO = utils
			.getWireboxUtils()
			.getPopulator()
			.populateFromStruct( target = this.getEmpty(), memento = payload );

		try {
			var qryHandler = accessPoint.create( payloadAsDTO );
			return getRecordById( payload.id, dataServerName );
		} catch ( any e ) {
			createResponseFromError( e, res );
		}
		return res;
	}

	public ServerResponse function deactivate( required any dataServerName, required string id ){
		var res = serverResponse().init( server = arguments.dataServerName, caller = "BaseServer.deactivate" );


		try {
			var qryHandler = accessPoint.setActive( entityId = id, active = 0 );

			return getRecordById( id, dataServerName );
		} catch ( any e ) {
			createResponseFromError( e, res );
		}
		return res;
	}

}
