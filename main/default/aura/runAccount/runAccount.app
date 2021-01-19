<aura:application controller="InsertsAccount" extends="force:slds">
    
    
    <aura:attribute name="newAccount" type="Account"
                    default="{ 'sobjectType': 'Account',
                             'Name': '',
                             'AccountNumber':'',
                             'Rating':''
                             }"/>
    
    
    <aura:handler name="init" value="{!this}" action="{!c.doInit}" />
    
    <div class="slds-grid slds-wrap">
        <div class="slds-box slds-m-top_xx-small slds-align_absolute-center">
            <div class="slds-col slds-size_1-of-1">
                <lightning:input label="Account Name"  value="{!v.newAccount.Name}" required="true" />
                <lightning:input type="number" label="Account Number" value="{!v.newAccount.AccountNumber}" />
                <lightning:input type="String" label="Rating" value="{!v.newAccount.Rating}"  />
                <div class="slds-m-top_xx-small slds-align_absolute-center">
                    <lightning:button variant="success" label="Success" title="Success" onclick="{!c.doInit}"/>        
                    
                </div>
            </div>
        </div>
    </div>
    
    
</aura:application>