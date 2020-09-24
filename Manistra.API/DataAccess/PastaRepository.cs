using Manistra.API.Entities;
using Manistra.API.ResourceParameters;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    public class PastaRepository : BaseRepository<Pasta>, IPastaRepository
    {
        public PastaRepository(ApplicationDbContext context) : base(context)
        {
        }

        public override Pasta Get(long id)
        {
            var entity = context.Pastas
                .Include(x=>x.FavoritedBy)
                .FirstOrDefault(x => x.Id == id);

            return entity;
        }

        public IEnumerable<Pasta> GetAll(PastaResourceParameters parameters)
        {
            var pastas = context.Pastas
                .Include(x=>x.FavoritedBy)
                .AsQueryable();

            if (string.IsNullOrWhiteSpace(parameters.SearchQuery) == false)
            {
                pastas = pastas.Where(x => 
                    x.Title.ToUpper().Contains(parameters.SearchQuery.ToUpper()) ||
                    x.Content.ToUpper().Contains(parameters.SearchQuery.ToUpper()));
            }

            pastas = GetOrderByDelegate(parameters.OrderBy)(pastas);

            return pastas;
        }

        private Func<IQueryable<Pasta>, IOrderedQueryable<Pasta>> GetOrderByDelegate(string orderBy)
        {
            return orderBy switch
            {
                "date_ascending" => x => x.OrderBy(x => x.DateCreated),
                "date_descending" => x => x.OrderByDescending(x => x.DateCreated),
                "title_ascending" => x => x.OrderBy(x => x.Title),
                "title_descending" => x => x.OrderByDescending(x => x.Title),
                _ => x => x.OrderByDescending(x => x.Id)
            };
        }
    }
}
