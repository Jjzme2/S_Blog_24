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
	this.QuoteHandler_only     = "";
	this.QuoteHandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};





	/**
	 * Main entry point for the handler, Lists all test entries
	 */
	public function output( event, rc, prc ) {
		// var dataToReturn = utils.getDateUtils().getNow('mmmm dd, yyyy');
		// var dataToReturn = utils.getDateUtils().getTimeSince('2023-12-25');

		var dataToReturn = {
			"serverData" : "This is the server data",
		}
		event.renderData( type = "json", data = dataToReturn );
	}

}
