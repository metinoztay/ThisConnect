using System;

namespace ThisConnect_WebApi.Models
{
    public class MessageModel
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string MessageText { get; set; }
        public DateTime CreateDate { get; set; }
    }
}