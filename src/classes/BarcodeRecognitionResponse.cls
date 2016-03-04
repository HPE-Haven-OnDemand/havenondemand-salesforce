/**
 * HOD Barcode Recognition API response parser
 * https://dev.havenondemand.com/apis/recognizebarcodes#response
 */
public class BarcodeRecognitionResponse {

    public List<Barcode> barcode;
    public class BarcodeAdditionalInformation
    {
        public String country;
    }

    public class Barcode
    {
        public String text;
        public String barcode_type;
        public Integer left;
        public Integer top;
        public Integer width;
        public Integer height;
        public BarcodeAdditionalInformation additional_information;
    }
}