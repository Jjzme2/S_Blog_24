/**
 * This will be the service that will handle all the Category related functions.
 *
 * @Author  Jj Zettler
 * @date    4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="CategoryServer" {

	property name="accessGateway" inject="CategoryAccess";

	public CategoryServer function init(){
		return this;
	}

	/**
	 * This will get an empty Category.
	 *
	 * @return An empty Category.
	 */
	public CategoryDTO function getEmpty(){
		return new models.DTO.CategoryDTO();
	}

	/**
	 * This will create a new Category.
	 *
	 * @param Category The Category to create.
	 *
	 * @return The Category that was created.
	 */
	public struct function create( required CategoryDTO dataToAdd ){
		var response = { "data" : {}, "success" : false, "message" : "" };

		try {
			// Execute
			accessGateway.create( dataToAdd );
			response.success = true;
			response.message = "Category created successfully.";
			response.data    = dataToAdd;
		} catch ( any e ) {
			response.message = e.message;
			response.data    = nullValue();
			response.success = false;
			throw( e );
		}

		return response;
	}

	/**
	 * This will return the list of all Categorys.
	 *
	 * @return
	 */
	public function list( id ){
		var response = { "data" : {}, "success" : false, "message" : "" };
		var data     = {};

		try {
			if ( isNull( id ) ) {
				data = accessGateway.list();
			} else {
				data = accessGateway.listCategoriesByType( id );
			}
			//   TODO: This will return a query as is, this should be converted to an array of structs. This is what response.data should be.
			response.success = true;
			response.message = "Categorys listed successfully.";
			response.data    = data;
		} catch ( any e ) {
			response.message = e.message;
			response.data    = nullValue();
			response.success = false;
			throw( e );
		}
		return response;
	}

	/**
	 * This will read an existing Category.
	 *
	 * @param id The id of the Category to read.
	 *
	 * @return The Category that was read.
	 */
	public function read( required string id ){
		var response = { "data" : {}, "success" : false, "message" : "" };

		try {
			var data         = accessGateway.getAccessObjectById( id );
			response.success = true;
			response.message = "Category read successfully.";
			response.data    = data;
		} catch ( any e ) {
			response.message = e.message;
			response.data    = nullValue();
			response.success = false;
			throw( e );
		}

		return response;
	}

	/**
	 * This will update an existing Category.
	 *
	 * @param id The id of the Category to update.
	 *
	 * @return The Category that was updated.
	 */
	public function update( required string id, required CategoryDTO Category ){
		var response = { "data" : {}, "success" : false, "message" : "" };

		try {
			// Get Old Data
			var oldData = accessGateway.getAccessObjectById( id );
			// Execute
			accessGateway.updateAccessObjectByID( id, Category );
			// Get New Data
			var newData      = accessGateway.getAccessObjectById( id );
			response.success = true;
			response.message = "Category updated successfully.";
			response.data    = { "oldData" : oldData, "newData" : newData }
		} catch ( any e ) {
			response.message = e.message;
			response.data    = nullValue();
			response.success = false;
			throw( e );
		}
		return response;
	}

	/**
	 * This will delete an existing Category.
	 *
	 * @param id The id of the Category to delete.
	 *
	 * @return The Category that was deleted.
	 */
	public function delete( required string id ){
		var response = { "data" : {}, "success" : false, "message" : "" };

		try {
			// Get the data before deleting it.
			var data = accessGateway.getAccessObjectById( id );
			// Execute
			accessGateway.deleteAccessObjectByID( id );
			// Define response
			response.success = true;
			response.message = "Category deleted successfully.";
			response.data    = data;
		} catch ( any e ) {
			response.message = e.message;
			response.data    = nullValue();
			response.success = false;
			throw( e );
		}

		return response;
	}

}
