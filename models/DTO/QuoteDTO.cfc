/**
 * A Quote Object
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	// CONSTANT Properties
	property
		name      ="id"
		type      ="string"
		primarykey="true";
	property name="createdOn"  type="datetime";
	property name="modifiedOn" type="datetime";
	property name="active"     type="boolean";

	// COMMON Properties
	property name="tags"   type="string";
	property name="author" type="string";
	property name="quote"  type="string";
	property name="source" type="string";

	/**
	 * --------------------------------------------------------------------------
	 * Mementifier
	 * --------------------------------------------------------------------------
	 */
	this.memento = {
		defaultIncludes : [ "*" ],
		defaultExcludes : [ "" ],
		neverInclude    : []
	};

	/**
	 * --------------------------------------------------------------------------
	 * Validation
	 * --------------------------------------------------------------------------
	 */
	this.constraints = {
		id     : { required : true, type : "string" },
		active : { required : true, type : "boolean" },
		tags   : { required : true, type : "string" },
		author : { required : true, type : "string" },
		quote  : { required : true, type : "string" }
	};

	/**
	 * --------------------------------------------------------------------------
	 * Population
	 * --------------------------------------------------------------------------
	 */
	this.population = {
		include : [
			"id",
			"createdOn",
			"modifiedOn",
			"active",
			"tags",
			"author",
			"quote",
			"source"
		]
	}

	/**
	 * Constructor
	 */
	function init(){
		setId( createUUID() );
		// var utils = application.wirebox.getInstance( "UtilityService" );
		setCreatedOn( now() );
		// setCreatedOn( utils.getDateTimeUtils().getNow('yyyy-mm-dd hh:mm:ss') );
		setModifiedOn( now() );
		// setModifiedOn( utils.getDateTimeUtils().getNow('yyyy-mm-dd hh:mm:ss') );
		setActive( false );
		setTags( "" );
		setAuthor( "" );
		setQuote( "" );
		setSource( "Unavailable" );
		return this;
	}


	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function read(){
		return {
			"id"         : getId(),
			"createdOn"  : getCreatedOn(),
			"modifiedOn" : getModifiedOn(),
			"active"     : getActive(),
			"tags"       : getTags(),
			"author"     : getAuthor(),
			"quote"      : getQuote(),
			"source"     : getSource()
		};
	}

	string function getCSV(){
		return getID() & "," &
		getCreatedOn() & "," &
		getModifiedOn() & "," &
		getActive() & "," &
		getTags() & "," &
		getAuthor() & "," &
		getQuote() & "," &
		getSource();
	}

	string function getJSON(){
		return serializeJSON( read() );
	}

	array function getProperties(){
		return [
			"id",
			"createdOn",
			"modifiedOn",
			"active",
			"tags",
			"author",
			"quote",
			"source"
		];
	}

}
