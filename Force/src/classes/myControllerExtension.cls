public class myControllerExtension {
    private final Account acct;
    
    //The extension constructor initialize the private member
    //variable acct by using getRecord method from the standard controller
    
    public myControllerExtension(ApexPages.StandardController stdController) {
        this.acct = (Account) stdController.getRecord();        
    }
    
    public String getGreeting() {
        return 'Hello ' + acct.name + ' ('+acct.id+')';
    }
    
}