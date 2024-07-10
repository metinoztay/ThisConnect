using Microsoft.AspNetCore.SignalR;
using ThisConnect_WebApi.Models;
using static NpgsqlTypes.NpgsqlTsVector;

namespace ThisConnect_WebApi.Hubs
{
    public class ChatHub:Hub
    {
        private readonly DbThisconnectContext _context;

        public ChatHub(DbThisconnectContext context)
        {
            _context = context;
        }
        public async Task JoinRoom(string chatRoomId)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, chatRoomId);
        }

        public async Task LeaveRoom(string chatRoomId)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, chatRoomId);
        }

        public async Task SendMessage(TempMessage tempmessage)
        {
            await Clients.Group(tempmessage.ChatRoomId).SendAsync("ReceiveMessage", tempmessage);
            TblMessage message = new TblMessage();
            message.ChatRoomId = tempmessage.ChatRoomId;
            message.SenderUserId = tempmessage.SenderUserId;
            message.RecieverUserId = tempmessage.RecieverUserId;
            message.AttachmentId = tempmessage.AttachmentId;
            message.Content = tempmessage.Content;
            message.CreatedAt = DateTime.Now.ToString();
            message.ReadedAt = null;

            _context.TblMessages.AddAsync(message);
            _context.SaveChanges();

        }




       
    }
}
