using Manistra.API.Entities;
using Manistra.API.ResourceParameters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    public class PastaRepository : BaseRepository<Pasta>, IPastaRepository
    {
        public PastaRepository(ApplicationDbContext context) : base(context)
        {
        }

        public IEnumerable<Pasta> GetAll(PastaResourceParameters parameters)
        {
            var pastas = dbSet.AsQueryable();

            if (string.IsNullOrWhiteSpace(parameters.SearchQuery) == false)
            {
                pastas = pastas.Where(x => 
                    x.Title.ToUpper().Contains(parameters.SearchQuery.ToUpper()) ||
                    x.Content.ToUpper().Contains(parameters.SearchQuery.ToUpper()));
            }

            return pastas;
        }
    }
}
