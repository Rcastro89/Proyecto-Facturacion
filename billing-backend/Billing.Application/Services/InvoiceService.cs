using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Billing.Application.Services
{
    public class InvoiceService : IInvoiceService
    {
        private readonly IInvoiceRepository _invoiceRepository;

        public InvoiceService(IInvoiceRepository invoiceRepository)
        {
            _invoiceRepository = invoiceRepository;
        }

        public Task<InvoiceDto> GetLastInvoice()
        {
            return _invoiceRepository.GetLastInvoice();
        }

        public Task CreateInvoiceAsync(InvoiceDto invoiceDto)
        {
            return _invoiceRepository.CreateInvoiceAsync(invoiceDto);
        }

        public Task<IEnumerable<InvoiceDto>> GetInvoiceByIdClient(int idClient)
        {
            return _invoiceRepository.GetInvoiceByIdClient(idClient);
        }

        public Task<IEnumerable<InvoiceDto>> GetInvoiceByInvoiceNumber(string invoiceNumber)
        {
            return _invoiceRepository.GetInvoiceByInvoiceNumber(invoiceNumber);
        }
    }
}
