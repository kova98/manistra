using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    interface IRepository<Entity>
    {
        IQueryable<Entity> GetAll();
        Entity Get(long id);
        void Add(Entity entity);
        void Update(Entity entity);
        void Remove(long id);
    }
}
