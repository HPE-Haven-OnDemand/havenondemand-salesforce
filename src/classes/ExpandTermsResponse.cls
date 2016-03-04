/**
 * HOD Expand Terms API response parser
 * https://dev.havenondemand.com/apis/expandterms#response
 */
public class ExpandTermsResponse {
    public List<Terms> terms; // ( array[Terms] )  The details of the expanded terms.

    public class Terms
    {
        public integer documents; //(integer , optional)  The number of documents that the expanded term occurs in.
        public String term; //(string )  The expanded term.
    }
}