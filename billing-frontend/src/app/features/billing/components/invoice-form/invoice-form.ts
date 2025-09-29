import { Component, OnInit, ChangeDetectorRef, inject, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { firstValueFrom } from 'rxjs';
import { Customer } from '../../models/customer.model';
import { responseUrl } from '../../../../shared/utils/console-response';
import { InvoiceService } from '../../services/invoice.service';
import { Product } from '../../models/product.model';
import { ProductService } from '../../services/product.service';
import { IInvoiceService } from '../../models/invoice.service.interface';
import { ICustomerService } from '../../models/customer.service.interface';
import { CustomerService } from '../../services/customer.service';
import { InvoiceRequest } from '../../models/invoice.model';
import { IProductService } from '../../models/product.service.interface';

@Component({
  selector: 'app-invoice-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './invoice-form.html',
  styleUrls: ['./invoice-form.scss']
})
export class InvoiceFormComponent implements OnInit {
  customers: Customer[] = [];
  products: Product[] = [];
  // Invoice state
  invoiceNumber: string = '';
  clientId: number | null = null;
  lines: Product[] = [];

  subtotal = 0;
  tax = 0;
  total = 0;
  loading = false;

  private readonly customerService: ICustomerService = inject(CustomerService);
  private readonly invoiceService: IInvoiceService = inject(InvoiceService);
  private readonly productService: IProductService = inject(ProductService);
  private readonly cdr = inject(ChangeDetectorRef);
  private readonly zone = inject(NgZone)

  constructor(
  ) {
    this.addLine();
  }

  ngOnInit(): void {
    this.getLastInvoice();

    this.customerService.getAll().subscribe({
      next: res => {
        console.log('peticion ', responseUrl(res));
        this.customers = res.body || [];
      },
      error: err => console.error(err)
    });

    this.productService.getAllProducts().subscribe({
      next: res => {
        console.log('peticion ', responseUrl(res));
        this.products = res.body || [];
      },
      error: err => console.error(err)
    });
  }

  getLastInvoice() {
    this.invoiceService.getLastInvoice().subscribe({
      next: res => {
        console.log('peticion ', responseUrl(res));
        this.invoiceNumber = res.body?.invoiceNumber || "0001";
        this.cdr.detectChanges();
      },
      error: err => console.error(err)
    });
  }

  addLine() {
    this.lines.push({
      idProduct: null,
      description: '',
      price: 0,
      quantity: 1,
      total: 0,
      imageUrl: ''
    });
    this.recalcTotals();
  }

  removeLine(index: number) {
    this.lines.splice(index, 1);
    this.recalcTotals();
  }

  onProductChange(idProduct: number | null, indexLine: number) {
    let line: Product = {
      idProduct: null, description: '',
      price: 0,
      quantity: 1,
      total: 0,
      imageUrl: ''
    }

    const searchProduct = this.products.find(l => l.idProduct == idProduct);

    if (searchProduct) {
      line = { ...searchProduct, quantity: 1 };
    }

    console.log('Product line:', line);

    this.recalcLine(line, indexLine);
  }

  recalcLine(line: Product, indexLine: number) {
    const q = Number(line.quantity) || 0;
    const u = Number(line.price) || 0;
    line.total = +(q * u);

    this.lines[indexLine] = line;
    console.log('recalcLine', this.lines);
    this.recalcTotals();
  }

  recalcTotals() {
    this.subtotal = this.lines.reduce((s, l) => s + (Number(l.total) || 0), 0);
    this.tax = +(this.subtotal * 0.19);
    this.total = +(this.subtotal + this.tax);
  }

  onCustomerChange(clientId: number | null) {
    this.clientId = clientId;
  }

  onNew() {
    this.zone.run(() => {
      this.clientId = null;
      this.lines = [];
      this.addLine();
      this.subtotal = this.tax = this.total = 0;
      this.getLastInvoice();
    });
  }

  async onSave() {
    if (!this.clientId) {
      console.error('Client not selected');
      alert('Seleccione un cliente para guardar la factura.');
      return;
    }
    if (this.lines.length === 0 ||
      this.lines.every(l => !l.idProduct) ||
      this.lines.some(l => l.idProduct == 0 || l.idProduct == null)) {
      console.error('No lines in the invoice');
      alert('La factura no tiene productos para guardar.');
      return;
    }

    this.loading = true;

    const invoice: InvoiceRequest = {
      invoiceNumber: this.invoiceNumber,
      invoiceDate: new Date().toISOString(),
      clientId: this.clientId || 0,
      details: this.lines.map(l => ({
        idProduct: l.idProduct || 0,
        quantity: l.quantity,
        unitPrice: l.price
      }))
    };

    try {
      const res = await firstValueFrom(this.invoiceService.createInvoice(invoice));
      console.log('peticion ', responseUrl(res));
      alert('Factura guardada con éxito');
      this.zone.run(() => {
        this.loading = false;
        this.onNew();
      });
    } catch (err) {
      console.error('Error saving invoice', err);
      this.zone.run(() => {
        this.loading = false;
      });
      alert('Error al guardar la factura');
    }
  }
}
