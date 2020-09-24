using AutoMapper;
using Manistra.API.Entities;
using Manistra.API.Models.Pasta;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Manistra.API.Profiles
{
    public class PastaProfile : Profile
    {
        public PastaProfile()
        {
            CreateMap<Pasta, PastaDto>()
                .ForMember(
                    dest => dest.FavoriteCount,
                    opt => opt.MapFrom(src => src.FavoritedBy.Count));
            CreateMap<PastaForCreationDto, Pasta>();
        }
    }
}
