<cfoutput>

	<div class="page-container">

		<div class="page-header">
			<h3> Let's create a new Goal! </h3>
		</div>
		<form action="#event.buildLink("server.devbook.save?page=goal")#" method="post">
			<table>
				<tr>
					<td> Goal Name: </td>
					<td> <input type="text" name="name" value="#rc.goal.getName()#"> </td>
				</tr>

				<tr>
					<td>Goal Activity: </td>
					<td>
						<input
							type="checkbox"
							name="active"
							value="1"
							<cfif rc.goal.getActive() eq true>
								checked
							</cfif>
						>
					</td>
				</tr>

				<tr>
					<td> Goal Description: </td>
					<td> <input
						type="text"
						name="description"
						spellcheck="true"
						value="#rc.goal.getDescription()#"> </td>
				</tr>

				<tr>
					<td> Goal Status </td>
					<td>
						<select name="statusId">
							<option selected hidden value="#rc.goal.getStatusId()#">#rc.goal.getStatus()#</option>
							<cfloop array="#rc.statuses#" item="item">
								<option value="#item.id#">#item.name#</option>
							</cfloop>
					</td>
				</tr>

				<tr>
					<td> Due Date: </td>
					<td> <input type="date" name="dueDate" value="#rc.goal.getDueDate().Format( "yyyy-mm-dd" )#"> </td>
				</tr>

				<tr>
					<td>Tags ( as CSV )</td>
					<td> <input type="text" name="tags" value="#rc.goal.getTags()#"> </td>
				</tr>

				<tr>
					<td>Motivation</td>
					<!--- IMPORT motivations as a select --->
					<td>
						<select name="motivationId">
							<option selected hidden value="#rc.goal.getMotivationId()#">#rc.goal.getMotivation()#</option>
							<cfloop array="#rc.motivations#" item="item">
								<option value="#item.id#">#item.name#</option>
							</cfloop>
						</select>
				</tr>

				<tr>
					<td>
						<input type="submit" value="Save">
					</td>
					<td>
						<button
						onClick="#event.buildLink('server.devbook.goals')#"
						>Go back</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</cfoutput>