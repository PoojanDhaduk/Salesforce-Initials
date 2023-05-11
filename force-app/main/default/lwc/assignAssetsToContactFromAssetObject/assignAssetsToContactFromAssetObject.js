import { LightningElement , api } from 'lwc';
import getContacts from '@salesforce/apex/ContactHandlerForAsset.getContacts';
import assignAsset from '@salesforce/apex/ContactHandlerForAsset.assignAsset';

export default class AssignAssetsToContactFromAssetObject extends LightningElement {
    columns = [
        { label: 'LastName', fieldName: 'LastName' },
    ];      
    contacts =[];
    selectedContacts =[];
    @api recordId;

    connectedCallback(){
        getContacts()
        .then((result) => {
            this.contacts = result;
        }).catch((err) => {
            alert(err);
        });
    }

    addContactToList(event){
        this.selectedContacts = [];
        for(var i=0 ; i< event.detail.selectedRows.length ; i++){
            this.selectedContacts.push(event.detail.selectedRows[i].Id);
        }
        
    }
    handleClick(event){
        if(this.selectedContacts.length>0){
            console.log(JSON.stringify(this.selectedContacts));
            assignAsset({ listOfIds: this.selectedContacts , assetId : this.recordId })
              .then(result => {
                console.log('Result', result);
            })
            .catch(error => {
                console.error('Error:', error);
            });
            eval("$A.get('e.force:refreshView').fire();");
        }
        else{
            alert('Please select contacts to assign asset');
        }
    }

}