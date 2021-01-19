global class PostInstallClass implements InstallHandler {
    global void onInstall(InstallContext context) {
        if(context.previousVersion() == null) {
            Account a = new Account(name='Newco');
            insert(a);
            
           // Survey__c obj = new Survey__c(name='Client Satisfaction Survey');
            //insert obj;
            
            User u = [Select Id, Email from User where Id =:context.installerID()];   
            String toAddress= u.Email;
            String[] toAddresses = new String[]{toAddress};
                Messaging.SingleEmailMessage mail = 
                new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('mubashir.khazir@gmail.com');
            mail.setSenderDisplayName('My Package Support');
            mail.setSubject('Package install successful');
            mail.setPlainTextBody('Thanks for installing the package.');
            Messaging.sendEmail(new Messaging.Email[] { mail });
        }
        else
            if(context.previousVersion().compareTo(new Version(1,0)) == 0) {
               // Survey__c obj = new Survey__c(name='Upgrading from Version 1.0');
               // insert(obj);
            }
        if(context.isUpgrade()) {
            //Survey__c obj = new Survey__c(name='Sample Survey during Upgrade');
            //insert obj;
        }
        if(context.isPush()) {
           // Survey__c obj = new Survey__c(name='Sample Survey during Push');
            //insert obj;
        }
    }
}