component {

	property name="cbMarkdown" inject="Processor@cbmarkdown";

	function getDocs(){
		// Include all docs here.
		return [
			{
				id          : "doc_Creating_A_Gateway",
				name        : "Creating a Gateway File",
				asHtml      : cbMarkdown.toHtml( fileRead( expandPath( "/assets/docs/Creating_A_Gateway.md" ) ) ),
				asMd        : fileRead( expandPath( "/assets/docs/Creating_A_Gateway.md" ) ),
				link        : "/assets/docs/Creating_A_Gateway.md",
				created_on  : "2024-01-16",
				modified_on : "2024-01-18"
			},
			{
				id          : "doc_Adding_New_Documentation",
				name        : "Adding New Documentation",
				asHtml      : cbMarkdown.toHtml( fileRead( expandPath( "/assets/docs/Adding_New_Documentation.md" ) ) ),
				asMd        : fileRead( expandPath( "/assets/docs/Adding_New_Documentation.md" ) ),
				link        : "/assets/docs/Adding_New_Documentation.md",
				created_on  : "2024-01-18",
				modified_on : "2024-01-18"
			},
			{
				id          : "doc_Task_List",
				name        : "Task List",
				asHtml      : cbMarkdown.toHtml( fileRead( expandPath( "/assets/docs/Task_List.md" ) ) ),
				asMd        : fileRead( expandPath( "/assets/docs/Task_List.md" ) ),
				link        : "/assets/docs/Task_List.md",
				created_on  : "2024-01-18",
				modified_on : "2024-01-18"
			},
			{
				id          : "doc_Reminder_List",
				name        : "Reminder List",
				asHtml      : cbMarkdown.toHtml( fileRead( expandPath( "/assets/docs/Reminder_List.md" ) ) ),
				asMd        : fileRead( expandPath( "/assets/docs/Reminder_List.md" ) ),
				link        : "/assets/docs/Reminder_List.md",
				created_on  : "2024-01-30",
				modified_on : "2024-01-30"
			}
		];
	}

	function find( required string id ){
		var docs = getDocs();
		for ( var doc in docs ) {
			if ( doc.id == id ) {
				return doc;
			}
		}
		return false;
	}

}
