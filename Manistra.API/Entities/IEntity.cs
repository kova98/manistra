﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Entities
{
    public interface IEntity
    {
        public long Id { get; set; }
    }
}
