public with sharing class myCtrl {

    private final Account account;

      public myCtrl () {
            account = [select id, name, site, NumberOfEmployees, Industry from Account 
                       where id = :ApexPages.currentPage().getParameters().get('id')];
      }

      public Account getAccount() {
            return account;
      }

      public PageReference save() {
            update account;
            return null;
      }

      public PageReference cancel() {
            return null;
      }
      
      public void Test() {
      	System.debug('TEST');
      }
}