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

- Login in the Salesforce account and install [package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t28000000IjdQ).

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
      // Getting job data from the reponse returned for finished job.
      Object objectData = data.get('text_block');
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
      // Getting job data from the reponse returned for finished job.
      Object objectData = data.get('text_block');
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
### Parsing Response

- Method returns Map<String,Object>
``` Apex
// value can be type cast to appropriate class or data structure
Object value = response.get('key');

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
