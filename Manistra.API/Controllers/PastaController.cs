using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Manistra.API.Authentication;
using Manistra.API.DataAccess;
using Manistra.API.Entities;
using Manistra.API.Models.Pasta;
using Manistra.API.ResourceParameters;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Manistra.API.Controllers
{
    [Authorize]
    [Route("api/pasta")]
    [ApiController]
    public class PastaController : ControllerBase
    {
        private readonly IPastaRepository pastaRepo;
        private readonly IMapper mapper;
        public PastaController(IPastaRepository pastaRepo, IMapper mapper)
        {
            this.pastaRepo = pastaRepo;
            this.mapper = mapper;
        }

        [HttpGet()]
        public ActionResult<IEnumerable<PastaDto>> GetPastas(
            [FromQuery] PastaResourceParameters parameters)
        {
            var pastas = pastaRepo.GetAll(parameters);
            var pastasDto = mapper.Map<IEnumerable<PastaDto>>(pastas);

            return Ok(pastasDto);
        }

        [HttpGet("{id}", Name = "GetPasta")]
        public ActionResult<PastaDto> GetPasta(long id)
        {
            var pasta = pastaRepo.Get(id);

            if (pasta == null)
            {
                return NotFound();
            }

            var pastaDto = mapper.Map<PastaDto>(pasta);

            return Ok(pastaDto);
        }

        [HttpPost]
        public ActionResult<PastaDto> CreatePasta(PastaForCreationDto pasta)
        {
            var pastaEntity = mapper.Map<Pasta>(pasta);
            pastaEntity.DateCreated = DateTime.Now;

            pastaRepo.Add(pastaEntity);

            var pastaDto = mapper.Map<PastaDto>(pastaEntity);

            return CreatedAtRoute(
               "GetPasta",
               new { id = pastaDto.Id },
               pastaDto);
        }
    }
}
