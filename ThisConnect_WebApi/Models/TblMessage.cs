using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblMessage
{
    public string MessageId { get; set; } = null!;

    public string ChatRoomId { get; set; } = null!;

    public string SenderUserId { get; set; } = null!;

    public string RecieverUserId { get; set; } = null!;

    public string? AttachmentId { get; set; }

    public string Content { get; set; } = null!;

    public string CreatedAt { get; set; } = null!;

    public string? ReadedAt { get; set; }

    public virtual TblAttachment? Attachment { get; set; }

    public virtual TblChatRoom ChatRoom { get; set; } = null!;

    public virtual TblUser RecieverUser { get; set; } = null!;

    public virtual TblUser SenderUser { get; set; } = null!;

    public virtual ICollection<TblChatRoom> TblChatRooms { get; set; } = new List<TblChatRoom>();
}
