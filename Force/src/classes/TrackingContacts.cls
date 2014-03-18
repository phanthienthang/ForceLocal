public with sharing class TrackingContacts {

    public String mTrackingJson {get; set;}

    public TrackingContacts(ApexPages.StandardController controller) {

        mTrackingJson = buildTrackingJson();
    }
        
    //This method used to build a json string which contain contact name and billing address 
    //of contacts.
    //To check: - The performace isn't good (there are 3 loops)
    //Is there any another way to get the needed information (contact name and account billing address) by one soql?
    private String buildTrackingJson() {        
        
        try { 
           		Map<String, String> lAccountMap = new Map<String, String>();
                String lAccId = ApexPages.currentPage().getParameters().get('id');
                //Account lAccount = [SELECT id, BillingCity, BillingState, BillingCountry, BillingStreet from Account WHERE id =:lAccId];
                for (Contact lContact : [SELECT name, MailingStreet from Contact where accountid=:lAccId]) {
                	lAccountMap.put(lContact.name, lContact.MailingStreet);
                }
                
                return JSON.serialize(lAccountMap);
                               
                
                /*JSONGenerator generator = JSON.createGenerator(true);
                for(String lKey : lAccountMap.keySet()) {
                        generator.writeStartObject();
                        generator.writeStringField(lKey, lAccountMap.get(lKey));
                        generator.writeEndObject();
                }*/
                
                //lResult = generator.getAsString();            
                
        } catch (Exception e) {
                System.debug('Error: '+e.getMessage());
                return '{}';
        }       
        
        return '{}';
    }

}