/**
 * This will be the service that will handle all the Expense related functions.

 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="ExpenseServer"  {

	property name="accessGateway" inject="ExpenseAccess";

	public ExpenseServer function init ()
	{
		return this;
	}

	/**
	* This will get an empty Expense.
	* @return An empty Expense.
	*/
	public ExpenseDTO function getEmpty ()
	{
		return new models.gateway.cashNav.expense.ExpenseDTO();
	}

	/**
	 * This will create a new Expense.
	 * @param Expense The Expense to create.
	 * @return The Expense that was created.
	 */
	public struct function store(required ExpenseDTO dataToAdd)
	{
		var response = {
			"data" : {},
			"success" : false,
			"message" : ""
		};

		try{
            // Execute
            accessGateway.create(dataToAdd);
			response.success = true;
			response.message = "Expense created successfully.";
			response.data = dataToAdd;
		}
		catch(any e){
			response.message = e.message;
			response.data = nullValue();
			response.success = false;
			throw(e);
		}

		return response;
	}

	/**
	 * This will return the list of all Expenses.
	 * @return
	 */
	public function list()
	{
		var response = {
			"data" : {},
			"success" : false,
			"message" : ""
		};

		try{
		  var data = accessGateway.list();
		//   TODO: This will return a query as is, this should be converted to an array of structs. This is what response.data should be.
		  response.success = true;
		  response.message = "Expenses listed successfully.";
		  response.data = data;
		}
		catch(any e){
			response.message = e.message;
			response.data = nullValue();
			response.success = false;
			throw(e);
		}
		return response;
	}

	/**
	 * This will read an existing Expense.
	 * @param id The id of the Expense to read.
	 * @return The Expense that was read.
	 */
	public function read(required string id)
	{
        var response = {
            "data" : {},
            "success" : false,
            "message" : ""
        };

        try{
            var data = accessGateway.getAccessObjectByID(id);
            response.success = true;
            response.message = "Expense read successfully.";
            response.data = data;
        }
        catch(any e){
            response.message = e.message;
            response.data = nullValue();
            response.success = false;
            throw(e);
        }

		return response;
	}

	/**
	 * This will update an existing Expense.
	 * @param id The id of the Expense to update.
	 * @return The Expense that was updated.
	 */
	public function update(required string id, required ExpenseDTO Expense)
	{
        var response = {
            "data" : {},
            "success" : false,
            "message" : ""
        };

        try{
            // Get Old Data
            var oldData = accessGateway.getAccessObjectByID(id);
            // Execute
            accessGateway.updateAccessObjectByID(id, Expense);
            // Get New Data
            var newData = accessGateway.getAccessObjectByID(id);
            response.success = true;
            response.message = "Expense updated successfully.";
            response.data = {
                "oldData" : oldData,
                "newData" : newData
            }
        }
        catch(any e){
            response.message = e.message;
            response.data = nullValue();
            response.success = false;
            throw(e);
        }
		return response;
	}

	/**
	 * This will delete an existing Expense.
	 * @param id The id of the Expense to delete.
	 * @return The Expense that was deleted.
	 */
	public function delete(required string id)
	{
        var response = {
            "data" : {},
            "success" : false,
            "message" : ""
        };

        try{
            // Get the data before deleting it.
            var data = accessGateway.getAccessObjectByID(id);
            // Execute
            accessGateway.deleteAccessObjectByID(id);
            // Define response
            response.success = true;
            response.message = "Expense deleted successfully.";
            response.data = data;
        }
        catch(any e){
            response.message = e.message;
            response.data = nullValue();
            response.success = false;
            throw(e);
        }

		return response;
	}
}