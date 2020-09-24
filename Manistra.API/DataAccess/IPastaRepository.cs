using Manistra.API.Authentication;
using Manistra.API.Entities;
using Manistra.API.ResourceParameters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    public interface IPastaRepository : IRepository<Pasta>
    {
        IEnumerable<Pasta> GetAll(PastaResourceParameters parameters);
        IEnumerable<Pasta> GetFavoritesForUser(User user, PastaResourceParameters parameters);
    }
}
