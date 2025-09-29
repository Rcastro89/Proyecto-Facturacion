using Billing.Domain.Entities;

namespace Billing.Domain.Interfaces
{
    public interface IInvoiceRepository
    {
        Task<InvoiceDto> GetLastInvoice();
        Task CreateInvoiceAsync(InvoiceDto invoiceDto);
        Task<IEnumerable<InvoiceDto>> GetInvoiceByIdClient(int idClient);
        Task<IEnumerable<InvoiceDto>> GetInvoiceByInvoiceNumber(string invoiceNumber);
    }
}
