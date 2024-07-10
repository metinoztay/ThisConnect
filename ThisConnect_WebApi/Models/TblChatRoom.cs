using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblChatRoom
{
    public string ChatRoomId { get; set; } = null!;

    public string Participant1Id { get; set; } = null!;

    public string Participant2Id { get; set; } = null!;

    public string? LastMessageId { get; set; }

    public string CreatedAt { get; set; } = null!;

    public virtual TblMessage? LastMessage { get; set; }

    public virtual TblUser Participant1 { get; set; } = null!;

    public virtual TblUser Participant2 { get; set; } = null!;

    public virtual ICollection<TblMessage> TblMessages { get; set; } = new List<TblMessage>();
}
