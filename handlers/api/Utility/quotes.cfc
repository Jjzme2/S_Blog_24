/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the Quote Object
 * @date        12/9/2023
 * @version     0.1
 * @Find        = Quote
 */
component extends="../BaseApiHandler" {

	property name="dataServer" inject="QuoteServer";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.QuoteHandler_only    = "";
	this.QuoteHandler_except  = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};


	variables.dataServerName = "Quotes";
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";

}
