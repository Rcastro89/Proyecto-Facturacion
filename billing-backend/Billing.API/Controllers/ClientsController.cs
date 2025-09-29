using Billing.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Billing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ClientsController : ControllerBase
    {
        private readonly IClientService _clientService;

        public ClientsController(IClientService clientService)
        {
            _clientService = clientService;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        
        {
            try
            {
                var clients = await _clientService.GetAllClientsAsync();
                return Ok(clients);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }
    }
}
