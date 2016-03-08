# HPE Haven OnDemand Salesforce Client Library

----
## Overview
This library can be used to consume [HPE Haven OnDemand - https://dev.havenondemand.com/apis](https://dev.havenondemand.com/apis) in Salesforce.

----
## What is HAVEN ONDEMAND?
Haven OnDemand is a set of over 70 APIs for handling all sorts of unstructured data. Here are just some of our APIs' capabilities:

- Speech to text
- OCR
- Text extraction
- Indexing documents
- Smart search
- Language identification
- Concept extraction
- Sentiment analysis
- Web crawlers
- Machine learning

For a full list of all the APIs and to try them out, check out [https://www.havenondemand.com/developer/apis](https://dev.havenondemand.com/apis).

----
## Installation

### Using Unmanaged package

- Login in the Salesforce account and install [package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t28000000Inok).

### Using ANT

- Make sure ant is installed on the machine. Please check out this [link] (http://ant.apache.org/manual/install.html) to install the ant.
- Set username and password in build.properties. If your password is YYYY and security token in XXXX then password will be YYYYXXXX
- Open a cmd and enter follwing commands
```
ant -version
cd <HPE_Haven_OnDemand folder>
ant deployCode
```
----
## Usage

### Initialization

``` Apex

// with apikey and version
HODClient client = new HODClient(apiKey, version);

// with apikey (version will default to v1)
HODClient client = new HODClient(apiKey);


```
### Sample post sync call (INDEX_STATUS)

``` Apex
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('index','test'));
      // get response
      Map<String,Object> response= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

```
### Sample get sync call (Find Similar)

``` Apex
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('text', 'Sports'));
      params.add(new Param('highlight', 'sentences'));

      // get response
      Map<String,Object> response = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

```
### Sample get sync call (Language Identification)

``` Apex
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('text', 'testing'));
      params.add(new Param('additional_metadata', 'true'));

      // get response
      Map<String,Object> response = client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.SYNC);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

```
### Sample get sync call (Entity Extraction)

``` Apex
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('url', 'http://www.cnn.com'));
      params.add(new Param('entity_type', 'places_eng'));

      // get response
      Map<String,Object> response = client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}


```

### Sample get async call (OCR Document)

``` Apex
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('url', 'https://www.havenondemand.com/sample-content/images/bowers.jpg'));
      params.add(new Param('mode', 'document_photo'));

      // get response
      Map<String,Object> response = client.getRequest(params, HODAPP.OCR_DOCUMENT, HODClientConstants.REQ_MODE.ASYNC);
      String jobId = (String)response.get(HODClientConstants.JOB_ID);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// check job status using the getJobStatus method call

// If job status is finished then getJobStatus method itself will return job data as part of response
try{
      Map<String,Object> data = client.getJobStatus(jobID);
      System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);

      // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      OCRDocumentResponse resObj = (OCRDocumentResponse)HODResponseParser.parseCustomResponse(data, OCRDocumentResponse.class);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// If job is not yet finished i.e either “queued”, “in progress” or “failed” status.
// get job data using the getJobResult method, which waits until the job has finished and then returns the result
try{
      Map<String,Object> data = client.getJobStatus(jobID);
      System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) != HODClientConstants.JOB_RESPONSE_FINISHED);

      if(data.get(HODClientConstants.JOB_RESPONSE_STATUS) != HODClientConstants.JOB_RESPONSE_FINISHED) {
      	 data = client.getJobResult(jobID);
      	 // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      	 OCRDocumentResponse resObj = (OCRDocumentResponse)HODResponseParser.parseCustomResponse(data, OCRDocumentResponse.class);
      }
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// Or one can call getJobResult method directly to get the job data without checking the job status
// getJobResult method which waits until the job has finished and then returns the result
try{
      Map<String,Object> data = client.getJobResult(jobID);
      // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      OCRDocumentResponse resObj = (OCRDocumentResponse)HODResponseParser.parseCustomResponse(data, OCRDocumentResponse.class);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}


```

### Sample post async call (list resources)

``` Apex
try{
      // create client get job id
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('flavor',new List<String>{'standard','explorer'}));
      params.add(new Param('type',new List<String>{'content','connector'}));
      // get response
      Map<String,Object> data = client.postRequest(params, HODApp.LIST_RESOURCES, HODClientConstants.REQ_MODE.ASYNC);
      String jobId = data.get(HODClientConstants.JOB_ID);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// check job status using the getJobStatus method call

// If job status is finished then getJobStatus method itself will return job data as part of response
try{
      Map<String,Object> data = client.getJobStatus(jobID);
      System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
      // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      ListResourcesResponse resObj = (ListResourcesResponse)HODResponseParser.parseCustomResponse(data, ListResourcesResponse.class);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// If job is not yet finished i.e either “queued”, “in progress” or “failed” status.
// get job data using the getJobResult method, which waits until the job has finished and then returns the result
try{
      Map<String,Object> data = client.getJobStatus(jobID);
      System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) != HODClientConstants.JOB_RESPONSE_FINISHED);

      if(data.get(HODClientConstants.JOB_RESPONSE_STATUS) != HODClientConstants.JOB_RESPONSE_FINISHED) {
      	 data = client.getJobResult(jobID);
      	 // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      	 ListResourcesResponse resObj = (ListResourcesResponse)HODResponseParser.parseCustomResponse(data, ListResourcesResponse.class);
      }
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

// Or one can call getJobResult method directly to get the job data without checking the job status
// getJobResult method which waits until the job has finished and then returns the result
try{
      Map<String,Object> data = client.getJobResult(jobID);
      // Calling HODResponseParser parseCustomResponse method to parsed the ASYNC response data
      ListResourcesResponse resObj = (ListResourcesResponse)HODResponseParser.parseCustomResponse(data, ListResourcesResponse.class);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

```

### Sample post async call with file attachment (PREDICT API)

``` Apex
try{
      HODClient client = new HODClient(apiKey, version);
      // list of Param has to be passed for request with file attachment
      List<Param> params = new List<Param>();
      params.add(new Param('test.csv',Blob.valueOf(csvString),'application/CSV'));
      params.add(new Param('service_name','test'));
      // call API
      Map<String,Object> data = client.postRequest(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
      String jobId = data.get(HODClientConstants.JOB_ID);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}


```

### Sample post async call with multiple file attachments (Text Extraction API)

``` Apex
try{
      HODClient client = new HODClient(apiKey, version);
      // list of Param has to be passed for request with file attachment
      List<Param> params = new List<Param>();
      params.add(new Param('test1.pdf',Blob.toPdf(pdfValue1),'application/pdf'));
      params.add(new Param('test2.pdf',Blob.toPdf(pdfValue2),'application/pdf'));
      // call API
      Map<String,Object> data =  client.postRequest(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
      String jobId = data.get(HODClientConstants.JOB_ID);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}


```


### Error Handling

- All the calls throw HODClientException  if there is an error
``` Apex
HODClient client = new HODClient(apiKey, version);
// list of Param has to be passed for request with file attachment
List<Param> params = new List<Param>();
params.add(new Param('test.csv',Blob.valueOf(csvString),'application/CSV'));
params.add(new Param('service_name','test'));

try
{
     // call API
     Map<String,Object> data = client.postRequest(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}

```

### HODClient Instance Methods

``` Apex

    /**
     * calls POST Request
     *
     * @param params params to be passed in query string
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return Map<String,Object> response
     * @throws HODClientException
     */
    public Map<String,Object> postRequest(List<Param> params, String hodApp, HODClientConstants.REQ_Mode mode)


```

``` Apex

    /**
     * calls GET Request
     *
     * @param params params to be passed
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return Map<String,Object> response
     * @throws HODClientException
     */
    public Map<String,Object> getRequest(List<Param> params, String hodApp, HODClientConstants.REQ_Mode mode)


```

``` Apex

    /**
     * Get status of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public Map<String,Object> getJobStatus(String jobId)
```

``` Apex
   /**
     * Get result of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public Map<String,Object> getJobResult(String jobId)
```

### Parsing Response

- Method returns Map<String,Object>

### HODResponseParser API References
HODResponseParser class is used to parse the response date ruturned as Map<String,Object>. All method return Map<String,Object> which can be passed as argument to HODResponseParser method. HODResponseParser static methods.

``` Apex
   /**
    * Method for parsing the HOD API response to specific supported object type. The method will be
    * called after successfull calling of the HOD API and returned response will be passed here for parsing
    * with the target response class type (based on the called HOD API) as argument.
    * @param response  String Successful response received on HOD API call
    * @param classType Target class type to whom HOD API response result to be parsed
    * @throws HODClientException
    */
    public static Object parseCustomResponse(String response, type classType)
```

``` Apex
   /**
    * Method for parsing the HOD API response to specific supported object type. The method will be
    * called after successfull calling of the HOD API and returned response will be passed here for parsing
    * with the target response class type (based on the called HOD API) as argument.
    * @param responseMap  Map<String,Object> Successful response received on HOD API call
    * @param classType Target class type to whom HOD API response result to be parsed
    * @throws HODClientException
    */
    public static Object parseCustomResponse(Map<String,Object> responseMap, type classType)
```
*Example code:*

```
   /**
    * HOD Find Similar API response parser
    * https://dev.havenondemand.com/apis/findsimilar#response
    */
    public with sharing class FindSimilarResponse {
    	public List<DocumentObj> documents;

	public class DocumentObj {
		public string index;	// ( string , optional)	The database that the result returned from.
		public List<string> links; // ( array[string] , optional)	The terms from the query that match in the results document.
		public string reference; // ( string , optional)	The reference string that identifies the result document.
		public string summary; 	// ( string , optional)	The summary of the results document.
		public string title; 	// ( string , optional)	The title of the result document.
		public Double weight; 	// ( number , optional)	The percentage relevance that the result document has to the original query.
	}
    }

// Using the FindSimilarResponse class to parse the Find Similar HOD API Response using the HODResponseParser     
try
{
      // create client
      HODClient client = new HODClient(apiKey, version);
      List<Param> params = new List<Param>();
      params.add(new Param('text', 'Sports'));
      params.add(new Param('highlight', 'sentences'));

      // get response
      Map<String,Object> response = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
      FindSimilarResponse resObj = (FindSimilarResponse)HODResponseParser.parseCustomResponse(response, FindSimilarResponse.class);
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     System.debug(message);
}
```

----

## Demo code 1:

**Call the Entity Extraction API to extract people and places from cnn.com website with a synchronous GET request**

```
public class EntityExtractionExample {
	static String apiKey = 'your-apiKey';

	public static void getEntityExtraction()
	{
	        try
		{
	            // create client
	            HODClient client = new HODClient(apiKey);
	            List<Param> params = new List<Param>();
	            params.add(new Param('url', 'http://www.cnn.com'));
	            params.add(new Param('entity_type', 'places_eng'));

	            // get response
	            Map<String,Object> response = client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
	            EntityExtractionResponse resObj = (EntityExtractionResponse)HODResponseParser.parseCustomResponse(response, EntityExtractionResponse.class);

	            if (resObj != null) {
	            	String values = '';
		            for (EntityExtractionResponse.Entity ent : resObj.entities) {
		                values += ent.type + '\n';
		                values += ent.normalized_text + '\n';
		                if (ent.type.equals('places_eng')) {
		                    values += ent.additional_information.place_country_code + '\n';
		                    values += ent.additional_information.place_elevation + '\n';
		                    values += ent.additional_information.place_population + '\n';
		                } else if (ent.type.equals('people_eng')) {
		                    values += ent.additional_information.person_date_of_birth +'\n';
		                    values += ent.additional_information.person_profession + '\n';
		                    values += ent.additional_information.wikipedia_eng + '\n';
		                }
		            }
	            }
		}
		catch (HODClientException ex)
		{
		     String message = ex.getMessage();
		     System.debug('----- Error message '+ message);
		}
	}
}

/**
 * HOD Entity Extraction API response parser
 * https://dev.havenondemand.com/apis/extractentities#response
 */
public class EntityExtractionResponse {
	public List<Entity> entities;	// The details of extracted items.

	public class Match
	{
	    public integer offset;
	    public String original_text;
	    public integer original_length;
	}

	public class AdditionalInformation
	{
	    public List<String> person_profession;
	    public String person_date_of_birth;
	    public integer wikidata_id;
	    public String wikipedia_eng;
	    public String image;
	    public String person_date_of_death;
	    public Long place_population;
	    public String place_country_code;
	    public Double place_elevation;
	    public string place_continent;
	    public string place_type;
	    public string place_region1;
	    public string place_region2;
	    public double place_timezone;
	    public Double lon;
	    public Double lat;   
	}

	public class Entity
	{
	    public String normalized_text;
	    public String type;
	    public List<Match> matches;
	    public double score;
	    public AdditionalInformation additional_information;
	    public List<Object> components;
	    public integer normalized_length;
	    public integer offset;
	    public integer original_length;
	    public String original_text;

	}
}
```

----
## Supported standard response classes
```
AddToTextIndexResponse.cls
AutoCompleteResponse.cls
BarcodeRecognitionResponse.cls
CancelConnectorResponse.cls
ConceptExtractionResponse.cls
ConnectorHistoryResponse.cls
ConnectorStatusResponse.cls
CreateConnectorResponse.cls
CreateQueryProfileResponse.cls
CreateTextIndexResponse.cls
DeleteConnectorResponse.cls
DeleteFromTextIndexResponse.cls
DeleteQueryProfileResponse.cls
DeleteTextIndexResponse.cls
EntityExtractionResponse.cls
ExpandContainerResponse.cls
ExpandTermsResponse.cls
FaceDetectionResponse.cls
FindRelatedConceptsResponse.cls
FindSimilarResponse.cls
GetCommonNeighborsResponse.cls
GetNeighborsResponse.cls
GetNodesResponse.cls
GetShortestPathResponse.cls
GetSubgraphResponse.cls
HighlightTextResponse.cls
ImageRecognitionResponse.cls
IndexStatusResponse.cls
LanguageIdentificationResponse.cls
ListResourcesResponse.cls
OCRDocumentResponse.cls
PredictResponse.cls
RecommendResponse.cls
RestoreTextIndexResponse.cls
RetrieveConfigurationResponse.cls
RetrieveQueryProfileResponse.cls
SentimentAnalysisResponse.cls
SpeechRecognitionResponse.cls
StartConnectorResponse.cls
StopConnectorResponse.cls
StoreObjectResponse.cls
SuggestLinksResponse.cls
SummarizeGraphResponse.cls
TextExtractionResponse.cls
TextTokenizationResponse.cls
TrainPredictionResponse.cls
UpdateClassificationResponse.cls
UpdateConnectorResponse.cls
UpdateQueryProfileResponse.cls
ViewDocumentResponse.cls
```
## Contributing
We encourage you to contribute to this repo! Please send pull requests with modified and updated code.
