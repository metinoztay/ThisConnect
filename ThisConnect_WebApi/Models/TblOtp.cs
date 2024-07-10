using System;
using System.Collections.Generic;

namespace ThisConnect_WebApi.Models;

public partial class TblOtp
{
    public string OtpId { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string OtpValue { get; set; } = null!;

    public string ExpirationTime { get; set; } = null!;
}
