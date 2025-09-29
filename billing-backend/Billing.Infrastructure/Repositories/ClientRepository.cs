using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using Billing.Infrastructure.Utils;
using Microsoft.Data.SqlClient;

namespace Billing.Infrastructure.Repositories
{
    public class ClientRepository: IClientRepository
    {
        private readonly string _connectionString;

        public ClientRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<Client>> GetAllAsync()
        {
            var clients = new List<Client>();
            SqlConsultReader reader = new(_connectionString);
            SqlDataReader? dataConsult = await reader.SqlConsult("sp_GetClients", null);

            while (await dataConsult.ReadAsync())
            {
                clients.Add(new Client
                {
                    IdClient = dataConsult.GetInt32(0),
                    Name = dataConsult.GetString(1),
                    Lastname = dataConsult.IsDBNull(2) ? null : dataConsult.GetString(2),
                    Address = dataConsult.GetString(3),
                    Phone = dataConsult.GetString(4),
                    Email = dataConsult.GetString(5),
                    Nit = dataConsult.GetString(6),
                    FullName = $"{dataConsult.GetString(1)} {(dataConsult.IsDBNull(2) ? string.Empty : dataConsult.GetString(2))}"
                });
            }

            return clients;
        }
    }
}
