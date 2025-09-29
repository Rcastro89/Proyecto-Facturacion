using Billing.API.Extensions;

var builder = WebApplication.CreateBuilder(args);

// Connection string
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// Dependency injection
builder.Services.AddApplicationServices(connectionString!);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Billing.API v1");
        c.RoutePrefix = string.Empty;
    });
}

app.UseCors("AllowAll");
app.UseHttpsRedirection();
app.MapControllers();
app.Run();
