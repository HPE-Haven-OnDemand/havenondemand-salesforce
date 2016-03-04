/**
 * HOD Get Nodes API response parser
 * https://dev.havenondemand.com/apis/getnodes#response
 */
public class GetNodesResponse {
    public List<Nodes> nodes;
    public class Nodes
    {
        public Attributes attributes;
        public integer id;
        public integer sort_value;
    }
    public class Attributes
    {
        public String name;
    }
}