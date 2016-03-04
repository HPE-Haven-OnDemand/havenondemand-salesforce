public class EntityExtractionExample {
	static String apiKey = '3eb36cdd-fd4d-466a-919d-f9e173b3bc9d';
	
	public static void getEntityExtraction() {
        try
		{
            // create client
            //HODClient client = new HODClient('your-apiKey');
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
            System.debug('----- resObj '+ resObj);
		}
		catch (HODClientException ex)
		{
		     String message = ex.getMessage();
		     System.debug('----- Error message '+ message);
		}
    }
}