import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class AccountList extends LightningElement {
    accounts;
    @wire(getObjectInfo , {objectApiName: ACCOUNT_OBJECT })
    objectInfo;
    aaaa() {
        console.log(JSON.stringify(this.objectInfo.data.recordTypeInfos));
    }

    @wire(getListUi, {
        objectApiName: ACCOUNT_OBJECT,
        listViewApiName: 'AllAccounts'
    })
    wiredlistView({ error, data }) {
        if (data) {
            this.accounts = data.records.records;
        } else if (error) {
            console.error(error);
        }
    }
}