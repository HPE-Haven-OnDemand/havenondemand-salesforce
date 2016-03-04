/**
 * HOD Text Extraction API response parser
 * https://dev.havenondemand.com/apis/extracttext#response
 */
public class TextExtractionResponse {
    public List<HODObject> document; // (array[object])

    public class HODObject {
        public String name;
        public String reference;
        public String parent_iod_reference;
        public String doc_iod_reference;
        public List<String> content_type;
        public List<String> document_attributes;
        public List<String> keyview_class;
        public List<Integer> original_size;
        public List<Integer> keyview_type;
        public List<String> import_original_encoding;
        public String content;
        public Error error;
        public List<String> app_name;
        public List<String> author;
        public List<Integer> char_count;
        public List<Integer> code_page;
        public List<String> company;
        public List<Double> created_date;
        public List<String> edit_time;
        public List<String> heading_pairs;
        public List<String> last_author;
        public List<String> last_printed;
        public List<Integer> modified_date;
    }
    public class Error {
        public Integer error;
        public String reason;
    }
}