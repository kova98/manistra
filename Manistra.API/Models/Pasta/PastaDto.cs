﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Models.Pasta
{
    public class PastaDto
    {
        public long Id { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public DateTimeOffset DateCreated { get; set; }
        public bool IsFavorite { get; set; }
        public int FavoriteCount { get; set; }
    }
}
