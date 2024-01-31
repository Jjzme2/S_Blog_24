/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for the Note object.
 * @date        12/20/2023
 * @version     0.1
 * @Find        = Note
 */
component
	singleton
	accessors="true"
	name     ="NoteServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="NoteAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty NoteDTO.
	 *
	 * @return An empty Note DTO.
	 */
	public NoteDTO function getEmpty(){
		return new models.DTO.NoteDTO();
	}

}
