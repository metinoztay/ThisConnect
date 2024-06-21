using Microsoft.AspNetCore.SignalR;
using ThisConnect_WebApi.Models;
using static NpgsqlTypes.NpgsqlTsVector;

namespace ThisConnect_WebApi.Hubs
{
    public class ChatHub:Hub
    {
		public async Task SendMessage(string UserName, int RandomUserId, string Message)
		{
			deneme();
			MessageModel MessageModel = new MessageModel
			{
				CreateDate = DateTime.Now,
				MessageText = Message,
				UserId = RandomUserId,
				UserName = UserName
			};
			await Clients.All.SendAsync("ReceiveMessage", MessageModel);			
		}

		public async Task JoinUSer(string userName, int userId)
		{
			MessageModel MessageModel = new MessageModel
			{
				CreateDate = DateTime.Now,
				MessageText = userName + " joined chat",
				UserId = 0,
				UserName = "system"
			};
			await Clients.All.SendAsync("ReceiveMessage", MessageModel);
		}

		public async Task deneme()
		{
			try
			{
				using (var db = new DbThisconnectContext())
				{
					var newItem = new TblUser();
					newItem.Phone = "1234567890";
					newItem.Email = "testemail@gmail.com";
					newItem.Title = "Prof";
					newItem.Name = "Metin";
					newItem.Surname = "Öztay";
					newItem.CreatedAt = DateTime.Now.ToString();
					newItem.LastSeenAt = DateTime.Now.ToString();
					db.TblUsers.Add(newItem);
					var count = await db.SaveChangesAsync().ConfigureAwait(false);
					Console.WriteLine("Kaydedilen öğe sayısı: {0}", count);

					foreach (var item in db.TblUsers)
					{
						Console.WriteLine("{0}", item.Name);
					}
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("Bir hata oluştu: {0}", ex.Message);
			}
		}
		

	}
}
