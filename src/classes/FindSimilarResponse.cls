/**
 * HOD Find Similar API response parser
 * https://dev.havenondemand.com/apis/findsimilar#response
 */
public with sharing class FindSimilarResponse {
	public List<DocumentObj> documents;
	
	public class DocumentObj {
		public string index;	// ( string , optional)	The database that the result returned from.
		public List<string> links;	// ( array[string] , optional)	The terms from the query that match in the results document.
		public string reference; 	// ( string , optional)	The reference string that identifies the result document.
		public string summary; 	// ( string , optional)	The summary of the results document.
		public string title; 	// ( string , optional)	The title of the result document.
		public Double weight; 	// ( number , optional)	The percentage relevance that the result document has to the original query.
	}
}