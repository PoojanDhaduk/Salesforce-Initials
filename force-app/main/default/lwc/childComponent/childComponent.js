import { LightningElement, api } from 'lwc';

export default class ChildComp extends LightningElement {

   handleChange(event) {
       // event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name
        });
       this.dispatchEvent(selectEvent);
    }

    @api
    calledFromParent(msg){
        console.log(msg);
    }
}