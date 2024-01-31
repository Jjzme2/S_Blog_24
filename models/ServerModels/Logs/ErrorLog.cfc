component
	name     ="ErrorLog"
	hint     ="An Error log object for all messages on the Server."
	accessors="true"
	extends  ="BaseLog"
{

	property name="error" type="any";

	public ErrorLog function init( source, error ){
		super.init();
		setSource( arguments.source );
		setError( arguments.error );
		setLevel( "Error" );
		return this;
	}

	public void function dumpError( doAbort = true ){
		writeDump(
			var   = getError(),
			label = "ErrorLog Dump",
			abort = doAbort
		)
	}

}
