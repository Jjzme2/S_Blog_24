/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ){
			return "Ok!";
		} );



		/**
		 * --------------------------------------------------------------------------
		 * Server Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web server!
		 */
		group( { "pattern" : "/server/tests", "target" : "server.tests." }, function(){
			route("/", "output" );
		} );







		/**
		 * --------------------------------------------------------------------------
		 * API Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your API application!
		 */

		// *API Quotes
		group( { "pattern" : "/api/quotes", "target" : "api.Quotes." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "show" )
			post( "/", "create" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// Posts

		// *API Post
		group( { "pattern" : "/api/posts", "target" : "api.Posts." }, function(){
			get( "/empty", "getEmpty" )
			get( "/show/:id", "showGoal" )
			get( "/", "index" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API POST Categories
		group( { "pattern" : "/api/postCategories", "target" : "api.PostCategories." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "show" )
			post( "/", "create" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// Conventions-Based Routing
		route( ":handler/:action?" ).end();
	}

}
