/**
 * HOD Image Recognition API response parser
 * https://dev.havenondemand.com/apis/recognizeimages#response
 */
public class ImageRecognitionResponse {

    public List<HODObject> objects; // (array[Object]) Details of a recognized object in the image.
    public integer page_count; // The total number of pages in the document.

    public class HODObject {
        public String unique_name; // (string) The unique name of the object recognized from the database.
        public String name; // (string) The descriptive name of the recognized object.
        public String db; // (enum<Db>) The name of the recognition database that the recognized object is stored in.
        public List<Corners> corners; // (array[Corners]) The positions of the corners of a quadrilateral bounding box containing the recognized object.
        public integer page_num; // The page in the document that the object belongs to.
    }

    public class Corners {
        public Integer x; // (integer) The horizontal position of the corner of the bounding box.
        public Integer y; // (integer) The vertical position of the corner of the bounding box.
    }

}