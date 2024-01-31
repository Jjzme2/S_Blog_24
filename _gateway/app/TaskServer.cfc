/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for the Task object.
 * @date        12/20/2023
 * @version     0.1
 * @Find        = Task
 */
component
	singleton
	accessors="true"
	name     ="TaskServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="TaskAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty TaskDTO.
	 *
	 * @return An empty Task DTO.
	 */
	public TaskDTO function getEmpty(){
		return new models.DTO.TaskDTO();
	}

}
