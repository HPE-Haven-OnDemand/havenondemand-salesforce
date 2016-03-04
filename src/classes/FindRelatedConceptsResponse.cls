/**
 * HOD Find Related Concepts API response parser
 * https://dev.havenondemand.com/apis/findrelatedconcepts#response
 */
public class FindRelatedConceptsResponse {
    public List<Entities> entities; //(array[Entities] )  A result term or phrase identified in the results set.

    public class Entities
    {
        public integer cluster; //(number )  The cluster into which the phrase has been grouped.This value allows you to cluster the elements according to their occurrence.
        public integer docs_with_all_terms; //(number )  The number of documents of the results set in which all terms of this element appear.
        public integer docs_with_phrase; //( number )  The number of documents in the result set in which this element appears as a phrase.
        public integer occurrences; //(number)  The total number of occurrences of this element in the results set.
        public String text; //(string)  The text of the identified term or phrase.
    }
}