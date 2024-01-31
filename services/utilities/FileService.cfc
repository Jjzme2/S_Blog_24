component {

	/**
	 * --------------------------------------------------------
	 * FILE FUNCTIONS
	 * --------------------------------------------------------
	 */

	/**
	 * Creates a file
	 *
	 * @param directory
	 * @param fileName
	 * @param content
	 *
	 * @return boolean
	 */
	public function CreateFile(
		required directory,
		required fileName,
		required content
	){
		var directory = expandPath( directory );
		var file      = directory & fileName;
		content       = trim( content );

		if ( directoryExists( directory ) == false ) {
			// throw "Directory does not exist, please use CreateDirectory() instead.";
			directoryCreate( directory );
		}

		if ( fileExists( file ) ) {
			throw "File already exists, please use AppendToFile() instead.";
		}

		// ? I think this is solved. Check it out.
		var newFile = fileWrite( file, content );
		return true;
	}

	/**
	 * Appends to a file
	 *
	 * @param directory
	 * @param fileName
	 * @param content
	 * @param newLine
	 *
	 * @return boolean
	 */
	public boolean function AppendToFile(
		required directory,
		required fileName,
		required content,
		newLine = false
	){
		var directory = expandPath( directory );
		var filePath  = directory & fileName;

		if ( !fileExists( filePath ) ) {
			throw "File does not exist, please use CreateFile() instead.";
		}

		if ( newLine ) {
			var content = content & chr( 13 ) & chr( 10 );
		} else {
			if ( right( content, 1 ) != " " ) {
				var content = content & " ";
			}
		}

		fileAppend( file = filePath, data = content );
		return true;
	}

	/**
	 * Reads a file
	 *
	 * @param directory
	 * @param fileName
	 *
	 * @return string
	 */
	public string function ReadFile( required directory, required fileName ){
		var directory = expandPath( directory );
		var file      = directory & fileName;

		if ( !fileExists( file ) ) {
			throw "File does not exist.";
		}

		var content = fileRead( file );
		return content;
	}

	/**
	 * Deletes a file
	 *
	 * @param directory
	 * @param fileName
	 *
	 * @return boolean
	 */
	public function DeleteFile( required directory, required fileName ){
		var directory = expandPath( directory );
		var file      = directory & fileName;

		if ( !fileExists( file ) ) {
			throw "File does not exist.";
		}

		fileDelete( file );
		return true;
	}

	/**
	 * Checks if a file exists
	 *
	 * @param directory
	 * @param fileName
	 *
	 * @return boolean
	 */
	public boolean function FileExists( required directory, required fileName ){
		var directory = expandPath( directory );
		var file      = directory & fileName;
		return fileExists( file );
	}



	/**
	 * --------------------------------------------------------
	 * DIRECTORY FUNCTIONS
	 * --------------------------------------------------------
	 */

	/**
	 * Checks if a directory exists
	 *
	 * @param directory
	 *
	 * @return boolean
	 */
	public boolean function DirectoryExists( required directory ){
		var directory = expandPath( directory );
		return directoryExists( directory );
	}

	/**
	 * Creates a directory
	 *
	 * @param directory
	 *
	 * @return
	 */
	public function CreateDirectory( required directory ){
		var directory = expandPath( directory );
		try {
			directoryCreate( directory );
			return true;
		} catch ( any e ) {
			return false;
		}
	}


	/**
	 * Returns the number of files in a directory
	 *
	 * @param directory
	 *
	 * @return
	 */
	public function getFileCountInDirectory( required directory ){
		var files = getFilesInDirectory( directory );
		return arrayLen( files );
	}

	/**
	 * Returns a list of files in a directory
	 *
	 * @param directory
	 * @param includeFileType
	 * @param includeDirectory
	 *
	 * @return
	 */
	public function getFilesInDirectory(
		required directory,
		includeFileType  = false,
		includeDirectory = false
	){
		var files     = [];
		var directory = expandPath( directory );
		var dir       = directoryList( directory );
		for ( var i = 1; i <= arrayLen( dir ); i++ ) {
			var file = dir[ i ];
			arrayAppend( files, file );
		}

		// Remove the directory name from the file list, and any text before the directory name
		for ( var i = 1; i <= arrayLen( files ); i++ ) {
			var file = files[ i ];
			var file = replace( file, directory, "" );
			var file = replace( file, "\\", "/" );

			if ( includeDirectory ) {
				var file = directory & file;
			}

			if ( !includeFileType ) {
				var file = replace( file, "." & listLast( file, "." ), "" );
			}
			files[ i ] = file;
		}

		return files;
	}

}
