export interface LastInvoice {
  invoiceNumber: string;
}

export interface InvoiceDetail {
  idProduct: number;
  quantity: number;
  unitPrice: number;
}

export interface InvoiceRequest {
  invoiceNumber: string;
  invoiceDate: string;
  clientId: number;
  details: InvoiceDetail[];
  totalInvoice?: number;
  fullName?: string;
}

export interface InvoiceResponse {
  message: string;
}
