<cfoutput>
<!--- reader.cfm --->

<cfswitch expression="#targetElement#">
    <!--- Display an HTML element --->
    <cfcase value="element">
        <h3>HTML Element:</h3>
        <cfoutput>#targetElement#</cfoutput>
    </cfcase>

    <!--- Display a file
    <cfcase value="file">
        <h3>File Content:</h3>
        <cftry>
            <cffile action="read" file="#target#" variable="fileContent">
            <cfoutput>#fileContent#</cfoutput>
            <cfcatch type="any">
                <p>Error reading the file: #cfcatch.message#</p>
            </cfcatch>
        </cftry>
    </cfcase>

	--->

    <!--- Handle unsupported types --->
    <cfdefaultcase>
        <p>For target: #targetElement#</p>
        <!--- <p>Unsupported object type: #fileType#</p> --->
    </cfdefaultcase>
</cfswitch>

</cfoutput>