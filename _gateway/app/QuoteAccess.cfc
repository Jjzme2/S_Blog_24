/**
 * @Author Jj Zettler
 * @Description This will be the access point for the Quote table.
 * @date 9/21/2023
 * @version 0.1
 * @FindOBJECT Quote
 * @FindCOLUMNS t.id
 * ,t.created_on
 * ,t.modified_on
 * ,t.active
 * ,t.tags
 * ,t.author
 * ,t.quote
 * ,t.source
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "quotes">
	<cfset dataSource = application.cbController.getSetting( 'secondaryDatasource' )>



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
				<!--- searchTerm="activ" --->
				,sqlType="cf_sql_bit"
				,searchValue="#arguments.status#"
				,exactMatch=true
				,showInactive=!arguments.status
				)>
		<cfcatch type="any">
			<cfset var messages = ["Quote Access GETBYACTIVITYSTATUS", cfcatch.message]>

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
	<cffunction
	 			name="create"
		access="package"
		returntype="QueryHandler"
		output="false"
		hint="Creates a new Quote object in the database."
	>

	 	<cfargument name="entity" type="QuoteDTO" required="true">

		<cfset var qry = "">
		<cfset var result = "">
		<cfset var message = "">

		<cftry>
			<cfquery name="qry" datasource="#dataSource#" result="result">
				INSERT INTO #tableName# (
					created_on
					,modified_on
					,active
					,tags
					,author
					,quote
					,source
				)
				VALUES (
					<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
					, <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
					, <cfqueryparam value="#arguments.entity.getActive()#" cfsqltype="cf_sql_bit">
					, <cfqueryparam value="#arguments.entity.getTags()#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.entity.getAuthor()#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.entity.getQuote()#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.entity.getSource()#" cfsqltype="cf_sql_varchar">
				)
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Quote Access CREATE.",
					"errorMessage": "#cfcatch.message#",
					"sqlCode": "#cfcatch.additional.sql#",
				 }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn new QueryHandler( qry )>
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
			<cfquery name="qry" datasource="#dataSource#" result="result">
				SELECT t.id
					,t.created_on
					,t.modified_on -- Change made here
					,t.active
					,t.tags
					,t.author
					,t.quote
					,t.source
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
				ORDER BY
					t.author ASC,
					t.source ASC,
					t.quote DESC
			</cfquery>


			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Quote Access GET.",
					"errorMessage": "#cfcatch.message#",
					"sqlCode": "#cfcatch.additional.sql#",
				 }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>


		<cfreturn qry>
	</cffunction>



</cfcomponent>
// cfformat-ignore-end

