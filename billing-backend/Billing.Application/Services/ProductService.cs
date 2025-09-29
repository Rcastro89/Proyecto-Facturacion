using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Billing.Application.Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;

        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        public Task<IEnumerable<Product>> GetAllProductsAsync()
        {
            return _productRepository.GetAllAsync();
        }

        public Task<Product?> GetProductByIdAsync(int idProduct)
        {
            return _productRepository.GetProductByIdAsync(idProduct);
        }
    }
}
