using Microsoft.AspNetCore.Mvc;
using ThisConnect_WebApi.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Xml;

[Route("api/[controller]")]
[ApiController]
public class MyEntitiesController : ControllerBase
{
	private readonly DbThisconnectContext _context;

	public MyEntitiesController(DbThisconnectContext context)
	{
		_context = context;
	}

	[HttpGet]
	public async Task<ActionResult<IEnumerable<TblQr>>> GetMyEntities()
	{
		return await _context.TblQrs.ToListAsync();
	}

	[HttpGet("{id}")]
	public async Task<ActionResult<TblQr>> GetMyEntity(string id)
	{
		var myEntity = await _context.TblQrs.FindAsync(id);

		if (myEntity == null)
		{
			return NotFound();
		}

		return myEntity;
	}

	[HttpPost]
	public async Task<ActionResult<TblQr>> PostMyEntity(TblQr myEntity)
	{
		_context.TblQrs.Add(myEntity);
		await _context.SaveChangesAsync();

		return CreatedAtAction("GetMyEntity", new { id = myEntity.QrId }, myEntity);
	}
}
