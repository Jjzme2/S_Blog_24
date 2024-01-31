/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for the Tip object.
 * @date        12/20/2023
 * @version     0.1
 * @Find        = Tip
 */
component
	singleton
	accessors="true"
	name     ="TipServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="TipAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty TipDTO.
	 *
	 * @return An empty Tip DTO.
	 */
	public TipDTO function getEmpty(){
		return new models.DTO.TipDTO();
	}

}
