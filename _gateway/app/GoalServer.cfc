/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for this named object.
 * @date        9/21/2023
 * @version     0.1
 * @Find        = Goal
 */
component
	singleton
	accessors="true"
	name     ="GoalServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="GoalAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty GoalDTO.
	 *
	 * @return An empty Goal DTO.
	 */
	public GoalDTO function getEmpty(){
		return new models.DTO.GoalDTO();
	}

}
