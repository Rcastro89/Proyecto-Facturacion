using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using Billing.Infrastructure.Utils;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Billing.Infrastructure.Repositories
{
    public class ProductRepository(string connectionString) : IProductRepository
    {
        private readonly string _connectionString = connectionString;

        public async Task<IEnumerable<Product>> GetAllAsync()
        {
            List<Product> products = [];
            SqlConsultReader reader = new(_connectionString);
            SqlDataReader? dataConsult = await reader.SqlConsult("sp_GetProducts", null);

            while (await dataConsult.ReadAsync())
            {
                products.Add(new Product
                {
                    IdProduct = dataConsult.GetInt32(0),
                    Description = dataConsult.GetString(1),
                    Price = dataConsult.GetDecimal(2),
                    Stock = dataConsult.GetInt32(3),
                    State = dataConsult.GetBoolean(4),
                    imageUrl = dataConsult.IsDBNull(5) ? null : dataConsult.GetString(5)
                });
            }

            return products;
        }

        public async Task<Product?> GetProductByIdAsync(int idProduct)
        {
            Product? product = null;
            SqlConsultReader reader = new(_connectionString);
            Dictionary<string, object> parameters = new()
            {
                { "@IdProducto", idProduct }
            };
            SqlDataReader? dataConsult = await reader.SqlConsult("sp_GetProductById", parameters);

            while (await dataConsult.ReadAsync())
            {
                product = new Product
                {
                    IdProduct = dataConsult.GetInt32(0),
                    Description = dataConsult.GetString(1),
                    Price = dataConsult.GetDecimal(2),
                    Stock = dataConsult.GetInt32(3),
                    State = dataConsult.GetBoolean(4),
                    imageUrl = dataConsult.GetString(5)
                };
            }

            return product;
        }
    }
}
