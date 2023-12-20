/**
 * This will be the service that will handle all the income related functions.
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="incomeServer"  {

	property name="accessGateway" inject="incomeAccess";
	property name="logService" inject="Logger";

	variables.deletePrefix = "servers_income_delete";

	public incomeServer function init ()
	{
		return this;
	}

	/**
	* This will get an empty income.
	* @return An empty income.
	*/
	public incomeDTO function getEmpty ()
	{
		return new models.gateway.cashNav.income.incomeDTO().init();
	}

	/** TODO: STORE OR CREATE?
	 * This will create a new income.
	 * @param income The income to create.
	 * @return The income that was created.
	 */
	public struct function store(required incomeDTO dataToAdd)
	{
		var response = {
			"data" : {},
			"success" : false,
			"message" : ""
		};

		logService.sendSimpleLog(message="Attempting to add: #serializeJSON(dataToAdd)#", prefix="servers_income_create")
		try{
            // Execute
            accessGateway.create(dataToAdd);
			response.success = true;
			response.message = "income created successfully.";
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
	 * This will return the list of all incomes.
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
		  response.message = "incomes listed successfully.";
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
	 * This will read an existing income.
	 * @param id The id of the income to read.
	 * @return The income that was read.
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
            response.message = "income read successfully.";
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
	 * This will update an existing income.
	 * @param id The id of the income to update.
	 * @return The income that was updated.
	 */
	public function update(required string id, required incomeDTO income)
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
            accessGateway.updateAccessObjectByID(id, income);
            // Get New Data
            var newData = accessGateway.getAccessObjectByID(id);
            response.success = true;
            response.message = "income updated successfully.";
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
	 * This will delete an existing income.
	 * @param id The id of the income to delete.
	 * @return The income that was deleted.
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
			logService.sendSimpleLog(message="Attempting to delete item with id: " & id, prefix=#variables.deletePrefix#);
            var data = accessGateway.getAccessObjectByID(id);
            // Execute
            accessGateway.deleteAccessObjectByID(id);
            // Define response
            response.success = true;
            response.message = "income deleted successfully.";
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