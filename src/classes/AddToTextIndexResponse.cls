/**
 * HOD Add to Text Index API response parser
 * https://dev.havenondemand.com/apis/addtotextindex#response
 */
public class AddToTextIndexResponse {
    public String index; //(string )  The text index that the file was indexed to.
    public List<References> references; // ( array[References] )  Files indexed

    public class References
    {
        public integer id;
        public String reference; //(string , optional)  File reference.
    }
}