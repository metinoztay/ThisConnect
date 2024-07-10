﻿namespace ThisConnect_WebApi.Models
{
    public class TempChatRoom
    {

        public string? ChatRoomId { get; set; }

        public string Participant1Id { get; set; } = null!;

        public string Participant2Id { get; set; } = null!;

        public string? LastMessageId { get; set; }

        public string CreatedAt { get; set; } = null!;
    }
}
