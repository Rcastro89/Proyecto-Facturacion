import { Routes } from '@angular/router';
import { MainLayoutComponent } from './shared/layout/main-layout';
import { InvoiceFormComponent } from './features/billing/components/invoice-form/invoice-form';
import { InvoiceSearchComponent } from './features/billing/components/invoice-search/invoice-search';

export const routes: Routes = [
  {
    path: '',
    component: MainLayoutComponent,
    children: [
      { path: 'invoice/new', component: InvoiceFormComponent },
      { path: 'invoice/search', component: InvoiceSearchComponent },
      { path: '', redirectTo: 'invoice/new', pathMatch: 'full' }
    ]
  }
];
