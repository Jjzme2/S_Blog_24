<cfoutput>
	<div style="text-align: center;">
		<h1>Goals</h1>

		<a href="#event.buildLink('server.devbook.create.Goal' )#">
			<button class="cstm-btn">
				Create Goal
			</button>
		</a>

		<cfif !structKeyExists(prc, 'goals') || len(prc.goals) LT 1>
			<p>No goals found.</p>
		<cfelse>
			<p>
				#arrayLen(prc.goals)#
				#arrayLen(prc.goals) EQ 1 ? 'Goal'
					: "Goals"#
				found.</p>

				<cfloop array=#prc.goals# item="goal">
					<ul>
						<div class="card" style="width: 75rem; margin: auto;">
							<button
								onclick="window.location.href='#event.buildLink('server.devbook.deactivate?page=goal&goalId=#goal.id#')#'"
								class="cstm-btn-close"
							>
							X
							</button>

							<table>
								<thead>
									<th>Name</th>
									<th>Description</th>
									<th>Status</th>
									<th>Motivation</th>
								</thead>

								<tbody>
									<tr>
										<td>#goal.name#</td>
										<td>#goal.description#</td>
										<td>#goal.status#</td>
										<td>#goal.motivation#</td>
									</tr>
								</tbody>
							</table>

							<cfif !goal.notes.isEmpty()>
								<hr/>
								Notes:
								<cfloop array=#deserializeJSON(goal.notes)# item="note">

									<div class="note">
										<p>#note.noteName#</p>
										<p>#note.noteDetail#</p>
									</div>
								</cfloop>
							</cfif>
						</div>
					</ul>
				</cfloop>
		</cfif>
	</div>


</cfoutput>