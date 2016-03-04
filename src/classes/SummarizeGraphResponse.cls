/**
 * HOD Summarize Graph API response parser
 * https://dev.havenondemand.com/apis/summarizegraph#response
 */
public class SummarizeGraphResponse {
    public List<Attributes> attributes;
    public integer edges;
    public integer nodes;

    public class Attributes
    {
        public String data_type;
        public String element_type;
        public String name;
        public integer ele_number;
    }
}