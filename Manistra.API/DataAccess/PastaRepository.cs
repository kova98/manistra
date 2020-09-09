using Manistra.API.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    public class PastaRepository : BaseRepository<Pasta>
    {
        public PastaRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
