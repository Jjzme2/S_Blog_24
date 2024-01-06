/**
 * @Author      Jj Zettler
 * @Description This will be the service that will handle all the related functions for the Quote object.
 * @date        12/20/2023
 * @version     0.1
 * @Find        = Quote
 */
component
	singleton
	accessors="true"
	name     ="QuoteServer"
	extends  ="BaseServer"
{

	property name="accessPoint" inject="QuoteAccess";

	/**
	 * ----------------------------------------------------------------------------------------------
	 * *OBJECT INSTANTIATION
	 * ----------------------------------------------------------------------------------------------
	 */

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty QuoteDTO.
	 *
	 * @return An empty Quote DTO.
	 */
	public QuoteDTO function getEmpty(){
		return new models.DTO.QuoteDTO();
	}

}
