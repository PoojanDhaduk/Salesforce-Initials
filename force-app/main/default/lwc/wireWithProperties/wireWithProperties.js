import { LightningElement ,wire ,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class WireWithProperties extends LightningElement {
    @api recordId;
    name;

    @wire(getRecord , {recordId: '$recordId' , fields:[ACCOUNT_NAME_FIELD] })
    record({data , error}){
        if(data){
            this.name = data.fields.Name.value;
        }
        else if(error){
            console.log(error);
        }
    }
    
    
    // get name(){
    //     return getFieldValue(this.record.data , ACCOUNT_NAME_FIELD);
    // }
}   