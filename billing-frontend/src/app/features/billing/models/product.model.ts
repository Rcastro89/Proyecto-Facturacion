export interface Product {
  idProduct: number | null;
  description?: string;
  price: number;
  quantity: number;
  total: number;
  imageUrl?: string;
  stock?: number;
};