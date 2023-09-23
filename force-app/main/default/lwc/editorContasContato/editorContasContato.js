import { api, LightningElement } from 'lwc';
import buscarContatosConta from '@salesforce/apex/ContactController.buscarContatosConta';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class EditorContasContato extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api listContas;
    @api mostrarDados = false;

    connectedCallback() {
        this.buscarContatosConta();
    }

    buscarContatosConta() {
        buscarContatosConta({ idConta : this.recordId })
        .then(result => {
            this.listContas = result;
            this.mostrarDados = true;
        })
    }

    handleMaskCPF(event) {
        const x = event.target.value
            .replace(/\D+/g, '')
            .match(/(\d{0,3})(\d{0,3})(\d{0,3})(\d{0,2})/);
        event.target.value = `${x[1]}` + (x[2] ? `.${x[2]}` : ``) + (x[3] ? `.${x[3]}` : ``) + (x[4] ? `-${x[4]}` : ``);
    }

    handleMaskTelefone(event) {
        const x = event.target.value
            .replace(/\D+/g, '')
            .match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
        event.target.value = !x[2] ? x[1] : `(${x[1]}) ${x[2]}` + (x[3] ? `-${x[3]}` : ``);
    }

    handleMaskCEP(event) {
        const x = event.target.value
            .replace(/\D+/g, '')
            .match(/(\d{0,5})(\d{0,3})/)
        event.target.value= !x[2] ? x[1] : `${x[1]}-${x[2]}` + (x[3] ? `-${x[3]}` : ``);

    }

    sucessMessageContact(event) {
        const evt = new ShowToastEvent({
            title: 'Contato atualizado',
            variant: 'success',
            mode: 'dismissable'
        });
        console.log('teste', event.detail.value);
        this.dispatchEvent(evt);
    }

    sucessMessageAccount() {
        const evt = new ShowToastEvent({
            title: 'Conta atualizada',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    handleChange(event) {
        console.log('You selected an account: ' + event.detail.value);
    }

    checarCep(event) {
        cep = event.target.value;
        console.log(cep);
    }
}