namespace Billing.Domain.Entities
{
    public class InvoiceDetailDto
    {
        public int idProduct { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
    }

    public class InvoiceDto
    {
        public string InvoiceNumber { get; set; } = string.Empty;
        public DateTime InvoiceDate { get; set; }
        public int ClientId { get; set; }
        public List<InvoiceDetailDto> Details { get; set; } = new();
        public decimal? TotalInvoice { get; set; }
        public string? FullName { get; set; }
    }
}
