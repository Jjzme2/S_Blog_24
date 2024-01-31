component {

	private function getErrorLog(){
		return new models.ServerModels.Logs.ErrorLog();
	}

	public function dumpErrorLog( error, message, source, abort = true ){
		var errorLog = getErrorLog().init(
			error   = arguments.error,
			message = arguments.message,
			source  = arguments.source
		);

		errorLog.dump( arguments.abort )
	}

	public function writeErrorLog( messages, source ){
		var errorLog = getErrorLog().init( message = arguments.message, source = arguments.source );

		try {
			errorLog.writeToLogFile(
				LogObject   = errorLog,
				logFilePath = "/_server_logs",
				logFileName = "/test.log"
			);
		} catch ( any e ) {
			writeDump( var = e, abort = true );
		}
	}

}
