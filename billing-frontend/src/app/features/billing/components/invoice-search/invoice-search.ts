import { Component, OnInit, ChangeDetectorRef, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { InvoiceService } from '../../services/invoice.service';
import { CustomerService } from '../../services/customer.service';
import { Customer } from '../../models/customer.model';
import { responseUrl } from '../../../../shared/utils/console-response';
import { InvoiceRequest } from '../../models/invoice.model';
import { ICustomerService } from '../../models/customer.service.interface';
import { IInvoiceService } from '../../models/invoice.service.interface';

@Component({
    selector: 'app-invoice-search',
    standalone: true,
    imports: [FormsModule, CommonModule],
    templateUrl: './invoice-search.html',
    styleUrls: ['./invoice-search.scss']
})
export class InvoiceSearchComponent implements OnInit {
    searchType: 'client' | 'invoice' = 'client';
    clientId: number | null = null;
    invoiceNumber: string = '';
    customers: Customer[] = [];
    results: InvoiceRequest[] = [];
    loading = false;

    private readonly invoiceService:  IInvoiceService = inject(InvoiceService);
    private readonly customerService: ICustomerService = inject(CustomerService);
    private readonly cdr = inject(ChangeDetectorRef);

    ngOnInit(): void {
        this.customerService.getAll().subscribe({
            next: res => {
                console.log('peticion ', responseUrl(res));
                this.customers = res.body || [];
                this.cdr.detectChanges();
            },
            error: err => console.error('Error fetching customers', err)
        });
    }

    finshConsult(error: boolean = false): void {
        this.loading = false;
        if (!error) {
            this.clientId = null;
            this.invoiceNumber = '';
        }
        this.cdr.detectChanges();
    }

    onSearch(): void {
        this.loading = true;
        this.results = [];

        if (this.searchType === 'client' && this.clientId) {
            this.invoiceService.getByClient(this.clientId).subscribe({
                next: res => {
                    console.log('peticion ', responseUrl(res));
                    this.results = res.body || [];
                    this.finshConsult();
                },
                error: err => {
                    console.error('Error fetching invoices by client', err);
                    alert('Error al buscar facturas para el cliente seleccionado');
                    this.finshConsult(true);
                }
            });
        } else if (this.searchType === 'invoice' && this.invoiceNumber) {
            this.invoiceService.getByNumber(this.invoiceNumber).subscribe({
                next: res => {
                    console.log('peticion ', responseUrl(res));
                    this.results = res.body || [];
                    this.finshConsult();
                },
                error: err => {
                    console.error('Error fetching invoice by number', err);
                    alert('Error al buscar facturas por número de factura');
                    this.finshConsult(true);
                }
            });
        } else {
            alert('Debe seleccionar un criterio de búsqueda válido');
            this.finshConsult();
        }
    }
}
