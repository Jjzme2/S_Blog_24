/**
 * My RESTFul Event Handler
 */
component extends="./BaseHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	 * Say Hello
	 *
	 * @x        -route          (GET) /api/echo
	 * @response -default ~echo/index/responses.json##200
	 */
	function index( event, rc, prc ){
		event
			.getResponse()
			.setData( "Welcome to the Server Main Display." );
	}

	function Error( event, rc, prc ){
		// event
		// 	.getResponse()
		// 	.setStatus( 500 )
		// 	.setData( "Error" );
		event.setView( "Display/Error" );
	}

	function Main( event, rc, prc ){
		prc.routes = controller
			.getRoutingService()
			.getRouter()
			.getRoutes();

		prc.docs = utils
			.getDocUtils()
			.getDocs();

		prc.templates = [
			{
				name: "AccessTemplate",
				fileName:"TemplateAccess"
			},
			{
				name: "ObjectDTO",
				fileName:"ObjectDTO"
			},
			{
				name: "TemplateServer",
				fileName:"TemplateServer"
			},
			{
				name: "TemplateHandler",
				fileName:"TemplateHandler"
			},
			// * Add files to the directory `/assets/templates/` and add them here to add a new Template to be copied. (Name is a readable name, fileName is the name of the file in the directory )
		];

		event.setView( "Display/Main" );
	}

}
