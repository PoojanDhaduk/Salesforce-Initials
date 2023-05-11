import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountService.getAccounts';
export default class SearchAccount extends LightningElement {
  searchKey = "sample";
  // accounts;

  connectedCallback(){
    // getAccounts({ strAccountName :  this.searchKey})
    // .then( result =>{ this.accounts = result }
    // ).catch(error =>{ console.log(error)});
    // console.log(this.accounts);
  }
  @wire (getAccounts,{strAccountName: '$searchKey'}) accounts;
  handleKeyChange(event){
    this.searchKey = event.target.value;
    // getAccounts({ strAccountName :  this.searchKey})
    // .then( result =>{ this.accounts = result }
    // ).catch(error =>{ console.log(error)});
    // console.log(this.accounts);
  }
}