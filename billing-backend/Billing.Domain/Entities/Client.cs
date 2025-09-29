namespace Billing.Domain.Entities
{
    public class Client
    {
        public int IdClient { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Lastname { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Nit { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;

    }
}
