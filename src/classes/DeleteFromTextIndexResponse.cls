/**
 * HOD Delete from Text Index API response parser
 * https://dev.havenondemand.com/apis/deletefromtextindex#response
 */
public class DeleteFromTextIndexResponse {
    public integer documents_deleted; // ( integer )  The number of deleted documents.
    public String index; // ( string )  The index the document was deleted from.
}