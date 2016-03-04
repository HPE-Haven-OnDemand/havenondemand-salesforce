/**
 * HOD Connector History API response parser
 * https://dev.havenondemand.com/apis/connectorhistory#response
 */
public class ConnectorHistoryResponse {
    public List<History> history;
    public class History
    {
        public String connector;
        public Document_counts document_counts;
        public String error;
        public String failed;
        public String process_end_time; // Format: DD/MM/YYYY HH:mm:ss Z.
        public String process_start_time; // Format: DD/MM/YYYY HH:mm:ss Z.  
        public String start_time; // Format: DD/MM/YYYY HH:mm:ss Z.
        public String queued_time; // Format: DD/MM/YYYY HH:mm:ss Z.
        public String status; // 
        public double time_in_queue; // 
        public double time_processing; // 
        public String token; // 
    }
    public class Document_counts
    {
        public integer added;
        public integer deleted;
        public integer errors;
        public integer ingest_added;
        public integer ingest_deleted;
        public integer ingest_failed;
    }
    
}