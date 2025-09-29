using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using Billing.Infrastructure.Utils;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using System.Data;


namespace Billing.Infrastructure.Repositories
{
    public class InvoiceRepository(string connectionString) : IInvoiceRepository
    {
        private readonly string _connectionString = connectionString;
        public async Task<InvoiceDto> GetLastInvoice()
        {
            InvoiceDto lastInvoice = new();
            SqlConsultReader reader = new(_connectionString);
            SqlDataReader? dataConsult = await reader.SqlConsult("sp_GetLastInvoiceNumber", null);
            while (await dataConsult.ReadAsync())
            {
                lastInvoice.InvoiceNumber = dataConsult["NextInvoiceNumber"].ToString()!;
            }
            return lastInvoice;
        }

        public async Task CreateInvoiceAsync(InvoiceDto invoiceDto)
        {
            try
            {
                SqlConsultReader reader = new(_connectionString);
                Dictionary<string, object> parameters = new()
                {
                    { "@NumeroFactura", invoiceDto.InvoiceNumber },
                    { "@FechaFactura", invoiceDto.InvoiceDate },
                    { "@IdCliente", invoiceDto.ClientId },
                    { "@DetallesFactura", JsonConvert.SerializeObject(invoiceDto.Details) },
                };

                SqlDataReader? dataConsult = await reader.SqlConsult("sp_SaveInvoice", parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("An error occurred while saving the invoice: " + ex.Message);
            }
        }

        public async Task<IEnumerable<InvoiceDto>> GetInvoiceByIdClient(int idClient)
        {
            try
            {
                var invoices = new List<InvoiceDto>();
                SqlConsultReader reader = new(_connectionString);

                Dictionary<string, object> parameters = new()
                {
                    { "@idClient", idClient },
                };
                SqlDataReader? dataConsult = await reader.SqlConsult("usp_GetInvoicesByClient", parameters);

                while (await dataConsult.ReadAsync())
                {
                    invoices.Add(new InvoiceDto
                    {
                        InvoiceNumber = dataConsult.GetString(0),
                        InvoiceDate = dataConsult.GetDateTime(1),
                        TotalInvoice = dataConsult.GetDecimal(2),
                        FullName = $"{dataConsult.GetString(3)} {dataConsult.GetString(4)}",
                    });
                }

                return invoices;
            
            }
            catch (Exception ex)
            {
                throw new Exception("An error occurred while saving the invoice: " + ex.Message);
            }
        }

        public async Task<IEnumerable<InvoiceDto>> GetInvoiceByInvoiceNumber(string invoiceNumber)
        {
            try
            {
                var invoices = new List<InvoiceDto>();
                SqlConsultReader reader = new(_connectionString);

                Dictionary<string, object> parameters = new()
                {
                    { "@NumeroFactura", invoiceNumber.PadLeft(4, '0') },
                };
                SqlDataReader? dataConsult = await reader.SqlConsult("usp_GetInvoicesByInvoiceNumber", parameters);

                while (await dataConsult.ReadAsync())
                {
                    invoices.Add(new InvoiceDto
                    {
                        InvoiceNumber = dataConsult.GetString(0),
                        InvoiceDate = dataConsult.GetDateTime(1),
                        TotalInvoice = dataConsult.GetDecimal(2),
                        FullName = $"{dataConsult.GetString(3)} {dataConsult.GetString(4)}",
                    });
                }

                return invoices;

            }
            catch (Exception ex)
            {
                throw new Exception("An error occurred while saving the invoice: " + ex.Message);
            }
        }
    }
}
