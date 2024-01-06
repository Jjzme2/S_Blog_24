<!--- implements="EntityGateway" --->
<cfcomponent output="false">
	<!--- Define the table name --->
	<cfset tableName = "categories">
	<cfset dataSource = "cash_navigator">

	<!--- Package Access will allow the methods to be called from within the package --->
	<!--- Shouldn't need to change much --->
	<!------------------------------------------------------------------------->
	<!--- Implement the delete method --->
	<cffunction name="deleteAccessObjectByID" access="package" output="false">
		<cfargument name="entityId" type="string" required="true">

		<cfquery datasource=#dataSource#>
			DELETE FROM #tableName#
			WHERE id = <cfqueryparam value="#entityId#" cfsqltype="cf_sql_varchar">
		</cfquery>
	</cffunction>

	<!--- Implement the list method --->
	<cffunction name="list" access="package" returntype="query" output="false">
		<cfquery name="list" datasource=#dataSource#>
			SELECT -- Select the columns you want to return below:
				t.id
				,t.name
				,t.description
				,t.isRecurring
				,t.frequency_id
				,f.name as frequency_name
				,t.categoryType_id
				,c.name as categoryType_name
			FROM #tableName# t
			INNER JOIN frequency f ON t.frequency_id = f.id
			INNER JOIN categoryType c ON t.categoryType_id = c.id
		</cfquery>

		<cfreturn list>
	</cffunction>

	<!--- Implement the list By method --->
	<cffunction name="listCategoriesByType" access="package" returntype="query" output="false">
		<cfargument name="categoryType_id" type="string" required="true">

		<cfquery name="list" datasource=#dataSource#>
			SELECT -- Select the columns you want to return below:
				t.id
				,t.name
				,t.description
				,t.isRecurring
				,t.frequency_id
				,f.name as frequency_name
				,t.categoryType_id
				,c.name as categoryType_name
			FROM #tableName# t
			INNER JOIN frequency f ON t.frequency_id = f.id
			INNER JOIN categoryType c ON t.categoryType_id = c.id

			WHERE c.id = <cfqueryparam value="#categoryType_id#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn list>
	</cffunction>

	<!--- Implement the read method --->
	<cffunction name="getAccessObjectByID" access="package" returntype="query" output="false">
		<cfargument name="entityId" type="string" required="true">

		<cfquery name="get" datasource=#dataSource#>
			SELECT -- Select the columns you want to return below:
				t.id
				,t.name
				,t.description
				,t.isRecurring
				,t.frequency_id
				,f.name as frequency_name
				,t.categoryType_id
				,c.name as categoryType_name
			FROM #tableName# t
			INNER JOIN frequency f ON t.frequency_id = f.id
			INNER JOIN categoryType c ON t.categoryType_id = c.id

			WHERE t.id = <cfqueryparam value="#entityId#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn get>
	</cffunction>

	<!--- Needs more editing --->
	<!------------------------------------------------------------------------->

	<!--- Implement the create method --->
	<cffunction
		name      ="create"
		access    ="package"
		returntype="boolean"
		output    ="false"
		hint      ="Adds a new entry into the database."
	>
		<cfargument name="entity" type="struct" required="true">

		<cfquery datasource=#dataSource#>
			INSERT INTO #tableName# (
				id
				,name
				,description
				,isRecurring
				,frequency_id
				,categoryType_id
				)
			VALUES (
				NEWID(),
				<cfqueryparam value="#entity.getName()#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#entity.getIsRecurring()#" cfsqltype="cf_sql_bit">,
				<cfqueryparam value="#entity.getFrequencyId()#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#entity.getCategoryTypeId()#" cfsqltype="cf_sql_varchar">
			)
		</cfquery>

		<cfreturn true>
	</cffunction>

	<!--- Implement the update method --->
	<cffunction name="updateAccessObjectByID" access="package" returntype="boolean" output="false">
		<cfargument name="currentId" type="string" required="true">
		<cfargument name="entity" type="struct" required="true">

		<cfquery datasource=#dataSource#>
			UPDATE #tableName#
			SET
				id            	 = <cfqueryparam value="#entity.getId()#" cfsqltype="cf_sql_varchar">
				,name    	 	 = <cfqueryparam value="#entity.getName()#" cfsqltype="cf_sql_varchar">
				,description	 = <cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
				,isRecurring	 = <cfqueryparam value="#entity.getIsRecurring()#" cfsqltype="cf_sql_bit">
				,frequency_id	 = <cfqueryparam value="#entity.getFrequencyId()#" cfsqltype="cf_sql_varchar">
				,categoryType_id = <cfqueryparam value="#entity.getCategoryTypeId()#" cfsqltype="cf_sql_varchar">

			WHERE id          	 = <cfqueryparam value="#currentId#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn true>
	</cffunction>
</cfcomponent>
