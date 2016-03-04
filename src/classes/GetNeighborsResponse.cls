/**
 * HOD Get Neighbors API response parser
 * https://dev.havenondemand.com/apis/getneighbors#response
 */
public class GetNeighborsResponse {
    public List<Neighbors> neighbors;

    public class Neighbors
    {
        public Target target;
        public Source source;
        public List<Nodes> nodes;
    }

    public class Nodes
    {
        public Attributes attributes;
        public integer id;
        public double sort_value;
    }
    public class Attributes
    {
        public String name;
    }
    public class Target
    {
        public integer id;
        public Attributes attributes;
    }
    public class Source
    {
        public integer id;
        public Attributes attributes;
    }
}