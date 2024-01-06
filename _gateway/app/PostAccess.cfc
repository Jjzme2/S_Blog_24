/**
 * ,t.created_on
 * ,t.modified_on
 * ,t.active
 * ,t.name
 * ,t.description
 * ,t.body_content
 *
 * @Author      Jj Zettler
 * @Description This will be the access point for the post table.
 * @date        12/9/2023
 * @version     0.1
 * @FindOBJECT  post
 * @FindCOLUMNS t.id
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "posts">

	<!---
	 * -------------------------------------------------------------
	 * 					*Object Retrieval
	 * -------------------------------------------------------------
	 --->

	<cffunction
		name      ="getByActivityStatus"
		access    ="package"
		returntype="QueryHandler"
		output    ="false"
		hint      ="Gets a QueryHandler object with the data retrieved from the database."
	>

		<cfargument name="status" type="boolean" required="true">

		<cftry>
			<!--- Use the private helper method to get the data we will need --->
			<cfset var qry = get(
				searchTerm="active"
				,sqlType     ="cf_sql_bit"
				,searchValue ="#arguments.status#"
				,exactMatch  =true
				,showInactive=!arguments.status
				)>
		<cfcatch type="any">
			<cfset var messages = ["post Access GETBYACTIVITYSTATUS", cfcatch.message]>
			<cfthrow type="CustomError" message=#serializeJSON(messages)#>
		</cfcatch>
		</cftry>

		<cfreturn new QueryHandler( qry )>
	</cffunction>

	<cffunction
		name="getById"
		access="package"
		returntype="QueryHandler"
		output=false
		hint="Gets a QueryHandler with the data given an id.">

		<cfargument name="id" type="string" required="true">

		<cftry>
			<!--- Use the private helper method to get the data we will need --->
			<cfset var qry = get(
				searchTerm="id"
				,sqlType     ="cf_sql_varchar"
				,searchValue ="#arguments.id#"
				,exactMatch  =true
				,showInactive=true
				)>
		<cfcatch type="any">
			<cfset var messages = ["post Access GETBYID", cfcatch.message]>
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
		<cfargument name="entity" type="postDTO" required="true">

		<cftry>
			<cfquery name="createQry" datasource="#dataSource#">
				INSERT INTO #tableName# (
					id
					,active
					,name
					,description
					,body_content
					,intent
					,category_id
				 )
				VALUES(
					<cfqueryparam value="#entity.getId()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getActive()#" cfsqltype="cf_sql_bit">
					,<cfqueryparam value="#entity.getTitle()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getBodyContent()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getIntent()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getCategory().id#" cfsqltype="cf_sql_varchar">
				);
			</cfquery>
		<cfcatch>
			<cfset var messages = ["post Access CREATE", cfcatch.message]>
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
				SELECT t.id
					,t.created_on as createdOn
					,t.modified_on as modifiedOn
					,t.active
					,t.name as title
					,t.description
					,t.body_content as bodyContent
					,t.intent as intent
					,(SELECT JSON_OBJECT(
						'name', c.name,
						'id', c.id
						)
					FROM post_categories AS c
					WHERE c.id = t.category_id
					) AS category
				FROM #tableName# t
				LEFT JOIN post_categories c
					ON t.category_id = c.id
				<cfif arguments.exactMatch>
					WHERE #searchTerm# = <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ 'active'>
							<cfif !arguments.showInactive>
								AND t.active = 1
							</cfif>
						</cfif>
				<cfelse>
					WHERE #searchTerm# LIKE <cfqueryparam value="%#searchValue#%" cfsqltype="#sqlType#">
					<cfif arguments.searchTerm NEQ 'active'>
						AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
					</cfif>
				</cfif>
				GROUP BY t.id
					,t.created_on
					,t.modified_on
					,t.active
					,t.name
					,t.description
					,t.body_content
					,t.intent
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in post Access GET.",
					"errorMessage" : "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn qry>
	</cffunction>

</cfcomponent>
// cfformat-ignore-end
