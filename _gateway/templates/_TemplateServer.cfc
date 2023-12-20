/**
 * @Author Jj Zettler
 * @Description This will be the service that will handle all the related functions for the OBJECTNAME object.
 * @date 12/20/2023
 * @version 0.1
 * @Find = OBJECTNAME
 */
component singleton
	accessors="true"
	name="OBJECTNAMEServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="OBJECTNAMEAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty OBJECTNAMEDTO.
	 * @return An empty OBJECTNAME DTO.
	 */
	public OBJECTNAMEDTO function getEmpty()
	{
		return new models.DTO.OBJECTNAMEDTO();
	}
}
