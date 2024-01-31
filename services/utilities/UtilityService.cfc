component accessors="true" {

	property name="conversionUtils" inject="ConversionService";
	property name="dateTimeUtils"   inject="DateTimeService";
	property name="docUtils"        inject="DocService";
	property name="emailUtils"      inject="EmailService";
	property name="encodingUtils"   inject="EncodingService";
	// property name="encryptionUtils"	inject="EncryptionService";
	property name="fileUtils"       inject="FileService";
	property name="logUtils"        inject="LogService";
	property name="markdownUtils"   inject="MarkdownService";
	property name="mathUtils"       inject="MathService";
	property name="stringUtils"     inject="StringService";
	property name="validationUtils" inject="ValidationService";
	property name="wireboxUtils"    inject="WireboxService";


	/**
	 * -----------------------------------------------------------------------------------------------
	 * HELPER METHODS
	 * -----------------------------------------------------------------------------------------------
	 */
	public any function getUtils( required string name ){
		var utilNames = [
			"conversion",
			"dateTime",
			"doc",
			"email",
			"encoding",
			// ,"encryption"
			"file",
			"log",
			"markdown",
			"math",
			"string",
			"validation",
			"wirebox"
		];


		if ( !arrayContains( utilNames, lCase( arguments.name ) ) ) {
			throw "Utils not found: " & arguments.name & ". Available utils: " & arrayToList( utilNames );
		}

		var methodName = "get" & arguments.name & "Utils";
		if ( !isNull( this[ methodName ] ) ) {
			return this[ methodName ]( );
		}
	}

}
