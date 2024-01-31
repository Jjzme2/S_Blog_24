/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the OBJECTNAME Object
 * @date        9/21/2023
 * @version     0.1
 * @Find        = OBJECTNAME
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="OBJECTNAMEServer";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};


	variables.dataServerName = "OBJECTNAMEs";
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";

}
