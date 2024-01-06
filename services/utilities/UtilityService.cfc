component {


	property name="conversionUtils" inject="ConversionService";
	property name="dateUtils" 		inject="DateService";
	property name="emailUtils" 		inject="EmailService";
	property name="encodingUtils" 	inject="EncodingService";
	// property name="encryptionUtils"	inject="EncryptionService";
	property name="markdownUtils" 	inject="MarkdownService";
	property name="mathUtils" 		inject="MathService";
	property name="stringUtils" 	inject="StringService";
	property name="timeUtils" 		inject="TimeService";
	property name="validationUtils" inject="ValidationService";
	property name="wireboxUtils" 	inject="WireboxService";

	public WireboxService function getWireboxUtils() {
		// isNull(wireboxUtils)
		// 	throw "WireboxUtils is not injected";

		return wireboxUtils;
	}


	public ConversionService function getConversionUtils() {
		// isNull(conversionUtils)
		// 	throw "ConversionUtils is not injected";

		return conversionUtils;
	}

	public DateService function getDateUtils() {
		// isNull(dateUtils)
		// 	throw "DateUtils is not injected";

		return dateUtils;
	}

	public EmailService function getEmailUtils() {
		// isNull(emailUtils)
		// 	throw "EmailUtils is not injected";

		return emailUtils;
	}

	public EncodingService function getEncodingUtils() {
		// isNull(encodingUtils)
		// 	throw "EncodingUtils is not injected";

		return encodingUtils;
	}

	// public EncryptionService function getEncryptionUtils() {
	// 	isNull(encryptionUtils)
	// 		throw "EncryptionUtils is not injected";

	// 	return encryptionUtils;
	// }

	public MarkdownService function getMarkdownUtils() {
		// isNull(markdownUtils)
		// 	throw "MarkdownUtils is not injected";

		return markdownUtils;
	}

	public MathService function getMathUtils() {
		// isNull(mathUtils)
		// 	throw "MathUtils is not injected";

		return mathUtils;
	}

	public StringService function getStringUtils() {
		// isNull(stringUtils)
		// 	throw "StringUtils is not injected";

		return stringUtils;
	}

	public TimeService function getTimeUtils() {
		// isNull(timeUtils)
		// 	throw "TimeUtils is not injected";

		return timeUtils;
	}

	public ValidationService function getValidationUtils() {
		// isNull(validationUtils)
		// 	throw "ValidationUtils is not injected";

		return validationUtils;
	}
}