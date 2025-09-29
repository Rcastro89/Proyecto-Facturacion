using Billing.Domain.Entities;

namespace Billing.Domain.Interfaces
{
    public interface IProductService
    {
        Task<IEnumerable<Product>> GetAllProductsAsync();

        Task<Product?> GetProductByIdAsync(int idProduct);
    }
}
