public with sharing class AccountHelper {
    private Account account;

    public AccountHelper(ApexPages.StandardController controller) {
        account = (Account)controller.getRecord();
    }

    public List<Contact>getContacts() {
        return [select MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry from Contact where accountid=:account.id];
    }
}