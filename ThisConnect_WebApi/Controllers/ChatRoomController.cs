using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using ThisConnect_WebApi.Models;

namespace ThisConnect_WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatRoomController : ControllerBase
    {
        private readonly DbThisconnectContext _context;

        public ChatRoomController(DbThisconnectContext context)
        {
            _context = context;
        }

        [HttpPost("createChatRoom")]
        public async Task<IActionResult> CreateChatRoom([FromBody] TempChatRoom chatRoom)
        {
            var existingChatRoom = await _context.TblChatRooms
                .FirstOrDefaultAsync(cr =>
                    (cr.Participant1Id == chatRoom.Participant1Id && cr.Participant2Id == chatRoom.Participant2Id) ||
                    (cr.Participant1Id == chatRoom.Participant2Id && cr.Participant2Id == chatRoom.Participant1Id));

            if (existingChatRoom != null)
            {
                return Conflict("Chat room already exists for these participants.");
            }

            TblChatRoom tblChatRoom = new TblChatRoom
            {
                Participant1Id = chatRoom.Participant1Id,
                Participant2Id = chatRoom.Participant2Id,
                LastMessageId = null,
                CreatedAt = DateTime.Now.ToString()
            };

            await _context.TblChatRooms.AddAsync(tblChatRoom);
            await _context.SaveChangesAsync();

            return Ok("Chat room created successfully with participants.");
        }


        [HttpPost("findChatRoom")]
        public async Task<IActionResult> FindChatRoom([FromBody] TempChatRoom chatRoom)
        {
            var existingChatRoom = await _context.TblChatRooms
                .FirstOrDefaultAsync(cr =>
                    (cr.Participant1Id == chatRoom.Participant1Id && cr.Participant2Id == chatRoom.Participant2Id) ||
                    (cr.Participant1Id == chatRoom.Participant2Id && cr.Participant2Id == chatRoom.Participant1Id));
            

            return Ok(existingChatRoom);
        }

        [HttpGet("getChatRoomsByParticipant")]
        public async Task<IActionResult> GetChatRoomsByParticipant(string participantId)
        {
            var chatRooms = await _context.TblChatRooms
                .Where(cr => cr.Participant1Id == participantId || cr.Participant2Id == participantId)
                .ToListAsync();

            if (chatRooms == null || chatRooms.Count == 0)
            {
                return NotFound("No chat rooms found for this participant.");
            }

            return Ok(chatRooms);
        }

    }
}
