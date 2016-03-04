/**
 * HOD Delete Text Index API response parser
 * https://dev.havenondemand.com/apis/deletetextindex#response
 */
public class DeleteTextIndexResponse {
    public String confirm; //(string , optional)  The confirmation hash required for deletion.
    public Boolean deleted; //( boolean )  Whether or not the index was deleted.
    public String index; //( string , optional)  Index name
}