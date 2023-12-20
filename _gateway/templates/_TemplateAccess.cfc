/**
 * @Author Jj Zettler
 * @Description This will be the access point for the OBJECTNAME table.
 * @date 12/9/2023
 * @version 0.1
 * @FindOBJECT OBJECTNAME
 * @FindCOLUMNS COLS
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "OBJECTNAMEs">

	<!---
	 * -------------------------------------------------------------
	 * 					*Object Retrieval
	 * -------------------------------------------------------------
	 --->

	<cffunction
		name="getByActivityStatus"
		access="package"
		returntype="QueryHandler"
		output="false"
		hint="Gets a QueryHandler object with the data retrieved from the database."
	>

		<cfargument name="status" type="boolean" required="true">

		<cftry>
			<!--- Use the private helper method to get the data we will need --->
			<cfset var qry = get(
				searchTerm="active"
				,sqlType="cf_sql_bit"
				,searchValue="#arguments.status#"
				,exactMatch=true
				,showInactive=!arguments.status
				)>
		<cfcatch type="any">
			<cfset var messages = ["OBJECTNAME Access GETBYACTIVITYSTATUS", cfcatch.message]>
			<cfthrow type="CustomError" message=#serializeJSON(messages)#>
		</cfcatch>
		</cftry>

		<cfreturn new QueryHandler( qry )>
	</cffunction>


	<!---
	 * -------------------------------------------------------------
	 * 					*Object Creation/Edition
	 * -------------------------------------------------------------
	 --->

	<cffunction name="create" access="package" returntype="any" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="OBJECTNAMEDTO" required="true">

		<cftry>
			<cfquery name="qry" datasource="#dataSource#">
				INSERT INTO #tableName# ( COLS )
				VALUES(
					<cfqueryparam value="#entity.getId()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getActive()#" cfsqltype="cf_sql_bit">
					,<cfqueryparam value="#entity.getName()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
				);
				</cfquery>

				<cfset var qry = get(
					searchTerm="id"
					,sqlType="cf_sql_varchar"
					,searchValue="#entity.getId()#"
					,exactMatch=true
					,showInactive=true
					)>
					<cfreturn new QueryHandler( qry )>
				<cfcatch>
					<cfset var messages = ["OBJECTNAME Access CREATE", cfcatch.message]>
					<cfthrow type="CustomError" message=#serializeJSON(messages)#>
					<cfreturn false>
				</cfcatch>
		</cftry>
	</cffunction>


	/**
	 * -------------------------------------------------------------
	 * 							*Private Helpers
	 * -------------------------------------------------------------
	 */

	 <cffunction name="get" access="private" returntype="any" output="false" hint="Gets an entity by the key-value pairs provided">

		<cfargument name="searchValue" type="string"  required="true">
		<cfargument name="searchTerm"  type="string"  required="false" default="id">
		<cfargument name="sqlType"     type="string"  required="false" default="cf_sql_varchar">
		<cfargument name="exactMatch"  type="boolean" required="false" default="true">
		<cfargument name="showInactive"type="boolean" required="false" default="false">


		<cfset searchTerm = 't.' & arguments.searchTerm>

		<cftry>
			<cfquery name="qry" datasource="#dataSource#">
				SELECT COLS

				FROM #tableName# t

				<cfif arguments.exactMatch>
					WHERE #searchTerm# = <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ 'active'>
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
				<cfelse>
					WHERE #searchTerm# LIKE <cfqueryparam value="%#searchValue#%" cfsqltype="#sqlType#">
					<cfif arguments.searchTerm NEQ 'active'>
						AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
					</cfif>
				</cfif>
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in OBJECTNAME Access GET.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn qry>
	</cffunction>

</cfcomponent>
// cfformat-ignore-end
