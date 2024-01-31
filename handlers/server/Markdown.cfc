/**
 * @Author      Jj Zettler
 * @Description This will be the Server Handler for the Markdown Object
 * @date        9/21/2023
 * @version     0.1
 * @Find        = Markdown
 */
component extends="../BaseHandler" {

	public function Display( event, rc, prc ){
		var docService = utils.getDocUtils();

		var docs = docService.getDocs();

		if ( !structKeyExists( rc, "docId" ) ) {
			throw( "You must pass a docId to the Markdown Display" );
		}

		var doc = docService.find( rc.docId );

		prc.doc = doc;

		event.setView( "Markdown/Display" )
	}

}
