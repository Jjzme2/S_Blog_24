component
	name     ="BaseLog"
	hint     ="A Base log object for all messages on the Server."
	accessors="true"
{

	property name="messages" type="array";

	property name="level" type="string";

	property name="timestamp" type="string";

	property name="source" type="string";


	property name="Utils" inject="UtilityService";


	public BaseLog function init(){
		setMessages( [] );
		setLevel( "INFO" );
		setTimestamp( now().format( "mm-dd-yyyy_hh:nn:ss TT", "CST" ) );
		setSource( "" );
		setUtils(
			application.wirebox
				.getInstance( "UtilityService" )
		);
		return this;
	}

	/**
	 * -----------------------------------------
	 * MESSAGES
	 * -----------------------------------------
	 */

	/**
	 *
	 * @hint  Adds a message to the log.
	 * @param message [string] - The message to add to the log.
	 *
	 * @return boolean
	 */
	public boolean function addMessage( required string message ){
		arrayAppend( getMessages(), message );
		return true;
	}

	/**
	 *
	 * @hint  Adds multiple messages to the log.
	 * @param messages [array] - The messages to add to the log.
	 *
	 * @return boolean
	 */
	public boolean function addMessages( required array messages ){
		for ( var i = 1; i <= arrayLen( messages ); i++ ) {
			arrayAppend( getMessages(), messages[ i ] );
		}
		return true;
	}

	/**
	 *
	 * @hint Removes all messages from the log.
	 *
	 * @return boolean
	 */
	public boolean function removeMessage( required string message ){
		var messages = getMessages();
		for ( var i = 1; i <= arrayLen( messages ); i++ ) {
			if ( messages[ i ] == message ) {
				arrayDeleteAt( messages, i );
			}
		}
		setMessages( messages );
		return true;
	}

	/**
	 *
	 * @hint  Removes all specified messages from the log.
	 * @param messages [array] - The messages to remove from the log.
	 *
	 * @return boolean
	 */
	public boolean function removeMessages( required array messages ){
		var messages = getMessages();
		for ( var i = 1; i <= arrayLen( messages ); i++ ) {
			for ( var j = 1; j <= arrayLen( messages ); j++ ) {
				if ( messages[ i ] == messages[ j ] ) {
					arrayDeleteAt( messages, i );
				}
			}
		}
		setMessages( messages );
		return true;
	}

	/**
	 *
	 * @hint  Removes a message from the log at the specified index.
	 * @param index [numeric] - The index of the message to remove.
	 *
	 * @return boolean
	 */
	public boolean function removeMessageAtIndex( required numeric index ){
		var messages = getMessages();
		arrayDeleteAt( messages, index );
		setMessages( messages );
		return true;
	}

	/**
	 *
	 * @hint Removes all messages from the log.
	 *
	 * @return boolean
	 */
	public boolean function removeAllMessages(){
		setMessages( [] );
		return true;
	}

	/**
	 * -----------------------------------------
	 * READERS
	 * -----------------------------------------
	 */

	public string function readLog(){
		var logMessage = "---------------------------------------------"
		& chr( 13 ) & chr( 10 )
		& "Level: " & getLevel()
		& chr( 13 ) & chr( 10 )
		& "Source: " & getSource()
		& chr( 13 ) & chr( 10 )
		& "Timestamp: " & getTimestamp()
		& chr( 13 ) & chr( 10 )
		& "Messages: " & messagesToString()
		& chr( 13 ) & chr( 10 )
		& "---------------------------------------------";

		return logMessage;
	}

	public string function readJson(){
		var logMessage = {
			"messages"  : messagesToString(),
			"level"     : getLevel(),
			"source"    : getSource(),
			"timestamp" : getTimestamp()
		};

		return serializeJSON( logMessage );
	}

	public struct function readStruct(){
		var logMessage = {
			"messages"  : messagesToString(),
			"level"     : getLevel(),
			"source"    : getSource(),
			"timestamp" : getTimestamp()
		};

		return logMessage;
	}

	/**
	 * -----------------------------------------
	 * WRITE TO LOG FILE
	 * -----------------------------------------
	 */

	public void function writeToLogFile(
		string additionalProperties,
		string LogFilePath,
		string LogFileName
	){
		if ( !isDefined( arguments.LogFilePath ) ) {
			arguments.LogFilePath = ( "_logs/_tmpLogs/" );
		}

		if ( !isDefined( arguments.LogFileName ) ) {
			// var tempFileName = '#NOW().dateTimeFormat( 'mm-dd-yyyy_hh(TT)', 'CST' )#.text';
			var tempFileName      = "#now().dateTimeFormat( "mm-dd-yyyy", "CST" )#.log";
			arguments.LogFileName = tempFileName;
		}

		var fileExists = Utils
			.getUtils( "file" )
			.fileExists( directory = LogFilePath, fileName = LogFileName );

		if ( !fileExists ) {
			Utils
				.getUtils( "file" )
				.CreateFile(
					directory = LogFilePath,
					fileName  = LogFileName,
					content   = readLog()
				);
		} else {
			Utils
				.getUtils( "file" )
				.AppendToFile(
					directory = LogFilePath,
					fileName  = LogFileName,
					content   = readLog()
				);
		}
	}


	/**
	 * -----------------------------------------
	 * HELPERS
	 * -----------------------------------------
	 */

	private string function messagesToString(){
		var messages      = getMessages();
		var messageString = "[#chr( 10 )##chr( 13 )#";
		for ( var i = 1; i <= arrayLen( messages ); i++ ) {
			messageString &= messages[ i ];
			if ( i < arrayLen( messages ) ) {
				messageString &= ",#chr( 13 )#";
			}
		}
		messageString &= "#chr( 10 )##chr( 13 )#]";
		return messageString;
	}

}
