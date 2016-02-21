/**
 * Helper methods for HODClientTest cases 
 * 
 * @version 1.0
 * @author Topcoder
 */
 
@isTest
public class HODClientTestHelper {
    
	/**
	 * Success Mock class for API Tests
	 *  
	 */    
    public class MockIDOLSuccessResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            if (req.getEndpoint().contains(HODApp.SPEECH_RECOGNITION)) {
                // speech recognition async
                res.setBody('{"jobID":"1"}');
            }
            else if (req.getEndpoint().contains(HODApp.TEXT_EXTRACTION)) {
                // text extraction async
                res.setBody('{"jobID":"2"}');
            } 
            else if (req.getEndpoint().contains(HODApp.PREDICT)) {
                // predict async
                res.setBody('{"jobID":"3"}');
            } 
            else if (req.getEndpoint().contains(HODApp.RECOMMEND)) {
                // recommend async
                res.setBody('{"jobID":"4"}');
            } 
            else if (req.getEndpoint().contains(HODApp.TRAIN_PREDICTION)) {
                // train prediction async
                res.setBody('{"jobID":"5"}');
            }
            else if (req.getEndpoint().contains(HODApp.OCR_DOCUMENT)) { // GET Request
                // OCR_DOCUMENT async get Request
                res.setBody('{"jobID":"6"}');
            }
            else if (req.getEndpoint().contains(HODApp.INDEX_STATUS)) {
                // index status sync
                res.setBody(responseIndexStatus);
            } 
            else if (req.getEndpoint().contains(HODApp.LIST_RESOURCES)) {
                // list resources
                res.setBody(responseListResources);
            }
            else if (req.getEndpoint().contains(HODApp.LANGUAGE_IDENTIFICATION)) { // GET Request
                // Language Identification 
                res.setBody(responseLanguageIdentification);
            }
            else if (req.getEndpoint().contains(HODApp.ENTITY_EXTRACTION)) { // GET Request
                // Entity Extraction 
                res.setBody(responseEntityExtraction);
            }
            else if (req.getEndpoint().contains(HODApp.FIND_SIMILAR)) { // GET Request 
                // FindSimilar
                res.setBody(responseFindSimilar);
            }
            else if (req.getEndpoint().contains(HODClientConstants.JOB_STATUS)) {
                // call job status
                res.setBody(responseStatus);
            } 
            else if (req.getEndpoint().contains(HODClientConstants.JOB_RESULT)) {
                List<String> url = req.getEndpoint().split('\\?');
                String removeQueryParams = url.get(0);
                // call job result
                List<String> data = removeQueryParams.split('/');
                System.debug(data);
                String jobId = data.get(data.size()-1);
                res.setBody(asyncJobData.get(jobId));
            } 
            return res;
        }
    }
	
    /**
	 * Failure Mock class for API Tests
	 *  
	 */ 
    public class MockIDOLFailureResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(400);
            // for the sake of simplicity, use single failure message
            res.setBody(responseFailure);
            return res;
        }
    }
    
    //  ------- successful responses ---------------//
    public static final String responseSpeechRecognition = '{"actions":[{"result":{"document":[{"content":"I guess thatit"}]},"status":"finished","action":"recognizespeech","version":"v1"}],"jobID":"1","status":"finished"}';
    public static final String responseTextExtraction = '{"document":[{"reference":"TextExtraction.docx","doc_iod_reference":"b41d1c8ed299a9ce5f6a913817643397","app_name":["Microsoft Office Word"],"app_version":["15.0000"],"author":["Virender"],"characters_with_spaces":["1301"],"char_count":["1109"],"code_page":["65001"],"content_type":["application/x-ms-word07"],"created_date":["1453906680"],"document_attributes":["0"],"file_size":[13430],"edit_time":["0"],"hyperlinks_changed":["0"],"last_author":["Virender"],"modified_date":[1453906680],"line_count":["9"],"links_dirty":["0"],"page_count":["1"],"par_count":["2"],"rev_number":["2"],"scale_crop":["0"],"security":["0"],"shared_doc":["0"],"template":["Normal.dotm"],"word_count":["194"],"content":"this is test."}],"md5sum":["1f817dd5c24f1623ebdc95ae71f794d3"]}';
    public Static final String responseTrainPrediction = '{"service":"my-service","status":"Ready"}';
    public Static final String responseRecomendation = '{"allRecommendations":[{"originalValues":[{}],"recommendations":[{"recommendation":[{}],"distance":"1.4142135623730951","confidence":"1.0","new_prediction":"class0"},{}]}],"fields":[{}]}';
    public static final String responsePredict = '{"status":200,"file":"age,workclass,fnlwgt,education,education-num,marital-status,occupation,relationship,race,sex,capital-gain"}';
    public static final String responseStatus = '{"status":"finished"}';
    public static final String responseIndexStatus = '{"total_documents": 3,"total_index_size": 1335,"24hr_index_updates": 0,"component_count": 1}';
    public static final String responseListResources = '{"public_resources":[],"private_resources":[{"resource":"test","type":"content","flavor":"standard","description":null,"date_created":"Fri Jan 08 2016 10:32:46 GMT+0000 (UTC)","display_name":null,"resourceUUID":"7b40cca0-bca7-4976-ad5c-1c4ab5313adb"}]}';
    
    // mock response for get request
    public static final String responseOCRDocument = '{"text_block": [{ "text": "The Life and Work of Fredson Bowers. THOMAS TANSELLE Fnau Mus A Faw nGtnuss wnosza accoplishment and influence cause themcalculated to","left": 0,"top": 0,"width": 688,"height": 1096}]}';
    public static final String responseLanguageIdentification = '{"additional_metadata": {},"language": "unknown","language_iso639_2b": "UND","encoding": "UTF8","unicode_scripts": ["Basic Latin"]}';
 	public static final String responseFindSimilar = '{"documents": [{"index": "wiki_eng", "links": "(SPOR)", "reference":"List of sports attendance figures", "title": "List of sports attendance figures"}, {"index": "wiki_eng", "links": "(SPOR)","title": "Rowing (sport)", "weight": "89.15"}]}';
    public static final String responseEntityExtraction = '{"entities": [{ "normalized_text": "Syria","type": "places_eng","score": 0.8119,"additional_information": {"lon": 38,"lat": 35},"components": []},{"normalized_text": "Texas","type": "places_eng","score": 0.8022,"additional_information": {"wikidata_id": 1439,"place_country_code": "US"},"components": [],"normalized_length": 5}]}';
    
    // error response
    public static final String responseFailure = '{"error": 4004,"reason": "Invalid job action","detail": { "message": "API not found"}}';
    
    
    // job id :  response mapping
    public static Map<String, String> asyncJobData = new Map<String,String>
    {
        '1'=>responseSpeechRecognition,
        '2'=>responseTextExtraction,
        '3'=>responsePredict,
        '4'=>responseRecomendation,
        '5'=>responseTrainPrediction,
        '6'=>responseOCRDocument
     };
  	
         
    
}