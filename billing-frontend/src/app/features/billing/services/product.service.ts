import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Product } from '../models/product.model';
import { IProductService } from '../models/product.service.interface';

@Injectable({
    providedIn: 'root'
})
export class ProductService implements IProductService {
    private readonly apiUrl = 'http://localhost:5055/api/products';

    constructor(private readonly http: HttpClient) { }

    getAllProducts(): Observable<HttpResponse<Product[]>> {
        return this.http.get<Product[]>(this.apiUrl, {
            observe: 'response'
        });
    }
}
