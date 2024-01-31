/**
 * @Author      Jj Zettler
 * @Description This will be the Server Handler for the tests.
 * @date        12/9/2023
 * @version     0.1
 * @Find        = Quote
 */
component extends="../BaseHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.QuoteHandler_only    = "";
	this.QuoteHandler_except  = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};





	/**
	 * Main entry point for the handler, Lists all test entries
	 */
	public function output( event, rc, prc ){
		// * Working
		// var dataToReturn = utils.getDateTimeUtils().convertStringToDate( Now(), 'mm-dd-yyyy' );

		// * Working
		// var dataToReturn = utils.getDateTimeUtils().getTimeUntil('2024-12-25');

		// * Working
		// var dataToReturn = utils.getDateTimeUtils().getTimeSince('2023-12-25');

		// * Working
		// var dataToReturn = utils
		// 	.getDateTimeUtils()
		// 	.getNow( "mmmm dd, yyyy" );

		// * Working
		// var dataToReturn = utils
		// 	.getDateTimeUtils()
		// 	.getLocalTime( "CST" );


		// var dataToReturn = {
		// 	"serverData" : "This is the server data",
		// }

		// 	utils
		// 	.getUtils( name = "log" )
		// 	.writeErrorLog(
		// 		error   = "This is the error Message",
		// 		message = "This is the message",
		// 		source  = "Test output"
		// 	);

		// var dataToReturn = utils
		// 	.getUtils( name = "log" )
		// 	.dumpErrorLog(
		// 		error   = "This is the error",
		// 		message = "This is the message",
		// 		source  = "Test output"
		// 	);

		// var dataToReturn = utils
		// 	.getUtils( 'file' )
		// 	.getFilesInDirectory( '/assets/templates/');

		utils
			.getUtils( "log" )
			.writeErrorLog( message = "This is the message", source = "Server Tests" );

		var otherData = true;

		var dataToReturn = {
			"serverData" : "This is the server data",
			"otherData"  : otherData
		}
		// writeDump(var = utils, abort=true);

		event.renderData( type = "json", data = dataToReturn );
	}

}
