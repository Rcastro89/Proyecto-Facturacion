using Billing.Application.Services;
using Billing.Domain.Entities;
using Billing.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Billing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class InvoiceController : ControllerBase
    {
        private readonly IInvoiceService _invoiceService;

        public InvoiceController(IInvoiceService invoiceService)
        {
            _invoiceService = invoiceService;
        }

        [HttpGet("lastInvoice")]
        public async Task<IActionResult> GetLastInvoice()
        {
            try
            {
                var invoice = await _invoiceService.GetLastInvoice();
                return Ok(invoice);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateInvoice([FromBody] InvoiceDto invoiceDto)
        {
            try
            {
                if (invoiceDto == null || invoiceDto.Details == null || !invoiceDto.Details.Any())
                    return BadRequest("The invoice must have at least one detail.");

                await _invoiceService.CreateInvoiceAsync(invoiceDto);
                return Ok(new { message = "Invoice created successfully." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while saving the invoice: " + ex.Message);
            }
        }

        [HttpGet("{idClient}")]
        public async Task<IActionResult> GetInvoiceByIdClient(int idClient)
        {
            try
            {
                var invoices = await _invoiceService.GetInvoiceByIdClient(idClient);
                return Ok(invoices);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }

        [HttpGet("byinvoicenumber/{invoiceNumber}")]
        public async Task<IActionResult> GetInvoiceByInvoiceNumber(string invoiceNumber)
        {
            try
            {
                var invoices = await _invoiceService.GetInvoiceByInvoiceNumber(invoiceNumber);
                return Ok(invoices);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }
    }
}
