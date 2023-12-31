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
	property name="amount";
	property name="categoryId";
	property name="description";
	property name="postedDate";
	property name="note";

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
		id:						{ required : true,  type : "string"},
		amount:					{ required : true,  type : "numeric"},
		categoryId:				{ required : true,  type : "string"},
		description:			{ required : false, type : "string"},
		postedDate:				{ required : true,  type : "date"},
		note:					{ required : false, type : "string"}
	};

	/**
	 * Constructor
	 */
	function init(){
		setId(createUUID());
		setAmount(0);
		setCategoryId("");
		setDescription("");
		setPostedDate(Now());
		setNote("");
		return this;
	}

	function isValid() {
		return validate(this);
	}

}
