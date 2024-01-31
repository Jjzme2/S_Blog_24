<cfoutput>
	<nav class="navbar">
		<cfinclude template="./meta/NavBarIncludes.cfm">

		<div class="container-fluid">

			<cfif includeNavbarText>
				<a class="navbar-brand" href="#event.buildLink(mainLink)#">
					<cfif brandName neq "">
						<strong>#brandName#</strong>
					<cfelseif navBarMessage neq "">
						<strong>#navBarMessage#</strong>
					<cfelse>
						<strong>Home</strong>
					</cfif>
				</a>
			</cfif>

			<a class="navbar-brand" href="#event.buildLink("server.tests.output")#" target="blank">
				<strong class="shadow-text">Tests</strong>
			</a>

			<cfif displayServerAdminLink>
				<a class="navbar-brand" href="#serverAdminLink#" target="blank">
					<strong class="shadow-text">Server Admin</strong>
				</a>
			</cfif>

			<cfif routeToClientPortal>
				<a class="navbar-brand" href="#clientPortal#" target="blank">
					<strong class="shadow-text">#clientName#</strong>
				</a>
			</cfif>

			<!---
			<cfif includeMobileToggler>
				<button
					class="navbar-toggler"
					type="button"
					data-bs-toggle="collapse"
					data-bs-target="##navbarSupportedContent"
					aria-controls="navbarSupportedContent"
					aria-expanded="false"
					aria-label="Toggle navigation"
				>
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
			</cfif>
			--->
			</div>
		</div>
	</nav>
</cfoutput>
