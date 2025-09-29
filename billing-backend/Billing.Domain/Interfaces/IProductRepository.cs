using Billing.Domain.Entities;

namespace Billing.Domain.Interfaces
{
    public interface IProductRepository
    {
        Task<IEnumerable<Product>> GetAllAsync();

        Task<Product?> GetProductByIdAsync(int idProduct);
    }
}
