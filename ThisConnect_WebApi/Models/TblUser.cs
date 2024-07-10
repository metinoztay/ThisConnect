using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblUser
{
    public string UserId { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Title { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string Surname { get; set; } = null!;

    public string? AvatarUrl { get; set; }

    public string CreatedAt { get; set; } = null!;

    public string? UpdatedAt { get; set; }

    public string LastSeenAt { get; set; } = null!;

    public virtual ICollection<TblChatRoom> TblChatRoomParticipant1s { get; set; } = new List<TblChatRoom>();

    public virtual ICollection<TblChatRoom> TblChatRoomParticipant2s { get; set; } = new List<TblChatRoom>();

    public virtual ICollection<TblMessage> TblMessageRecieverUsers { get; set; } = new List<TblMessage>();

    public virtual ICollection<TblMessage> TblMessageSenderUsers { get; set; } = new List<TblMessage>();

    public virtual ICollection<TblQr> TblQrs { get; set; } = new List<TblQr>();
}
