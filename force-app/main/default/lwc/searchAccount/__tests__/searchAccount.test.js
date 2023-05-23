/* eslint-disable @lwc/lwc/no-document-query */

import 'setimmediate';
import { createElement } from 'lwc';
import SearchAccount from 'c/searchAccount';
import getAccounts from '@salesforce/apex/AccountService.getAccounts';

const accounts = require('./Data/accountData.json');
const error = require('./Data/error.json');

jest.mock(
    '@salesforce/apex/AccountService.getAccounts',
    () => {
        return {
            default: jest.fn()
        };
    },
    { virtual: true }
);
describe('c-search-account', () => {
    beforeEach(() => {
        const element = createElement('c-search-account', {
            is: SearchAccount
        });
        
        document.body.appendChild(element);
    });

    it('check account list', () => {
        
        getAccounts.mockResolvedValue(accounts);
        
        const element = document.querySelector('c-search-account');
        const btn = element.shadowRoot.querySelector('lightning-button');
        btn.click();
        
        return new Promise(setImmediate).then(() =>{
            const accountListName = element.shadowRoot.querySelectorAll('p.accountName');
            console.log('accountList:' + accountListName);
            expect(accountListName.length).toBe(accounts.length);
            expect(accountListName[0].textContent).toBe(accounts[0].Name);
        })
    });
    it('check for error' , () => {
        getAccounts.mockRejectedValue(error);
        const element = document.querySelector('c-search-account');
        const btn = element.shadowRoot.querySelector('lightning-button');
        btn.click();
        const errortext = element.shadowRoot.querySelectorAll('p.error');
        expect(errortext).not.toBeNull();
    })
});