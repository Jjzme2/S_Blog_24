/**
 * A OBJECTNAME Object
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	// CONSTANT Properties
	property name="id" 			type="string" 	primarykey="true";
	property name="createdOn" 	type="datetime";
	property name="modifiedOn"  type="datetime";
	property name="active" 		type="boolean";

	// COMMON Properties
	property name="title" 		type="string";
	property name="description" type="string";


	// Unique Properties
	property name="bodyContent" type="string";

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
		id:				{ required : true, type : "string"},
		active:			{ required : true, type : "boolean"},
		title:			{ required : true, type : "string"},
		description:	{ required : true, type : "string"},
		bodyContent:	{ required : true, type : "string"}
	};

	/**
	 * --------------------------------------------------------------------------
	 * Population
	 * --------------------------------------------------------------------------
	 */
	this.population = {
		include: [
			"id",
			"createdOn",
			"modifiedOn",
			"active",
			"title",
			"description",
			"bodyContent"
		]
	}

	/**
	 * Constructor
	 */
	function init(){
		setId(createUUID());
		setCreatedOn(Now());
		setModifiedOn(Now());
		setActive(false);
		setTitle("");
		setDescription("");
		setBodyContent("");
		return this;
	}


	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function read() {

		return {
			'id':			getId(),
			'createdOn':	getCreatedOn(),
			'modifiedOn':	getModifiedOn(),
			'active':		getActive(),
			'title':		getTitle(),
			'description':	getDescription(),
			'bodyContent':	getBodyContent()
		};
	}

	string function getCSV() {
		return getID() & "," &
			getCreatedOn() & "," &
			getModifiedOn() & "," &
			getActive() & "," &
			getTitle() & "," &
			getDescription() & "," &
			getBodyContent();
	}

	string function getJSON() {
		return serializeJSON(read());
	}

	array function getProperties() {
		return [
			'id',
			'createdOn',
			'modifiedOn',
			'active',
			'title',
			'description',
			'bodyContent'
		];
	}
}
