using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Helpers
{
    public static class ConnectionStringHelper
    {
        private static readonly string user;
        private static readonly string password;
        private static readonly string host;
        private static readonly string port;
        private static readonly string database;

        static  ConnectionStringHelper()
        {
            user = Environment.GetEnvironmentVariable("POSTGRES_USER");
            password = Environment.GetEnvironmentVariable("POSTGRES_PASSWORD");
            host = Environment.GetEnvironmentVariable("POSTGRES_HOST");
            port = Environment.GetEnvironmentVariable("POSTGRES_PORT");
            database = Environment.GetEnvironmentVariable("POSTGRES_DATABASE");
        }

        public static string ConnectionString => $"User ID={user};Password={password};Host={host};Port={port};Database={database};";
    }
}
