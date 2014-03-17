public with sharing class ContactList {
	
	public String mContactListJson;
	
	public ContactList() {
		mContactListJson = buildContactJson();
	}
	
	//This method used to build a json string which contain contact name and billing address 
	//of this contact
	String buildContactJson() {
		
		try {
			
			Map<String, String> lContactMap = new Map<String, String>();
			for (Contact lContact : [SELECT name, accountid from Contact]) {
				lContactMap.put(lContact.name, lContact.accountid); //name is contact name
			}
			
			Map<String, String> lAccountMap = new Map<String, String>();
			for (Account lAccount : [SELECT id, BillingStreet from Account WHERE id IN (SELECT accountid from Contact)]) {
				lAccountMap.put(lContactMap.get(lAccount.id), lAccount.BillingStreet);			
			}
			
			JSONGenerator generator = JSON.createGenerator(true);			
			for(String lKey : lAccountMap.keySet()) {
				generator.writeStartObject();
				generator.writeStringField(lKey, lAccountMap.get(lKey));
				generator.writeEndObject();
			}
			
			mContactListJson = generator.getAsString();		
			
		} catch (Exception e) {
			System.debug('Error: '+e.getMessage());
		}	
		
		return mContactListJson;
	}
}