// src/app/features/billing/services/invoice.service.ts
import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { InvoiceRequest, InvoiceResponse, LastInvoice } from '../models/invoice.model';
import { IInvoiceService } from '../models/invoice.service.interface';

@Injectable({
    providedIn: 'root'
})
export class InvoiceService implements IInvoiceService {
    private readonly apiUrl = 'http://localhost:5055/api/invoice';

    constructor(private readonly http: HttpClient) { }

    getLastInvoice(): Observable<HttpResponse<LastInvoice>> {
        return this.http.get<LastInvoice>(`${this.apiUrl}/lastInvoice`, {
            observe: 'response'
        });
    }

    createInvoice(invoice: InvoiceRequest): Observable<InvoiceResponse> {
        return this.http.post<InvoiceResponse>(this.apiUrl, invoice);
    }

    getByClient(idClient: number): Observable<HttpResponse<InvoiceRequest[]>> {
        return this.http.get<InvoiceRequest[]>(`${this.apiUrl}/${idClient}`, {
            observe: 'response'
        });
    }

    getByNumber(invoiceNumber: string): Observable<HttpResponse<InvoiceRequest[]>> {
        return this.http.get<InvoiceRequest[]>(`${this.apiUrl}/byinvoicenumber/${invoiceNumber}`, {
            observe: 'response'
        });
    }
}
