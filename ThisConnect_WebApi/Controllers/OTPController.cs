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

        [HttpPost("createotp")]
        public async Task<IActionResult> CreateOTP(String phone)
        {
            try
            {
                TblOtp? Otp = _context.TblOtps.FirstOrDefault(o => o.Phone == phone);

               

                if (Otp == null)
                {
                    Otp = new TblOtp();
                    Otp.Phone = phone;
                    Otp.OtpValue = phone.Substring(0, 6);
                    Otp.ExpirationTime = DateTime.Now.AddMinutes(5).ToString();
                    await _context.TblOtps.AddAsync(Otp);
                }
                else {
                    Otp.Phone = phone;
                    Otp.OtpValue = phone.Substring(0, 6);
                    Otp.ExpirationTime = DateTime.Now.AddMinutes(5).ToString();
                    _context.TblOtps.Update(Otp);
                }

                await _context.SaveChangesAsync();           
                


            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }

            return NoContent();
        }

    }
}
