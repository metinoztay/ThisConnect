using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThisConnect_WebApi.Models;

namespace ThisConnect_WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessagesController : ControllerBase
    {
        private readonly DbThisconnectContext _context;

        public MessagesController(DbThisconnectContext context)
        {
            _context = context;
        }

        //[HttpGet]
        [HttpGet("bychatroomid")]
        public async Task<ActionResult<IEnumerable<TblMessage>>> GetMessages(string chatRoomId, string? lastmessageId)
        {
            List<TempMessage> messages = new List<TempMessage>();
            List<TblMessage> tblMessages;
            

            if (string.IsNullOrEmpty(lastmessageId))
            {
                tblMessages = _context.TblMessages
                    .Where(m => m.ChatRoomId == chatRoomId)
                    .OrderBy(m => m.CreatedAt)
                    .ToList();
            }
            else
            {
                tblMessages = _context.TblMessages
                    .Where(m => m.ChatRoomId == chatRoomId && string.Compare(m.MessageId, lastmessageId) > 0)
                    .OrderBy(m => m.CreatedAt)
                    .ToList();
            }

            foreach (var message in tblMessages)
            {
                TempMessage tempMessage = new TempMessage();
                tempMessage.ChatRoomId = message.ChatRoomId;
                tempMessage.SenderUserId = message.SenderUserId;
                tempMessage.RecieverUserId = message.RecieverUserId;
                tempMessage.AttachmentId = message.AttachmentId;
                tempMessage.Content = message.Content;
                tempMessage.CreatedAt = message.CreatedAt;
                tempMessage.ReadedAt = message.ReadedAt;
                tempMessage.MessageId = message.MessageId;
                messages.Add(tempMessage);

            }

            return Ok(messages);
        }

        [HttpGet("bymessageid")]
        public async Task<ActionResult<IEnumerable<TblMessage>>> GetMessage(string messageId)
        {
            TblMessage? message = new TblMessage();

            if (string.IsNullOrEmpty(messageId))
            {
               
            }
            else
            {
                message = _context.TblMessages
                   .FirstOrDefault(m => m.MessageId == messageId);
            }

           
                TempMessage tempMessage = new TempMessage();
                tempMessage.ChatRoomId = message.ChatRoomId;
                tempMessage.SenderUserId = message.SenderUserId;
                tempMessage.RecieverUserId = message.RecieverUserId;
                tempMessage.AttachmentId = message.AttachmentId;
                tempMessage.Content = message.Content;
                tempMessage.CreatedAt = message.CreatedAt;
                tempMessage.ReadedAt = message.ReadedAt;
                tempMessage.MessageId = message.MessageId;

            

            return Ok(tempMessage);
        }



    }
}
