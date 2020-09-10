using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Manistra.API.DataAccess;
using Manistra.API.Entities;
using Manistra.API.Models.Pasta;
using Manistra.API.ResourceParameters;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Manistra.API.Controllers
{
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
    }
}
