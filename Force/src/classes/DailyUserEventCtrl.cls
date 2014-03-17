public with sharing class DailyUserEventCtrl {


    private final Account acct;
    public String locations{get; set;}    
    public String gAccLocation {get; set;}
    public DailyUserEventCtrl(ApexPages.StandardController controller) {
        this.acct= (Account) controller.getRecord();
        locations = getEventLocation();
        gAccLocation = getAccLocation();

    }
    
   
    
    public String getAccLocation() {
    
        Account lAccount = [SELECT BillingStreet FROM Account WHERE id =:ApexPages.currentPage().getParameters().get('id')];
        String lAddress = '';
        if (lAccount.BillingStreet != null && lAccount.BillingStreet != '') {
            lAddress  = lAccount.BillingStreet ;
        }
        
        return JSON.serialize(lAddress);
    }
   
    public String getEventLocation () {
        
        //DateTime qStartDate = DateTime.now();
        //if (acct.createDate != null) {
        //    qStartDate = acct.createDate;
        //}
        //DateTime qStrDate = DateTime.newInstance(qStartDate.year(), qStartDate.month(), qStartDate.day(), 0, 0, 0);
        //DateTime qEndDate = DateTime.newInstance(qStartDate.year(), qStartDate.month(), qStartDate.day(), 23, 59, 59);
        //System.debug(qStrDate +' '+qEndDate);
        List<String> lLocations = new List<String>();

        for (Event evt : [SELECT Subject, Location, EndDateTime, StartDateTime
                               FROM Event WHERE WhatId =:ApexPages.currentPage().getParameters().get('id')]) {                               
           lLocations.add(evt.Location);
           System.debug(evt.Location);
        }
        return JSON.serialize(lLocations);
    }
    
    public PageReference showMap() {        
        locations = getEventLocation();
        return null;
    }
    
}