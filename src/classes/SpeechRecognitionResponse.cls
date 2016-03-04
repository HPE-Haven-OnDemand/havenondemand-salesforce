/**
 * HOD Speech Recognition API response parser
 * https://dev.havenondemand.com/apis/recognizespeech#response
 */
public class SpeechRecognitionResponse {
    public List<Document> document; // (array[Document]) The speech block transformed to text.
    public class Document {
        public Integer offset; // (integer, optional) The offset of the first word in this content section.
        public String content; // (string) The extracted block of text from speech.
        public Integer confidence;
        public Integer duration;
    }
}