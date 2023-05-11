import { LightningElement ,wire } from 'lwc';
import getAccounts from '@salesforce/apex/HandleComboBoxLWC.getAccounts';
import getRelatedContacts from '@salesforce/apex/HandleComboBoxLWC.getRelatedContacts';

export default class ComboBoxDemo extends LightningElement {

    accounts = [];
    length;
    recordId;
    optionArray = [];
    cardVisible = false;
    columns = [
        { label: 'LastName', fieldName: 'LastName' },
        { label: 'FirstName', fieldName: 'FirstName'}        
    ];  
    connectedCallback(){
        getAccounts()
        .then(response =>{
            let arr = [];
            for(var i=0 ; i<response.length ; i++){
                arr.push({label : response[i].Name , value : response[i].Id})
            }
            this.optionArray = arr;
        })
        .catch(error => console.log(error))
    }

    get options() {
        console.log(this.optionArray);
        return this.optionArray;
    }

    handleChange(event) {
        this.cardVisible = true;
        this.value = event.detail.value;
        console.log(this.value);
        getRelatedContacts({accId : this.value})
        .then(response => {
            this.accounts= response;
            console.log(response)
            for(var i=0 ; i<response.length ; i++){
                console.log(response[i].LastName);
            }

        })
        .catch(error => console.log(error));
    }
    
}