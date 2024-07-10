using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThisConnect_WebApi.Models;

namespace ThisConnect_WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OTPController : ControllerBase
    {
        private readonly DbThisconnectContext _context;

        public OTPController(DbThisconnectContext context)
        {
            _context = context;
        }

        [HttpPost("otpverification")]
        public async Task<ActionResult<TblUser>> OTPVerification([FromBody] TempOTP otp)
        {
            try
            {
                TblOtp tblOtp = await _context.TblOtps.FirstOrDefaultAsync(o => o.Phone == otp.Phone && o.OtpValue == otp.OtpValue);
                TblUser tempuser = new TblUser();
                if (tblOtp == null || DateTime.Parse(tblOtp.ExpirationTime) < DateTime.Now)
                {                   
                    return tempuser;
                }

                tempuser = await _context.TblUsers.FirstOrDefaultAsync(u => u.Phone == otp.Phone);

                return tempuser;


            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
