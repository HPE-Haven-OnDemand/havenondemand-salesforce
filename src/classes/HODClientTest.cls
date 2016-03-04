/**
 * Test HODClient class
 * 
 * @author Topcoder
 * @version 1.0
 */
@isTest
public class HODClientTest {

    /**
     * Get API Key for the tests
     */
    private static String getAPIKeyForTest()
    {
        return '4c21b279-8916-495b-9166-74876394bcdb';
    }
    
    /**
     * Get API version for the tests
     */
    private static String getAPIVersion()
    {
        return 'v2';
    }
    
    /**
     *  ASync success test speech recognition
     */
    @isTest
    private static void testSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>(); 
        params.add(new Param('url','https://test.com'));
        Map<String,Object> data = client.postRequest(params, HODAPP.SPEECH_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }
    
    
    /**
     *  ASync success test extraction
     */
    @isTest
    private static void testTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();  
        params.add(new Param('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        Map<String,Object> data= client.postRequest(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '2');
        Test.stopTest();
    }
    
    /**
     *  ASync success test prediction api
     */
    @isTest
    private static void testPredictAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();  
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        Map<String,Object> data = client.postRequest(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '3');
        Test.stopTest();
    }
    
    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testRecommendAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>(); 
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        params.add(new Param('required_label','test'));
        Map<String,Object> data= client.postRequest(params, HODAPP.RECOMMEND, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '4');
        Test.stopTest();
    }
    
    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testTrainPredictionAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>(); 
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        Map<String,Object> data= client.postRequest(params, HODAPP.TRAIN_PREDICTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '5');
        Test.stopTest();
    }
    
    /**
     *  Sync success index status
     */
    @isTest
    private static void testIndexStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
		List<Param> params = new List<Param>(); 
		// add parameters to be passed
        params.add(new Param('index','test'));
        // get response, it is json response
        Map<String,Object> data = client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('total_documents') == 3);
        Test.stopTest();
    }
    
    /**
     *  Sync success index status - POST Request with HODResponseParser
     */
    @isTest
    private static void testIndexStatusWithParser() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
		List<Param> params = new List<Param>(); 
		// add parameters to be passed
        params.add(new Param('index','test'));
        // get response, it is json response
        Map<String,Object> data = client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        // Parsing HOD Response
        IndexStatusResponse resObj = (IndexStatusResponse)HODResponseParser.parseCustomResponse(data, IndexStatusResponse.class);
        System.assertEquals(3, resObj.total_documents);
        Test.stopTest();
    }
    
    /**
     *  Sync success list resouces
     */
    @isTest
    private static void testListResources() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('flavor',new List<String>{'standard','explorer'}));
        params.add(new Param('type',new List<String>{'content','connector'}));
        // get response
        Map<String,Object> data = client.postRequest(params, HODAPP.LIST_RESOURCES, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.containsKey('private_resources'));
        Test.stopTest();
    }
    
    /**
     *  ASync success test get OCR Document api
     */
    @isTest
    private static void testOCRDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();  
        params.add(new Param('url', 'https://www.havenondemand.com/sample-content/images/bowers.jpg'));
        params.add(new Param('mode', 'document_photo'));
            
        Map<String,Object> data = client.getRequest(params, HODAPP.OCR_DOCUMENT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '6');
        Test.stopTest();
    }
    
    /**
     *  Sync success Language Identification - GET Request
     */
    @isTest
    private static void testLanguageIdentification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('text', 'testing'));
        // get response
        Map<String,Object> data = client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assertEquals('unknown', data.get('language'));
        Test.stopTest();
    }
    
    /**
     *  Sync success Language Identification - GET Request with HODResponseParser
     */
    @isTest
    private static void testLanguageIdentificationWithParser() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('text', 'testing'));
        // get response
        Map<String,Object> data = client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.SYNC);
        // Parsing HOD Response
        LanguageIdentificationResponse resObj = (LanguageIdentificationResponse)HODResponseParser.parseCustomResponse(data, LanguageIdentificationResponse.class);
        System.assertEquals('unknown', resObj.language);
        Test.stopTest();
    }
    
    /**
     *  Sync success Find Similar - GET Request
     */
    @isTest
    private static void testFindSimilar() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('text', 'Sports'));
        params.add(new Param('highlight', 'sentences'));
        // get response
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.containsKey('documents'));
        
        // Checking the response value
        Map<String,Object> objValueMap = (Map<String,Object>)((List<Object>)data.get('documents'))[0];
        System.assertEquals('wiki_eng', objValueMap.get('index'));
        Test.stopTest();
    }
    
    /**
     *  Sync success Find Similar - GET Request with HODResponseParser
     */
    @isTest
    private static void testFindSimilarWithParser() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('text', 'Sports'));
        params.add(new Param('highlight', 'sentences'));
        // get response
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
        // Parsing HOD Response
        FindSimilarResponse resObj = (FindSimilarResponse)HODResponseParser.parseCustomResponse(data, FindSimilarResponse.class);
        system.assert(resObj.documents != null);
        FindSimilarResponse.DocumentObj documentObj = resObj.documents.get(0);
        System.assertEquals('wiki_eng', documentObj.index);
        Test.stopTest();
    }
    
    /**
     *  Sync success Entity Extraction - GET Request
     */
    @isTest
    private static void testEntityExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('url', 'http://www.cnn.com'));
        params.add(new Param('entity_type', 'places_eng'));
        // get response
        Map<String,Object> data = client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.containsKey('entities'));
        Test.stopTest();
    }
    
    /**
     *  Sync failure Find Similar - GET Request
     */
    @isTest
    private static void testFindSimilarFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		List<Param> params = new List<Param>(); 
        params.add(new Param('text', 'Sports'));
        try
        {
            // get response
        	Map<String,Object> data = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.ASYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }
    
    
    /**
     *  Sync failure index status
     */
    @isTest
    private static void testIndexStatusFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
		List<Param> params = new List<Param>(); 
        params.add(new Param('index','test'));
        try
        {
            Map<String,Object> data= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }
    
    /**
     *  Get job status
     */
    @isTest
    
    private static void testGetJobStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobStatus('1');
        System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
        Test.stopTest();
    }
    
    /**
     *  Get job result speech recognition
     */
    @isTest
    private static void testGetJobResultSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('1');
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }
    
    /**
     *  Get job result text extraction
     */
    @isTest
    private static void testGetJobResultTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('2');
        System.assert(data.containsKey('document'));
        Test.stopTest();
    }
    
    /**
     *  Get job result predict api
     */
    @isTest
    private static void testGetJobResultPredict() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('3');
        System.assert(data.containsKey('file'));
        System.assert(data.get('status') == 200);
        Test.stopTest();
    }
    
    /**
     *  Get job result recommend api
     */
    @isTest
    private static void testGetJobResultRecommend() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data= client.getJobResult('4');
        System.assert(data.containsKey('allRecommendations'));
        Test.stopTest();
    }
    
    /**
     *  Get job result train prediction api
     */
    @isTest
    private static void testGetJobResultTrainPrediction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        Test.startTest();
        HODClient client = new HODClient(apiKey);
        Map<String,Object> data= client.getJobResult('5');
        system.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
         // Parsing HOD Response of async if Job Status is Finished
        TrainPredictionResponse resObj = (TrainPredictionResponse)HODResponseParser.parseCustomResponse(data, TrainPredictionResponse.class);
        System.assert(resObj.service == 'my-service');
        System.assert(resObj.message == 'Ready');
        Test.stopTest();
    }
    
    /**
     *  Get job result OCRDocument -- GET Request with HODResponseParser
     */
    @isTest
    private static void testGetJobResultOCRDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('6');
        system.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
         // Parsing HOD Response of async if Job Status is Finished
        OCRDocumentResponse resObj = (OCRDocumentResponse)HODResponseParser.parseCustomResponse(data, OCRDocumentResponse.class);
        OCRDocumentResponse.TextBlock textBox = resObj.text_block.get(0);
        System.assertEquals(688, textBox.width);
        System.assertEquals(1096, textBox.height);
        Test.stopTest();
    }
    
    /**
     *  Get job result OCRDocument -- GET Request with HODResponseParser Failed status
     */
    @isTest
    private static void testGetJobResultOCRDocumentFailed() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        try {
        	Map<String,Object> data = client.getJobResult('7');
        	system.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FAILED);
        	OCRDocumentResponse resObj = (OCRDocumentResponse)HODResponseParser.parseCustomResponse(data, OCRDocumentResponse.class);
        	system.assert(false, 'Expecting exception');
        } catch(HODClientException e) {
        	system.assert(e.getMessage().contains('Invalid job action parameters'));
        	system.assert(true, 'Expecting exception');
        }
        Test.stopTest();
    }
    
  
    
    // sets the mock service
    // if false : then error mock service is binded
    // if true : then success mock service is binded
    private static void testSetup(Boolean successful) { 
        // set mock callout class implementing the HttpCalloutMock Interface
        if (successful) {
            // set successful response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLSuccessResponseGenerator());
        } else {
            // set failure response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLFailureResponseGenerator());
        }
    }
}