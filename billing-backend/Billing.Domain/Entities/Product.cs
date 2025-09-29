namespace Billing.Domain.Entities
{
    public class Product
    {
        public int IdProduct { get; set; }
        public string Description { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public int Stock { get; set; }
        public bool State { get; set; }
        public string? imageUrl { get; set; }
    }
}
