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
using Microsoft.AspNetCore.Identity;
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
        private readonly UserManager<User> userManager;

        public PastaController(IPastaRepository pastaRepo, IMapper mapper, UserManager<User> userManager)
        {
            this.pastaRepo = pastaRepo;
            this.mapper = mapper;
            this.userManager = userManager;
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

        [HttpPost("favorite/{pastaId}")]
        public async Task<IActionResult> ToggleFavorite(long pastaId)
        {
            var pasta = pastaRepo.Get(pastaId);

            if (pasta == null)
            {
                return NotFound();
            }

            var userName = HttpContext.User.Identity.Name;
            var user = await userManager.FindByNameAsync(userName);

            bool isFavorite = ToggleFavorite(pasta, user);

            await userManager.UpdateAsync(user);

            return Ok(new { isFavorite = isFavorite });
        }

        private bool ToggleFavorite(Pasta pasta, User user)
        {
            bool isFavorite = false;

            if (pasta.FavoritedBy.Contains(user))
            {
                pasta.FavoritedBy.Remove(user);
            }
            else
            {
                pasta.FavoritedBy.Add(user);
                isFavorite = true;
            }

            return isFavorite;
        }
    }
}
