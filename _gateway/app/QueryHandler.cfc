/**
 * I handle all returned queries from the access components.
 * @Authors Jj Zettler
 * @date 12/9/2023
 * @version 0.1
 */
<cfcomponent
	name="QueryHandler"
	output="false"
	hint="I handle all returned queries from the access components."
>

	<cfproperty
		name="qry"
		type="query"
	>

	<!--- Initialize the Query Handler Object  --->
	<cffunction
		name="init"
		output="false"
		returntype="QueryHandler"
		hint="I initialize the query handler."
	>
		<cfargument
			name="qry"
			type="query"
			required="true"
			hint="I am the query to be handled."
		>

		<cfset variables.qry = arguments.qry>

		<cfreturn this>

	</cffunction>


	<!--- Get the number of records in the query --->
	<cffunction
		name="getRecordCount"
		output="false"
		returntype="numeric"
		hint="I return the number of records in the query."
	>
		<cfreturn variables.qry.recordCount>
	</cffunction>

	<!--- Gets the query data as a JSON string --->
	<cffunction
		name="getJson"
		output="false"
		returntype="string"
		hint="I return the query as a JSON string."
	>
		<cfreturn variables.qry.toJson()>
	</cffunction>



	<!--- *Ways to render the returned Query --->

	<!--- Gets the query data as a struct --->
		<cffunction
			name="getStruct"
			output="false"
			returntype="struct"
			hint="I return the query as a struct."
		>
			<cfreturn deserializeJSON(variables.qry.toJson())>
		</cffunction>

	<!--- Gets the query data as an array --->
	<cffunction
		name="getArray"
		output="false"
		returntype="array"
		hint="I return the query as an array, you can specify which values to retrieve."
	>
		<cfargument name="valueToRetrieve" type="array" required="false" default="#["*"]#" hint="I am the value to retrieve from the query.">


		<cfset var arr = []>

		<cfif arrayContains(valueToRetrieve, "*")  or arrayContains(valueToRetrieve, "all") >
			<cfset valueToRetrieve = listToArray(variables.qry.columnList)>
		</cfif>

		<cfloop query="variables.qry">
			<cfset valueToAdd = {}>

			<cfloop array="#valueToRetrieve#" index="i">

			<!--- If the valueToRetrieve doesn't exist in the query, throw an error --->
				<cfif !variables.qry.columnExists(i)>
					<cfthrow message="The value { #i# } does not exist in the query. Please try one from the following list: {#variables.qry.columnList#}">
				</cfif>

				<!--- If the value is empty, don't add it to the array --->
				<cfif variables.qry[i][currentRow] is not "">
					<cfset valueToAdd[i] = variables.qry[i][currentRow]>
				</cfif>


				<cfset valueToAdd[i] = variables.qry[i][currentRow]>
			</cfloop>
			<cfset arrayAppend(arr, "#valueToAdd#")>
		</cfloop>

		<cfreturn arr>
	</cffunction>

	<!--- Returns the data as an object	 --->
	<cffunction
		name="getAsEntity"
		output="false"
		returntype="any"
		hint="I return the query as an object, you can specify which values to retrieve."
	>
		<cfargument name="entityObject" type="any" required="true" hint="The entity object to be used.">

		<cfif variables.qry.recordCount is not 1>
			<cfthrow message="The query has more than one record -- Returned #variables.qry.recordCount#. Please use the getArray() method instead.">
		</cfif>

		<cfset var newObj = duplicate(arguments.entityObject)>
		<cfset application.wirebox.getObjectPopulator().populateFromQuery(target=newObj, qry=variables.qry)>
		<cfset entity = newObj>

		<cfreturn entity>
	</cffunction>

	<!--- Returns an array of objects --->
	<cffunction
		name="getArrayOfObjects"
		output="false"
		returntype="array"
		hint="Returns the query as an array of objects"
	>
		<cfargument name="entityObject" type="any" required="true" hint="The entity object to be used.">

		<cfset var arr = []>

		<cfloop array="#getArray()#" index="index">
			<!--- Populate the objects --->
			<cfset var newObj = duplicate(arguments.entityObject)>
			<cfset application.wirebox.getObjectPopulator().populateFromStruct(target=newObj, memento=index)>
			<cfset objToReturn = newObj>
			<cfset arrayAppend(arr, objToReturn)>
<!--- 			<cfset arrayAppend(arr, newObj.read())> --->
		</cfloop>

		<cfreturn arr>
	</cffunction>

	<!--- Get the data as a single entity or throws an error --->
	<cffunction
		name="getEntity"
		output="false"
		returntype="struct"
		hint="I return the query as a single entity, you can specify which values to retrieve."
	>

		<cfargument name="valueToRetrieve" type="array" required="false" default="#["*"]#" hint="I am the value to retrieve from the query.">

		<cfargument name="forceTop" type="boolean" required="false" default="false" hint="I force the query to return the top record.">

		<cfif arrayContains(valueToRetrieve, "*")  or arrayContains(valueToRetrieve, "all") >
			<cfset valueToRetrieve = listToArray(variables.qry.columnList)>
		</cfif>

		<cfif variables.qry.recordCount is not 1 AND !arguments.forceTop>
			<cfthrow message="The query has more than one record -- Returned #variables.qry.recordCount#. Please use the getArray() method instead, or set 'forceTop' to true">
		</cfif>

		<cfset var entity = {}>

		<cfloop array="#valueToRetrieve#" index="i">

			<!--- If the valueToRetrieve doesn't exist in the query, throw an error --->
			<cfif !variables.qry.columnExists(i)>
				<cfthrow message="The value { #i# } does not exist in the query. Please try one from the following list: {#variables.qry.columnList#}">
			</cfif>

			<!--- If the value is empty, don't add it to the array --->
			<cfif variables.qry[i][1] is not "">
				<cfset entity[i] = variables.qry[i][1]>
			</cfif>
		</cfloop>

		<cfreturn entity>
	</cffunction>




</cfcomponent>