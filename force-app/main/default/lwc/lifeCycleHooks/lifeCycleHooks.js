/* eslint-disable @lwc/lwc/no-inner-html */
import { LightningElement , track} from 'lwc';
export default class QuoteGenerator extends LightningElement {

    @track quote;
    connectedCallback() {
        // console.log('connectedCallback');
        this.getQuote();
    }

    getQuote() {
        fetch('https://api.quotable.io/random')
            .then(response => response.json())
            .then(data => {
                this.quote = data.content;
                // console.log(data.content);
                const quoteElement = this.template.querySelector('.quote');
                if (this.quote) {
                    quoteElement.innerHTML = this.quote;
                }
            })
            .catch(error => {
                console.log(error);
            });
        
    }

    renderedCallback() {
        // console.log('renderedCallback');
        const quoteElement = this.template.querySelector('.quote');
        if (quoteElement && this.quote) {
            quoteElement.innerHTML = this.quote;
        }
    }
}
