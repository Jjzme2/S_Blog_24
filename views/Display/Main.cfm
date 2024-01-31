<cfoutput>
	<div class="page-container">
		<div class="page-header">
			Here you will be able to view the (Tabs?) for:
			<ul>
				<div>
					<li>Routes</li>
					<sub>Clean this up.</sub>
				</div>

				<div>
					<li>Documentation</li>
					<sub>Add more to this</sub>
				</div>

				<div>
					<li>Template Copy function</li>
					<sub>Recent Work</sub>
				</div>

				<div>
					<li>Other Useful Links</li>
					<sub>Removed DevBook, See client.</sub>
				</div>
			</ul>
		</div>



		<div class="card-display">
			<!--- Routes --->
			<div class="card">

				<h1 class="card-title">Routes</h1>
				<p class="card-description">The following routes are available in this application.</p>

				<div class="card-body">
					<cfloop array=#prc.routes# item="route">
												<cfif
								left(route.pattern, 4) EQ "api/" ||
								left(route.pattern, 7) eq "server/"
							>
						<ul>

								<a href=#event.buildLink(route.pattern)# target="blank">#route.pattern#</a>
						</ul>
													</cfif>

					</cfloop>
				</div>
			</div>



			<!--- Documentation Links --->
			<div class="card">

				<h1 class="card-title">Documentation</h1>
				<p class="card-description">Here are some helpful resources for this application.</p>

				<div class="card-body">
					<cfloop array=#prc.docs# item="doc">
						<ul>
							<a href=#event.buildLink("server.Markdown.display.#doc.id#")# >#doc.name#</a>
						</ul>
					</cfloop>
				</div>
			</div>

			<!--- Template Copy Buttons --->
			<div class="card">

				<h1 class="card-title">Template Copy</h1>
				<p class="card-description">Here are some helpful resources for this application.</p>

				<div class="card-body">
					<cfloop array=#prc.templates# item="template">
						<ul>
							<a href=#event.buildLink("server.Template.display.#template.fileName#")# >#template.name#</a>
						</ul>
					</cfloop>
				</div>
</cfoutput>