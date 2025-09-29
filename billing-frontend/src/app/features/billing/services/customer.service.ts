import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Customer } from '../models/customer.model';
import { ICustomerService } from '../models/customer.service.interface';

@Injectable({
  providedIn: 'root'
})
export class CustomerService implements ICustomerService {
  private readonly apiUrl = 'http://localhost:5055/api/clients';

  constructor(private readonly http: HttpClient) { }

  getAll(): Observable<HttpResponse<Customer[]>> {
    return this.http.get<Customer[]>(this.apiUrl, {
      observe: 'response',
      headers: { 'Cache-Control': 'no-cache' }
    });
  }
}
