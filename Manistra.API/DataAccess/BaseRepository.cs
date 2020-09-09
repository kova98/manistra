using Manistra.API.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.DataAccess
{
    public abstract class BaseRepository<Entity> : IRepository<Entity> where Entity : class, IEntity
    {
        internal ApplicationDbContext context;
        internal DbSet<Entity> dbSet;

        public BaseRepository(ApplicationDbContext context)
        {
            this.context = context;
            this.dbSet = context.Set<Entity>();
        }

        public IQueryable<Entity> GetAll()
        {
            return dbSet;
        }

        public virtual Entity Get(long id)
        {
            var entity = dbSet.FirstOrDefault(x => x.Id == id);

            return entity;
        }

        public virtual void Add(Entity entity)
        {
            dbSet.Add(entity);

            context.SaveChanges();
        }

        public virtual void Remove(long id)
        {
            var entityToRemove = dbSet.FirstOrDefault(x => x.Id == id);

            if (context.Entry(entityToRemove).State == EntityState.Detached)
            {
                dbSet.Attach(entityToRemove);
            }

            dbSet.Remove(entityToRemove);

            context.SaveChanges();
        }

        public virtual void Update(Entity entityToUpdate)
        {
            dbSet.Update(entityToUpdate);
            context.SaveChanges();
        }
    }
}
