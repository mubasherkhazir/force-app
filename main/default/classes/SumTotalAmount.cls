/*
 * "Create Custom Object Financial Account. Create field
> Total Fees
Create Custom Object Receivables. Create field
> Total Amount
> Financial Account(Lookup field)
Update the sum of all the total Amount field of Receivables to the total fees of Financial Account."
*/
public class SumTotalAmount {
    
    public static void sumAmount(){
        
        Map<ID,Financial_Account__c> FinancialMap=new Map<ID,Financial_Account__c>([select id,Name,Total_Fees__c from Financial_Account__c limit 5000]);
        System.debug('Financial_Account__c list = '+FinancialMap);
        
        Set<ID> FinancialID=FinancialMap.keySet();
        Map<ID,Receivables__c> ReceivablesMap=new Map<ID,Receivables__c>([select id,Total_Amount__c,Financial_Account__c from Receivables__c where Financial_Account__r.ID =:FinancialID limit 500]);
        System.debug('ReceivablesMap  >>>>>>>>>>>>>>>>>>>> '+ReceivablesMap);

        /////// BLOCK 1 //////
        Decimal amount=0;
        try{
            for(Financial_Account__c financial:FinancialMap.values()){
            for(Receivables__c receivables:ReceivablesMap.values()){
                
                if(financial.Id==receivables.Financial_Account__c){
                    if(financial.Total_Fees__c==NULL){
                        financial.Total_Fees__c=0;
                    }
                    System.debug('Receivable total amount '+receivables.Total_Amount__c);
                    amount +=receivables.Total_Amount__c;
                }
                
            }
                financial.Total_Fees__c=amount;
        }
            update FinancialMap.values();
        }Catch(Exception e){
            System.debug('exception caught in sum total amount 1 block '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
        
    }

}