public with sharing class TrackingContacts {

    public String mTrackingJson {get; set;}

    public TrackingContacts(ApexPages.StandardController controller) {

        mTrackingJson = buildTrackingJson();
    }
        
    //TODO: is it correct to display all contacts with billingaddress of specified account?
    private String buildTrackingJson() {        
        
        try { 
           		Map<String, String> lAccountMap = new Map<String, String>();
                String lAccId = ApexPages.currentPage().getParameters().get('id');
                //Account lAccount = [SELECT id, BillingCity, BillingState, BillingCountry, BillingStreet from Account WHERE id =:lAccId];
                for (Contact lContact : [SELECT name, MailingStreet from Contact where accountid=:lAccId]) {
                	lAccountMap.put(lContact.name, lContact.MailingStreet);
                }
                
                return JSON.serialize(lAccountMap);
                
        } catch (Exception e) {
                System.debug('Error: '+e.getMessage());
                return '{}';
        }       
        
        return '{}';
    }

}