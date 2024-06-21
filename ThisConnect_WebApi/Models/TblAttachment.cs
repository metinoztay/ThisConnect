using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblAttachment
{
    public string AttachmentId { get; set; } = null!;

    public string Type { get; set; } = null!;

    public string AttachmentUrl { get; set; } = null!;

    public virtual ICollection<TblMessage> TblMessages { get; set; } = new List<TblMessage>();
}
