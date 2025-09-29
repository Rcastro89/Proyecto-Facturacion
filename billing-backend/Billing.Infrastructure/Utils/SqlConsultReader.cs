using Billing.Domain.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Billing.Infrastructure.Utils
{
    public class SqlConsultReader
    {
        private readonly string _connectionString;

        public SqlConsultReader(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<SqlDataReader> SqlConsult(string spConsult, Dictionary<string, object>? parameters)
        {
            var conn = new SqlConnection(_connectionString);
            var cmd = new SqlCommand(spConsult, conn)
            {
                CommandType = CommandType.StoredProcedure
            };

            if (parameters != null)
            {
                foreach (var param in parameters)
                {
                    cmd.Parameters.AddWithValue(param.Key, param.Value);
                }
            }

            await conn.OpenAsync();
            return await cmd.ExecuteReaderAsync(CommandBehavior.CloseConnection);
        }
    }
}
