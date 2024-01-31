<cfoutput>
	<div class="page-container">
		<div class="page-header" style="padding: 5rem;">
			<div id="prc" class="card" style="margin:auto;">#prc.content#</div>
		</div>

		<div>
			<button onClick="copyToClipboard(document.getElementById('prc').innerHTML)">Copy to Clipboard</button>
		</div>

		<script>
			function copyToClipboard(text) {
				window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
			}
		</script>
</cfoutput>