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
			route( "/", "output" );
		} );

		group( { "pattern" : "/server/Markdown", "target" : "server.Markdown." }, function(){
			route( "/display/:docId", "Display" );
		} );

		group( { "pattern" : "/server/Template", "target" : "server.Template." }, function(){
			route( "/display/:fileName", "Display" );
		} );




		/**
		 * --------------------------------------------------------------------------
		 * API Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your API application!
		 */

		 /**
		  * --------------------------------------------------------------------------
		  * ? UTILITY
		  * --------------------------------------------------------------------------
		  */

		// *API Quotes
		group( { "pattern" : "/api/Utility/quotes", "target" : "api.Utility.Quotes." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "create" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );


		/**
		 * --------------------------------------------------------------------------
		 * ? BLOG
		 * --------------------------------------------------------------------------
		 */

		// Posts

		// *API Post
		group( { "pattern" : "/api/Blog/posts", "target" : "api.Blog.Posts." }, function(){
			get( "/empty", "getEmpty" )
			get( "/show/:id", "getById" )
			get( "/", "index" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API POST Categories
		group(
			{
				"pattern" : "/api/Blog/postCategories",
				"target"  : "api.Blog.PostCategories."
			},
			function(){
				get( "/empty", "getEmpty" )
				get( "/", "index" )
				get( "/:id", "getById" )
				post( "/", "create" )
				put( "/:id", "update" )
				delete( "/:id", "delete" )
				options( "/", "preflight" )
			}
		);

		/**
		 * --------------------------------------------------------------------------
		 * ? DEVBOOK
		 * --------------------------------------------------------------------------
		 */

		// *API Goals
		group( { "pattern" : "/api/Devbook/goals", "target" : "api.DevBook.Goals." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Motivations
		group( { "pattern" : "/api/Devbook/motivations", "target" : "api.DevBook.Motivations." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Notes
		group( { "pattern" : "/api/Devbook/notes", "target" : "api.DevBook.Notes." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Reminders
		group( { "pattern" : "/api/Devbook/reminders", "target" : "api.DevBook.Reminders." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Statuses
		group( { "pattern" : "/api/Devbook/statuses", "target" : "api.DevBook.Statuses." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Suggestions
		group( { "pattern" : "/api/Devbook/suggestions", "target" : "api.DevBook.Suggestions." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Tasks
		group( { "pattern" : "/api/Devbook/tasks", "target" : "api.DevBook.Tasks." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		} );

		// *API Tips
		group( { "pattern" : "/api/Devbook/tips", "target" : "api.DevBook.Tips." }, function(){
			get( "/empty", "getEmpty" )
			get( "/", "index" )
			get( "/:id", "getById" )
			post( "/", "createNew" )
			put( "/:id", "update" )
			delete( "/:id", "delete" )
			options( "/", "preflight" )
		});

		// Conventions-Based Routing
		route( ":handler/:action?" ).end();
	}

}
