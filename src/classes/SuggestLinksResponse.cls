/**
 * HOD Suggest Links API response parser
 * https://dev.havenondemand.com/apis/suggestlinks#response
 */
public class SuggestLinksResponse {
    public List<Suggestions> suggestions;

    public class Suggestions
    {
        public Source source;
        public List<Nodes> nodes;
    }

    public class Source
    {
        public integer id;
        public Attributes attributes;
    }

    public class Attributes
    {
        public String name;
    }

    public class Nodes
    {
        public Attributes attributes;
        public integer id;
        public integer sort_value;
    }
}