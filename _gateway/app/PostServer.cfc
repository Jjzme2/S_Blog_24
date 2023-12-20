/**
 * @Author Jj Zettler
 * @Description This will be the service that will handle all the related functions for the Post object.
 * @date 12/20/2023
 * @version 0.1
 * @Find = Post
 */
component singleton
	accessors="true"
	name="PostServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="PostAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty PostDTO.
	 * @return An empty Post DTO.
	 */
	public PostDTO function getEmpty()
	{
		return new models.DTO.PostDTO();
	}
}
