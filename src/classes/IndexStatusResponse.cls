/**
 * HOD Index Status API response parser
 * https://dev.havenondemand.com/apis/indexstatus#response
 */
public class IndexStatusResponse {
    //public integer 24hr_index_updates; // ( number )  The total number of document updates in the last 24 hours.
    public integer component_count; //( number )  The total number of index components contained in the text index (Haven OnDemand creates additional components when a text index grows larger than the component quota size for the flavor).
    public integer total_documents; //( number )  The total number of documents in the index.
    public integer total_index_size; //( number )  The total size of the index in bytes.
}