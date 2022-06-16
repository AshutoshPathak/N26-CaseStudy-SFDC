import { LightningElement, api, wire } from 'lwc';
import retrieveProductInfos from "@salesforce/apex/ProductInformationController.fetchRecords";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import Contact_Email from '@salesforce/label/c.Contact_Email';
import Contact_Name from '@salesforce/label/c.Contact_Name';
import Contact_Phone from '@salesforce/label/c.Contact_Phone';
import No_Data_Text from '@salesforce/label/c.No_Data_Text';
import Product_Categories_and_Informations from '@salesforce/label/c.Product_Categories_and_Informations';

export default class ProductInformations extends NavigationMixin(LightningElement) {
    @api recordId;
    productInfos;
    error;
    stack;
    label = {
        Contact_Email,
        Contact_Name,
        Contact_Phone,
        No_Data_Text,
        Product_Categories_and_Informations
    };
    hasRecords = false;
    @wire(retrieveProductInfos, { caseRecordId: "$recordId" })
    processProduct({ error, data }) {
        if (data) {
            this.productInfos = data;
            this.hasRecords = data.ProductInformations && data.ProductInformations.length;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.productInfos = undefined;
        }
    }
    

    connectedCallback(){
        console.log('recordId: '+this.recordId);
    }

    
    errorCallback(error, stack) {
        this.error = error;
        this.showNotification('Error', this.error, 'error');
    }

    showNotification(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    handleContactClick(event){
        this.navigateToRecord(this.productInfos.ContactId);
    }

    handleProductClick(event){
        this.navigateToRecord(this.productInfos.ProductId);
    }

    navigateToRecord(recordId){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view',
            }
        });
    }
}