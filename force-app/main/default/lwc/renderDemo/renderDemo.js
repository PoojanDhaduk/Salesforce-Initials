import { LightningElement } from 'lwc';
import jokeTemplate from './jokeTemplate.html';
import quoteTemplate from './quoteTemplate.html';
import renderDemo from './renderDemo.html';

export default class RenderDemo extends LightningElement {
    userInput = '';
    quote;  
    joke;
    handleClick(event){
        this.userInput = event.target.label;
        console.log(this.userInput);
        if(this.userInput === 'View Joke'){
            this.joke = "Joke is processing";
            this.getJoke();
        }
        else if(this.userInput === 'View Quote'){
            this.quote = "Quote is processing";
            this.getQuote();
        }
        }

    connectedCallback(){
        console.log('present inside connected call back');
    }
    render(){
        return this.userInput === 'View Joke' ? jokeTemplate : this.userInput === 'View Quote'? quoteTemplate:renderDemo 
    }

    getQuote() {
        fetch('https://api.quotable.io/random')
            .then(response => response.json())
            .then(data => {
                this.quote = data.content;
            })
            .catch(error => {
                console.log(error);
            });
    }
    getJoke() {
        fetch("https://v2.jokeapi.dev/joke/Any?blacklistFlags=racist,sexist&type=single&idRange=0-319")
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            this.joke = data.joke;
        });
    }
}