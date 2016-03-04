/**
 * HOD Expand Container API response parser
 * https://dev.havenondemand.com/apis/expandcontainer#response
 */
public class ExpandContainerResponse {
    public List<Files> files; //A list of files and object store references.

    public class Files
    {
        public String name; // The name of the extracted file.
        public String reference;
    }
}