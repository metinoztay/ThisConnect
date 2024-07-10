using Microsoft.AspNetCore.Mvc;
using ThisConnect_WebApi.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Xml;

[Route("api/[controller]")]
[ApiController]
public class QRController : ControllerBase
{
	private readonly DbThisconnectContext _context;

	public QRController(DbThisconnectContext context)
	{
		_context = context;
	}

	[HttpGet]
	public async Task<ActionResult<IEnumerable<TblQr>>> GetMyEntities()
	{
		return await _context.TblQrs.ToListAsync();
	}

	[HttpGet("byqrid/{qrid}")]
	public async Task<ActionResult<TblQr>> GetQRByID(string qrid)
	{
		var myEntity = await _context.TblQrs.FindAsync(qrid);		


		if (myEntity == null)
		{
			return NotFound();
		}

		return myEntity;
	}

    [HttpGet("byuserid/{userid}")]
    public async Task<ActionResult<IEnumerable<TblQr>>> GetQRsByUserID(string userid)
    {
        var user = await _context.TblUsers
            .Include(u => u.TblQrs)
            .FirstOrDefaultAsync(u => u.UserId == userid);

        if (user == null)
        {
            return NotFound();
        }

        return Ok(user.TblQrs);
    }

    [HttpPut("updateqr/{qrid}")]
    public async Task<IActionResult> UpdateQR(string qrid, [FromBody] TempQRModel updatedQr)
    {
        if (qrid != updatedQr.QrId)
        {
            return BadRequest("QR ID eşleşmiyor.");
        }

        var existingQr = await _context.TblQrs.FindAsync(qrid);
        if (existingQr == null)
        {
            return NotFound();
        }

        existingQr.Note = updatedQr.Note;
        existingQr.SharePhone = updatedQr.SharePhone;
        existingQr.ShareEmail = updatedQr.ShareEmail;
        existingQr.ShareNote = updatedQr.ShareNote;
        existingQr.Title = updatedQr.Title;
        existingQr.IsActive = updatedQr.IsActive;
        existingQr.UpdatedAt = DateTime.Now.ToString();

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!QRExists(qrid))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    private bool QRExists(string id)
    {
        return _context.TblQrs.Any(e => e.QrId == id);
    }


    [HttpDelete("deleteqr/{qrId}")]
    public async Task<IActionResult> DeleteQR(string qrId)
    {
        var qrToDelete = _context.TblQrs.FirstOrDefault(qr => qr.QrId == qrId);
        if (qrToDelete == null)
        {
            return NotFound();
        }

        _context.TblQrs.Remove(qrToDelete);
        await _context.SaveChangesAsync();

        return NoContent(); 
    }


    [HttpPost("addqr")]
    public async Task<IActionResult> AddQR([FromBody] TempQRModel newQr)
    {
        try
        {
            var qrToAdd = new TblQr
            {
                QrId = null,
                UserId = newQr.UserId, 
                Title = newQr.Title,
                ShareEmail = newQr.ShareEmail,
                SharePhone = newQr.SharePhone,
                ShareNote = newQr.ShareNote,
                CreatedAt = DateTime.Now.ToString(), 
                UpdatedAt = null, 
                Note = newQr.Note,
                IsActive = newQr.IsActive,
            };

            _context.TblQrs.Add(qrToAdd);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(AddQR), new { qrid = qrToAdd.QrId }, qrToAdd);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }
}
