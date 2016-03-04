/**
 * HOD Get Common Neighbors API response parser
 * https://dev.havenondemand.com/apis/getcommonneighbors#response
 */
public class GetCommonNeighborsResponse {
    public List<Nodes> nodes;
    public class Nodes
    {
        public Attributes attributes;
        public integer id;
        public integer commonality;
        public integer sort_value;
    }
    public class Attributes
    {
        public String name;
    }
}