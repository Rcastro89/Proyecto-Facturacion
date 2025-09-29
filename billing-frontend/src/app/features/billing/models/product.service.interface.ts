import { Observable } from 'rxjs';
import { HttpResponse } from '@angular/common/http';
import { Product } from './product.model';

export interface IProductService {
  /**
   * Obtiene todos los productos disponibles.
   */
  getAllProducts(): Observable<HttpResponse<Product[]>>;
}
