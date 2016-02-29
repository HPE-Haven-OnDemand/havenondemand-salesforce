/**
 * generic HTTP client to send HTTP request to the endpoint
 * and receive HTTP response from the endpoint
 *
 * @version 1.0
 * @author Topcoder
 */
public  class HttpClient {    
    
    /**
     * calls POST Request
     *
     * @param url Url of the endpoint , it should contain query string
     * @param payLoad pay load to be transferred in body
     * @return HttpResponse response 
     * @throws HODClientException 
     */  
    public static HttpResponse postRequest(String url, String payLoad)
    {	
    	// calling method with request type as POST
    	return invokeHttpRequest(url, HODClientConstants.POST_REQUEST, payLoad);
    }
    
    /**
     * calls GET Request
     *
     * @param url Url of the endpoint , it should contain query string
     * @return HttpResponse response 
     * @throws HODClientException 
     */  
    public static HttpResponse getRequest(String url)
    {	
    	// calling method with request type as GET
    	return invokeHttpRequest(url, HODClientConstants.GET_REQUEST, '');
    }
    
    /**
     * method to invoke http Request based on the passed requestType and endpoint url
     *
     * @param url Url of the endpoint , it should contain query string
     * @param requestType Request Type (GET or POST) for http request
     * @param payLoad pay load to be transferred in body. Only supported for post request type
     * @return HttpResponse response 
     * @throws HODClientException 
     */  
    private static HttpResponse invokeHttpRequest(String url, String requestType, String payLoad)
    {
    	try
        {
        	Http h = new Http();
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint(url);
        	req.setTimeout(HODClientConstants.TIME_OUT);
        	req.setMethod(requestType);
            
            // Specific block for post request for adding header details. 
            if(requestType == HODClientConstants.POST_REQUEST)
            {
            	// check for payload
            	if(payLoad.length() != 0)
	        	{
	                // set headers if body is passed
	            	req.setHeader('Content-Type','multipart/form-data; boundary='+HODClientConstants.BOUNDARY_MULTIPART);
	            	req.setHeader('Content-Length',String.valueof(payLoad.length()));
	            	req.setBody(payLoad);
	        	}
	        	else
	        	{
	            	req.setHeader('Accept', 'application/json');
	            	req.setHeader('Content-Type', 'application/json');
	        	}
            }
            return h.send(req);
        }
        catch(Exception ex)
        {
            // Wrapping up the error message and throwing the HODClientException
            throw new HODClientException(ex.getMessage());
        }
    }
   
}