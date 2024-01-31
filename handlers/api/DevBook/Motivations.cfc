/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the Motivation Object
 * @date        9/21/2023
 * @version     0.1
 * @Find        = Motivation
 */
component extends="../BaseApiHandler" {

	property name="dataServer" inject="MotivationServer";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};
	// Set Active somewhere

	variables.dataServerName = "Motivations";
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";
}
