/**
 * HOD Parser for parsing the response received as part of HOD API call to some specific supported response types
 */
public class HODResponseParser {
	
	/**
	 * Method for parsing the HOD API response to specific supported object type. The method will be 
	 * called after successfull calling of the HOD API and returned response will be passed here for parsing
	 * with the target response class type (based on the called HOD API) as argument. 
	 * @param response  String Successful response received on HOD API call
     * @param classType Target class type to whom HOD API response result to be parsed
     * @throws HODClientException
	 */
	public static Object parseCustomResponse(String response, type classType)
    {
    	Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response);
    	return parseCustomResponse(responseMap, classType);
    }
	
	/**
	 * Method for parsing the HOD API response to specific supported object type. The method will be 
	 * called after successfull calling of the HOD API and returned response will be passed here for parsing
	 * with the target response class type (based on the called HOD API) as argument. 
	 * @param responseMap  Map<String,Object> Successful response received on HOD API call
     * @param classType Target class type to whom HOD API response result to be parsed
     * @throws HODClientException
	 */
	public static Object parseCustomResponse(Map<String,Object> responseMap, type classType)
    {
    	// If response Map is null or empty throw exception
    	if(responseMap == null || responseMap.isEmpty()) throw new HODClientException(HODClientConstants.EMPTY_RESPONSE);
    	
    	Map<String,Object> result = responseMap;
    	
    	try {
	    	// Checking if response data contains 'actions' key or not. If true, then it is an ASYNC
	    	// API response data result. Need to get the result based on status.
	    	if(responseMap.containsKey('actions'))
	    	{
	    		List<Object> actions = (List<Object>)responseMap.get('actions');
	    		if(actions != null && !actions.isEmpty()) {
	    			Map<String,Object> actionMap = (Map<String,Object>)actions.get(0);
	    			String action = (String)actionMap.get('action');
	    			String status = (String)actionMap.get('status');
	    			
	    			// If job status is finished, then only we will be able to get the Job result to parse.
	    			if (status.equals(HODClientConstants.JOB_RESPONSE_FINISHED)) 
	    			{
	    				result = (Map<String,Object>)actionMap.get('result');
	    			}
	    			else if (status.equals(HODClientConstants.JOB_RESPONSE_QUEUED)) 
	    			{
	                    throw new HODClientException('Task is in queue.');
	                } 
	                else if (status.equals(HODClientConstants.JOB_RESPONSE_IN_PROCESS)) 
	                {
	                    throw new HODClientException('Task is in progress.');
	                }
	                else if (status.equals(HODClientConstants.JOB_RESPONSE_FAILED)) 
	                {  
	                	// Preparing error message in case of failed status.
	                	List<Object> errors = (List<Object>)actionMap.get('errors');
	                	String errorMsg = '';
	                	if(errors != null) {
		                    for (Object error : errors) {
		                    	Map<String,Object> errorMap = (Map<String,Object>)error;
		                        errorMsg += String.valueOf(errorMap.get(HODClientConstants.ERROR_NO))+':'+String.valueOf(errorMap.get(HODClientConstants.ERROR_REASON));
		                        
		                        if (errorMap.containsKey('detail') && errorMap.get('detail') != null) {
		                            errorMsg += ' Error detail: '+ String.valueOf(errorMap.get('detail'));
		                        }
		                    }
	                	}
	                    throw new HODClientException('Task status failed. '+ errorMsg);
	                }
	                else 
	                {	
	                	throw new HODClientException('Unknown error');
	                }
	    		}
	    	}
	    	String serializeResult = JSON.serialize(result);
	    	return JSON.deserializeStrict(serializeResult, classType);
    	}
    	catch(Exception e) 
    	{
    		throw new HODClientException('Error while parsing the HOD API response. Error: '+ e.getMessage());
    	}
    }
    
    
}