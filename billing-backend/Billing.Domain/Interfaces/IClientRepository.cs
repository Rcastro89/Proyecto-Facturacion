using Billing.Domain.Entities;

namespace Billing.Domain.Interfaces
{
    public interface IClientRepository
    {
        Task<IEnumerable<Client>> GetAllAsync();
    }
}
