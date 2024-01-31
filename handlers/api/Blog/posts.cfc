/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the Post Object
 * @date        9/21/2023
 * @version     0.1
 * @Find        = Post
 */
component extends="../BaseApiHandler" {

	property name="dataServer" inject="PostServer";

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
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";

}
