using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblChatRoomParticipant
{
    public string ChatRoomParticipantId { get; set; } = null!;

    public string ParticipantId { get; set; } = null!;

    public string ChatRoomId { get; set; } = null!;

    public virtual TblChatRoom ChatRoom { get; set; } = null!;

    public virtual TblUser ChatRoomParticipant { get; set; } = null!;
}
