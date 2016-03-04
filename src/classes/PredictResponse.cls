/**
 * HOD Predict API response parser
 * https://dev.havenondemand.com/apis/predict#response
 */
public class PredictResponse {
    public List<Fields> fields; // (array[Fields] )  Metadata definition of the data set, describing the structure of the dataset fields.
    public List<Values> values; // (array[Values] )  The data set values.

    public class Fields
    {
        public String name; // (String )  The name of the field.
        public integer order; //  ( integer )  The order of the field.
        public String type; //  ( String )  The type of the field.
    }

    public class Values
    {
        public List<String> row; // (array[String] , optional)  An array of values.Ordered in correlation to the list of Fields Metadata.
    }
}