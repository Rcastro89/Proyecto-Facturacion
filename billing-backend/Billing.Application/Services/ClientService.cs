using Billing.Domain.Entities;
using Billing.Domain.Interfaces;

namespace Billing.Application.Services
{
    public class ClientService : IClientService
    {
        private readonly IClientRepository _clientRepository;

        public ClientService(IClientRepository clientRepository)
        {
            _clientRepository = clientRepository;
        }

        public Task<IEnumerable<Client>> GetAllClientsAsync()
        {
            return _clientRepository.GetAllAsync();
        }
    }
}
