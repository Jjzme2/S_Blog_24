/**
 * @Author      Jj Zettler
 * @Description This will be the API Handler for the PostCategory Object
 * @date        12/9/2023
 * @version     0.1
 * @Find        = PostCategory
 */
component extends="../BaseApiHandler" {

	property name="dataServer" inject="PostCategoryServer";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};


	variables.dataServerName = "PostCategories";
	variables.pathToThis     = "handlers/api/#variables.dataServerName#/";

}
