/**
 * HOD Concept Extraction API response parser
 * https://dev.havenondemand.com/apis/extractconcepts#response
 */
public class ConceptExtractionResponse {
    public List<Concepts> concepts; // (array[Concepts] )  A result concept identified in the results set.

    public class Concepts
    {
        public String concept; //(string)  The text of the identified concept.
        public integer occurrences; // (number)  The total number of occurrences of this element in the results set.
    }
}