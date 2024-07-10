namespace ThisConnect_WebApi.Models
{
    public class TempUser
    {

        public string? UserId { get; set; }

        public string Phone { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string Title { get; set; } = null!;

        public string Name { get; set; } = null!;

        public string Surname { get; set; } = null!;

        public string? AvatarUrl { get; set; }

        public string CreatedAt { get; set; } = null!;

        public string? UpdatedAt { get; set; }

        public string LastSeenAt { get; set; } = null!;
    }
}
