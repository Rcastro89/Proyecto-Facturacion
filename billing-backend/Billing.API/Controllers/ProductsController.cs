using Billing.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Billing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var products = await _productService.GetAllProductsAsync();
                return Ok(products);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }

        [HttpGet("{idProduct}")]
        public async Task<IActionResult> GetProductById(int idProduct)
        {
            try
            {
                var product = await _productService.GetProductByIdAsync(idProduct);
                return Ok(product);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "An error occurred while processing your request: " + ex.Message);
            }
        }
    }
}
