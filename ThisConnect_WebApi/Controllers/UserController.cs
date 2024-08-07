﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using ThisConnect_WebApi.Models;

namespace ThisConnect_WebApi.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class UserController : ControllerBase
	{
		private readonly DbThisconnectContext _context;

		public UserController(DbThisconnectContext context)
		{
			_context = context;
		}

		[HttpGet]
		public async Task<ActionResult<IEnumerable<TblUser>>> GetMyEntities()
		{
			return await _context.TblUsers.ToListAsync();
		}

		[HttpGet("{id}")]
		public async Task<ActionResult<TblUser>> GetUserById(string id)
		{
			var user = await _context.TblUsers.FindAsync(id);
			if (user == null)
			{
				return NotFound();
			}
			return user;
		}

		[HttpPost]
		public async Task<ActionResult<TblUser>> CreateUser([FromBody] TempUser temp)
		{
			if (temp == null)
			{
				return BadRequest();
			}

			TblUser user = new TblUser();
			user.Phone = temp.Phone;
			user.Email = temp.Email;
			user.Title = temp.Title;
			user.Name = temp.Name;
			user.Surname = temp.Surname;
			user.AvatarUrl = temp.AvatarUrl;
			user.CreatedAt = DateTime.Now.ToString();
			user.UpdatedAt = null;
			user.LastSeenAt = DateTime.Now.ToString();
			
			await _context.TblUsers.AddAsync(user);
			await _context.SaveChangesAsync();

			return Ok(user);
		}



		[HttpPut("{id}")]
		public async Task<IActionResult> UpdateUser(string id, [FromBody] TblUser user)
		{
			if (id != user.UserId || user == null)
			{
				return BadRequest();
			}

			var existingUser = await _context.TblUsers.FindAsync(id);
			if (existingUser == null)
			{
				return NotFound();
			}

			existingUser.Phone = user.Phone;
			existingUser.Email = user.Email;
			existingUser.Title = user.Title;
			existingUser.Name = user.Name;
			existingUser.Surname = user.Surname;
			existingUser.AvatarUrl = user.AvatarUrl;
			existingUser.UpdatedAt = user.UpdatedAt;
			existingUser.LastSeenAt = user.LastSeenAt;

			_context.TblUsers.Update(existingUser);
			await _context.SaveChangesAsync();
			return NoContent();
		}

        [HttpPut("updateLastSeenAt")]
        public async Task<IActionResult> UpdateLastSeenAt(string userId)
        {
            var user = await _context.TblUsers.FindAsync(userId);
			user.LastSeenAt = DateTime.Now.ToString();
			_context.TblUsers.Update(user);
            await _context.SaveChangesAsync();
            return NoContent();
        }


        [HttpDelete("{id}")]
		public async Task<IActionResult> DeleteUser(string id)
		{
			var user = await _context.TblUsers.FindAsync(id);
			if (user == null)
			{
				return NotFound();
			}

			_context.TblUsers.Remove(user);
			await _context.SaveChangesAsync();
			return NoContent();
		}
	}
}
