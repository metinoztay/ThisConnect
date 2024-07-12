using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore.Diagnostics.Internal;
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
        public async Task JoinRoom(string chatRoomId, string? lastmessageId)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, chatRoomId);            
        }


        public async Task LeaveRoom(string chatRoomId)
        {
            
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, chatRoomId);
            TblChatRoom? tblChatRoom = _context.TblChatRooms.FirstOrDefault(c => c.ChatRoomId == chatRoomId);
            if (tblChatRoom != null && tblChatRoom.LastMessageId == null)
            {
                _context.TblChatRooms.Remove(tblChatRoom);
                await _context.SaveChangesAsync();
            }
        }

        public async Task SendMessage(TempMessage tempmessage)
        {
            await Clients.Group(tempmessage.ChatRoomId).SendAsync("ReceiveMessage", tempmessage);

            TblMessage message = new TblMessage();
            message.ChatRoomId = tempmessage.ChatRoomId;
            message.SenderUserId = tempmessage.SenderUserId;
            message.RecieverUserId = tempmessage.RecieverUserId;
            message.AttachmentId = null;
            message.Content = tempmessage.Content;
            message.CreatedAt = DateTime.Now.ToString(); 
            message.ReadedAt = null;

            try
            {
                await _context.TblMessages.AddAsync(message);
                await _context.SaveChangesAsync(); 
                TblChatRoom? chatRoom = new TblChatRoom();
                chatRoom = _context.TblChatRooms.FirstOrDefault(c => c.ChatRoomId == message.ChatRoomId);
                chatRoom.LastMessageId = message.MessageId;
                _context.TblChatRooms.Update(chatRoom);
                _context.SaveChanges();

            }
            catch (Exception ex)
            {
                Console.WriteLine($"Veritabanı mesaj ekleme işlemi sırasında hata oluştu: {ex.Message}");
                throw; 
            }
        }
    }
}
