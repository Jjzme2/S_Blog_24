<!--- implements="EntityGateway" --->
<cfcomponent output="false">
	<!--- Define the table name --->
	<cfset tableName = "expenses"><!--- SET THIS --->
	<cfset dataSource = "cash_navigator"><!--- SET THIS --->

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
			SELECT
				t.id
				,t.amount
				,t.category_id
				,c.name as category_name
				,COALESCE(
					t.description, -- Default to the description
					c.description, -- If the description is null, use the category description
					'No Description' -- If the category description is null, use this
				) as description
				,DATE_FORMAT(t.due_date, '%m/%d/%Y') AS due_date
				,t.note
				,t.is_paid
			FROM #tableName# t
			LEFT JOIN categories c ON c.id = t.category_id

			ORDER BY
				t.due_date DESC
				,c.name ASC
				,description ASC
				,t.amount DESC
		</cfquery>

		<cfreturn list>
	</cffunction>

	<!--- Implement the read method --->
	<cffunction name="getAccessObjectByID" access="package" returntype="query" output="false">
		<cfargument name="entityId" type="string" required="true">

		<cfquery name="get" datasource=#dataSource#>
			SELECT -- Select the columns you want to return below:
				t.id
				,t.amount
				,t.category_id
				,c.name as category_name
				,COALESCE(
					t.description, -- Default to the description
					c.description, -- If the description is null, use the category description
					'No Description' -- If the category description is null, use this
				) as description
				,DATE_FORMAT(t.due_date, '%m/%d/%Y') AS due_date
				,t.note
				,t.is_paid
			FROM #tableName# t
			LEFT JOIN categories c ON c.id = t.category_id

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
				,amount
				,category_id
				,description
				,due_date
				,note
				,is_paid
				)
			VALUES (
				<cfqueryparam value="#entity.getId()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#entity.getAmount()#" cfsqltype="cf_sql_numeric">
				,<cfqueryparam value="#entity.getCategoryID()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#entity.getDueDate()#" cfsqltype="cf_sql_timestamp">
				,<cfqueryparam value="#entity.getNote()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#entity.getIsPaid()#" cfsqltype="cf_sql_tinyint">
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
				,amount    	 	 = <cfqueryparam value="#entity.getAmount()#" cfsqltype="cf_sql_numeric">
				,category_id	 = <cfqueryparam value="#entity.getCategoryID()#" cfsqltype="cf_sql_varchar">
				,description	 = <cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
				,due_date		 = <cfqueryparam value="#entity.getDueDate()#" cfsqltype="cf_sql_timestamp">
				,note			 = <cfqueryparam value="#entity.getNote()#" cfsqltype="cf_sql_varchar">
				,is_paid		 = <cfqueryparam value="#entity.getIsPaid()#" cfsqltype="cf_sql_tinyint">

			WHERE id          	 = <cfqueryparam value="#currentId#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn true>
	</cffunction>
</cfcomponent>
