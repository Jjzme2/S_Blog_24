/**
 * A Task Object
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
	property name="name"        type="string";
	property name="description" type="string";

	// UNIQUE Properties
	property name="isComplete"  type="boolean";
	property name="followUpNotes" type="string";
	property name="goalId"      type="string";
	property name="assignedTo"  type="string";


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
		id          : { required : true, type : "string" },
		active      : { required : true, type : "boolean" },
		name        : { required : true, type : "string" },
		description : { required : true, type : "string" },
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
			"name",
			"description",
			"isComplete",
			"followUpNotes",
			"goalId",
			"assignedTo"
		]
	}

	/**
	 * Constructor
	 */
	function init(){
		setId( createUUID() );
		setCreatedOn( now() );
		setModifiedOn( now() );
		setActive( false );
		setName( "" );
		setDescription( "" );
		setIsComplete( false );
		setFollowUpNotes( "" );
		setGoalId( "" );
		setAssignedTo( "" );
		return this;
	}


	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function read(){
		return {
			"id"            : getId(),
			"createdOn"     : getCreatedOn(),
			"modifiedOn"    : getModifiedOn(),
			"active"        : getActive(),
			"name"          : getName(),
			"description"   : getDescription(),
			"isComplete"    : getIsComplete(),
			"followUpNotes" : getFollowUpArray(),
			"goalId"        : getGoalId(),
			"assignedTo"    : getAssignedTo()
		};
	}

	string function getCSV(){
		return getID() & "," &
		getCreatedOn() & "," &
		getModifiedOn() & "," &
		getActive() & "," &
		getName() & "," &
		getDescription() & "," &
		getIsComplete() & "," &
		getFollowUpArray() & "," &
		getGoalId() & "," &
		getAssignedTo();
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
			"name",
			"description",
			"isComplete",
			"followUpNotes",
			"goalId",
			"assignedTo"
		];
	}

	array function getFollowUpArray(){
		var followUpArray = [];
		var followUpNotes = getFollowUpNotes();
		if( followUpNotes != "" ){
			followUpArray = deserializeJSON( followUpNotes );
		}
		return followUpArray;
	}

}
