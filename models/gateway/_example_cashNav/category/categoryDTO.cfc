/**
 * A Game model Object used to pass around information
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	property name="id";
	property name="name";
	property name="description";
	property name="isRecurring";
	property name="frequency_id";
	property name="categoryType_id";

	/**
	 * --------------------------------------------------------------------------
	 * Mementifier
	 * --------------------------------------------------------------------------
	 */
	this.memento = {
		defaultIncludes : [ "*" ],
		defaultExcludes : [],
		neverInclude    : []
	};

	/**
	 * --------------------------------------------------------------------------
	 * Validation
	 * --------------------------------------------------------------------------
	 */
	this.constraints = {
		id              : { required : true, type : "string" },
		name            : { required : true, type : "string" },
		description     : { required : true, type : "string" },
		isRecurring     : { required : true, type : "boolean" },
		frequency_id    : { required : true, type : "string" },
		categoryType_id : { required : true, type : "string" }
	};

	/**
	 * Constructor
	 */
	function init(){
		setId( createUUID() );
		setName( "" );
		setDescription( "" );
		setIsRecurring( false );
		setFrequency_id( "" );
		setCategoryType_id( "" );
		return this;
	}

}
