/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for the postCategory object.
 * @date        12/20/2023
 * @version     0.1
 * @Find        = postCategory
 */
component
	singleton
	accessors="true"
	name     ="postCategoryServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="PostCategoryAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty postCategoryDTO.
	 *
	 * @return An empty postCategory DTO.
	 */
	public postCategoryDTO function getEmpty(){
		return new models.DTO.postCategoryDTO();
	}

}
