/**
 * HOD Text Tokenization API response parser
 * https://dev.havenondemand.com/apis/tokenizetext#response
 */
public class TextTokenizationResponse {
    public List<Terms> terms; //(array[Terms] )  The details of the tokenized terms.

    public class Terms
    {
        //public double case; //( enum<Case> , optional)  A value between indicating the term's case.
        public integer documents; //(number )  The number of documents that the specified term occurs in.  
        //public double length; //(number , optional)  The length of the term in characters.
        //public int numeric; //( enum<Numeric> , optional)  A value indicating whether the term contains numbers.
        public integer occurrences; //(number )  The number of times the specified term occurs.
        //public double start_pos; //(number , optional)  The position in characters of the start of the word in the original text.
        //public double stop_word; //( string , optional)  This tag appears only if the term is a stop word.
        public String term; //( string )  The term whose information is displayed.
        public double weight; //( number )  The weight of the specified term.
    }
}