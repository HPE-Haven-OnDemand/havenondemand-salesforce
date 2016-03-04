/**
 * HOD Get Shortest Path API response parser
 * https://dev.havenondemand.com/apis/getshortestpath#response
 */
public class GetShortestPathResponse {
    public List<Edges> edges;
    public List<Nodes> nodes;

    public class Edges
    {
        public Attributes attributes;
        public integer length; //(number )  Length/weight/cost of edge.
        public integer source; //( integer )  Source node ID.
        public integer target; //( integer )  Target node ID.
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