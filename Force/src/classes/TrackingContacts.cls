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
        
        String lResult;
        try {                    
                Map<String, String> lContactMap = new Map<String, String>();
                for (Contact lContact : [SELECT name, accountid from Contact]) {
                        lContactMap.put(lContact.accountid, lContact.name); //name is contact name
                }
                
                Map<String, String> lAccountMap = new Map<String, String>();
                for (Account lAccount : [SELECT id, BillingCity, BillingState, BillingCountry, BillingStreet from Account WHERE id IN (SELECT accountid from Contact)]) {
                        if (lContactMap.get(lAccount.id) != null && lContactMap.get(lAccount.id).trim() != '') {
                                lAccountMap.put(lContactMap.get(lAccount.id), lAccount.BillingCity+','+lAccount.BillingState+','+lAccount.BillingCountry+','+lAccount.BillingStreet);
                        }                                                       
                }
                lResult = JSON.serialize(lAccountMap);
                
                /*JSONGenerator generator = JSON.createGenerator(true);
                for(String lKey : lAccountMap.keySet()) {
                        generator.writeStartObject();
                        generator.writeStringField(lKey, lAccountMap.get(lKey));
                        generator.writeEndObject();
                }*/
                
                //lResult = generator.getAsString();            
                
        } catch (Exception e) {
                System.debug('Error: '+e.getMessage());
        }       
        
        return lResult;
    }

}