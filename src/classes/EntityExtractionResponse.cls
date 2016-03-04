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