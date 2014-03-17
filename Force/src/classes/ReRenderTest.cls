public with sharing class ReRenderTest {


    private final Account acct;
    public String locations{get; set;}    
    public String gAccLocation {get; set;}
    /*
     *Constructor method for controller extension of Account object
     */
    public ReRenderTest(ApexPages.StandardController controller) {
        this.acct= (Account) controller.getRecord();
        locations = getEventLocation();
        gAccLocation = getAccLocation();
    }   
    
    /*
     * getAccLocation method is used to get account's address information
     */
    public String getAccLocation() {
    
        Account lAccount = [SELECT BillingStreet FROM Account WHERE id =:ApexPages.currentPage().getParameters().get('id')];
        String lAddress = '';
        if (lAccount.BillingStreet != null && lAccount.BillingStreet != '') {
            lAddress  = lAccount.BillingStreet ;
        }
        
        return JSON.serialize(lAddress);
    }
   
    /*
     * getEventLocation method is used to get all event in specified day
     * of a sepecified account.
     */
    public String getEventLocation () {
        
        DateTime qStartDate = DateTime.now();
        if (acct.SelectedDate__c != null) {
            qStartDate = acct.SelectedDate__c;
        }
        DateTime qStrDate = DateTime.newInstance(qStartDate.year(), qStartDate.month(), qStartDate.day(), 0, 0, 0);
        DateTime qEndDate = DateTime.newInstance(qStartDate.year(), qStartDate.month(), qStartDate.day(), 23, 59, 59);
        System.debug(qStrDate +' '+qEndDate);
        List<String> lLocations = new List<String>();

        for (Event evt : [SELECT Subject, Location, EndDateTime, StartDateTime
                               FROM Event WHERE WhatId =:ApexPages.currentPage().getParameters().get('id') AND (StartDateTime >=:qStrDate AND StartDateTime <=:qEndDate)]) {                               
           lLocations.add(evt.Location);
           System.debug(evt.Location);
        }
        return JSON.serialize(lLocations);
    }
    
    /*
     * showMap method is used to reload the events of specified account by specified day.
     */
    public Pagereference showMap() {        
        locations = getEventLocation();
        //System.debug('Call showMap: '+locations);
        //System.debug('Date Time selected: '+ acct.SelectedDate__c);
        return null;
    }
}