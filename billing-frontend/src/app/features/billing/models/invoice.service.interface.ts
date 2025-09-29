// src/app/features/billing/models/invoice.service.interface.ts
import { Observable } from 'rxjs';
import { HttpResponse } from '@angular/common/http';
import { InvoiceRequest, InvoiceResponse, LastInvoice } from './invoice.model';

export interface IInvoiceService {
  /**
   * Obtiene la última factura registrada.
   */
  getLastInvoice(): Observable<HttpResponse<LastInvoice>>;

  /**
   * Crea una nueva factura.
   * @param invoice Datos de la factura a crear
   */
  createInvoice(invoice: InvoiceRequest): Observable<InvoiceResponse>;

  /**
   * Obtiene las facturas de un cliente específico.
   * @param idClient ID del cliente
   */
  getByClient(idClient: number): Observable<HttpResponse<InvoiceRequest[]>>;

  /**
   * Obtiene la factura por número.
   * @param invoiceNumber Número de la factura
   */
  getByNumber(invoiceNumber: string): Observable<HttpResponse<InvoiceRequest[]>>;
}
