<aura:application extends="force:slds" >
    <lightning:tabset>
        <div class="slds-icon slds-icon_xx-small">
            <lightning:tab label="Library" id="one" iconName="doctype:library_folder"></lightning:tab>
        </div>
        <lightning:tab label="Library" id="one" iconName="doctype:library_folder" ></lightning:tab>
        <lightning:tab label='Tab First'>
               <aura:set attribute="label">First Tab<lightning:icon iconName="doctype:library_folder" /></aura:set>
           Tab1 Content
        </lightning:tab>
    </lightning:tabset>
    
    <div class="demo-only" style="height:12rem">
        <div class="slds-tabs_default">
            <ul class="slds-tabs_default__nav" role="tablist">
                <li class="slds-tabs_default__item slds-is-active" title="Library" role="presentation">
                    <a class="slds-tabs_default__link" href="javascript:void(0);" role="tab" tabindex="0" aria-selected="true" aria-controls="tab-default-1" id="tab-default-1__item">
                        <span class="slds-tabs__left-icon">
                            <span class="slds-icon_container " title="Library">
                                <lightning:icon iconName="doctype:library_folder" />
                            </span>
                        </span>Library</a>
                </li>
                <li class="slds-tabs_default__item slds-is-active" title="Library" role="presentation">
                    <a class="slds-tabs_default__link" href="javascript:void(0);" role="tab" tabindex="0" aria-selected="true" aria-controls="tab-default-1" id="tab-default-1__item">
                        <span class="slds-tabs__left-icon">
                            <span class="slds-icon_container " title="Library">
                                <lightning:icon iconName="doctype:library_folder" size='small'/>
                            </span>
                        </span>Library</a>
                </li>
                <li class="slds-tabs_default__item slds-is-active" title="Library" role="presentation">
                    <a class="slds-tabs_default__link" href="javascript:void(0);" role="tab" tabindex="0" aria-selected="true" aria-controls="tab-default-1" id="tab-default-1__item">
                        <span class="slds-tabs__left-icon">
                                <lightning:icon iconName="doctype:library_folder" size='large' id='ico'/>
                        </span>Library</a>
                </li>
            </ul>
            <div id="tab-default-1" class="slds-tabs_default__content slds-show" role="tabpanel" aria-labelledby="tab-default-1__item">
                <h2>Item One Content</h2>
            </div>
        </div>
        
    </div>
    
</aura:application>