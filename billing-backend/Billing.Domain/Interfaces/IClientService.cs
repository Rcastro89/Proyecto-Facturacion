using Billing.Domain.Entities;

namespace Billing.Domain.Interfaces
{
    public interface IClientService
    {
        Task<IEnumerable<Client>> GetAllClientsAsync();
    }
}
