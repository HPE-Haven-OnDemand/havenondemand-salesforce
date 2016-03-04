/**
 * HOD Update Classification API response parser
 * https://dev.havenondemand.com/apis/updateclassificationobjects#response
 */
public class UpdateClassificationResponse {
	public integer id; 		// ( number )	The ID of the classification object.
	public string name;		// ( string )	The name of the classification object.
	public string type;		// ( enum<Type> )	The type of the classification object.
}