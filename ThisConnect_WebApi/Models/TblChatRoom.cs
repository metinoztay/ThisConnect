using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblChatRoom
{
    public string ChatRoomId { get; set; } = null!;

    public string LastMessageId { get; set; } = null!;

    public string CreatedAt { get; set; } = null!;

    public virtual TblMessage LastMessage { get; set; } = null!;

    public virtual ICollection<TblChatRoomParticipant> TblChatRoomParticipants { get; set; } = new List<TblChatRoomParticipant>();

    public virtual ICollection<TblMessage> TblMessages { get; set; } = new List<TblMessage>();
}
