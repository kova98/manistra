using Manistra.API.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Authentication
{
    public class User : IdentityUser
    {
        public ICollection<Pasta> Favorites { get; set; } = new List<Pasta>();
    }
}
