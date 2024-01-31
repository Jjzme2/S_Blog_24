/**
 * @Author      Jj Zettler
 * @Description This will be the Server Handler for the Template Object
 * @date        1/31/2024
 * @version     0.1
 * @Find        = Template
 */
component extends="../BaseHandler" {


	/**
	 * @function    Display
	 * @description This will display the template
	 * @date        1/31/2024
	 * @version     0.1
	 * @return      void
	 */
	public function Display( event, rc, prc ) {
		var fileService = utils.getFileUtils();

		var directory = "/assets/templates/";

		var fileName = rc.fileName & ".cfc";

		var content = fileService.readFile( directory=directory, fileName=fileName );

		prc.content = content;

		event.setView( "Template/Display" )
	}
}
