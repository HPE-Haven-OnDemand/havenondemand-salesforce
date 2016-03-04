/**
 * HOD Get Subgraph API response parser
 * https://dev.havenondemand.com/apis/getsubgraph#response
 */
public class GetSubgraphResponse {
    public List<Edges> edges;
    public List<Nodes> nodes;

    public class Edges
    {
        public Attributes attributes;
        public integer source;
        public integer target;
    }

    public class Attributes
    {
        public double weight;
    }

    public class Nodes
    {
        public Attributes attributes;
        public integer id;
    }

}