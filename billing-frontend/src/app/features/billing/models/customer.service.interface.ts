import { Observable } from 'rxjs';
import { Customer } from './customer.model';
import { HttpResponse } from '@angular/common/http';

export interface ICustomerService {
  getAll(): Observable<HttpResponse<Customer[]>>;
}
