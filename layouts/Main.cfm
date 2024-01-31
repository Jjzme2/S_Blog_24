<cfoutput>
<!doctype html>
	<html lang="en">
		<cfinclude template="./DocHead.cfm">

		<body>
			<!---NavBar --->
			<header>
				<cfinclude template="./Navbar.cfm">
			</header>

			<!---Container And Views --->
			<main class="flex-shrink-0">
				<!--- Show messages in messagebox --->
				#getInstance( "messagebox@cbMessageBox" ).renderit()#
				#renderView()#
			</main>

			<!--- Footer --->
				<cfinclude template="./Footer.cfm">

			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> <!--- jQuery --->
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
			<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

			<!--- DataTables --->
			<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

			<!--- Personal JS --->
		</body>
	</html>
</cfoutput>
