import { LightningElement , track} from 'lwc';
import getAccounts from '@salesforce/apex/AccountService.getAccounts';
export default class SearchAccount extends LightningElement {
  searchKey = "sample";
  @track accounts;


  handleClick(){
  //  console.log("input:" +this.template.querySelector('lightning-input').value);
    getAccounts({ strAccountName :  this.seadrchKey})
    .then( result =>{
      this.accounts = result
      console.log(JSON.stringify(this.accounts));
    }
    )
    .catch(error =>{ console.log(error)});
  }
  
  handleKeyChange(event){
    if(event.target.value === ''){
      this.searchKey = 'sample';
    }
    else{
      this.searchKey = event.target.value;
    }    
  }
}