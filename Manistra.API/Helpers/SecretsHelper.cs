using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Helpers
{
    public static class SecretsHelper
    {
        static SecretsHelper()
        {
            ConnectionString = Environment.GetEnvironmentVariable("POSTGRES_CONNECTION_STRING");
        }

        public static string ConnectionString { get; }
    }
}
