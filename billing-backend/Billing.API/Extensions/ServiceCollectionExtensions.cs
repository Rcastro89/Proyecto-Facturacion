using Billing.Application.Services;
using Billing.Domain.Interfaces;
using Billing.Infrastructure.Repositories;

namespace Billing.API.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services, string connectionString)
        {
            services.AddScoped<IClientService, ClientService>();
            services.AddScoped<IClientRepository>(sp => new ClientRepository(connectionString));

            services.AddScoped<IProductService, ProductService>();
            services.AddScoped<IProductRepository>(sp => new ProductRepository(connectionString));

            services.AddScoped<IInvoiceService, InvoiceService>();
            services.AddScoped<IInvoiceRepository>(sp => new InvoiceRepository(connectionString));


            return services;
        }
    }
}
