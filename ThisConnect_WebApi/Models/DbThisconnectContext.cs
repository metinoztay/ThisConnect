using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ThisConnect_WebApi.Models;

public partial class DbThisconnectContext : DbContext
{
    public DbThisconnectContext()
    {
    }

    public DbThisconnectContext(DbContextOptions<DbThisconnectContext> options)
        : base(options)
    {
    }

    public virtual DbSet<TblAttachment> TblAttachments { get; set; }

    public virtual DbSet<TblChatRoom> TblChatRooms { get; set; }

    public virtual DbSet<TblChatRoomParticipant> TblChatRoomParticipants { get; set; }

    public virtual DbSet<TblMessage> TblMessages { get; set; }

    public virtual DbSet<TblQr> TblQrs { get; set; }

    public virtual DbSet<TblUser> TblUsers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Database=DB_THISCONNECT;Username=postgres;Password=as");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasPostgresExtension("uuid-ossp");

        modelBuilder.Entity<TblAttachment>(entity =>
        {
            entity.HasKey(e => e.AttachmentId).HasName("TBL_ATTACHMENTS_pkey");

            entity.ToTable("TBL_ATTACHMENTS");

            entity.Property(e => e.AttachmentId)
                .HasMaxLength(40)
                .HasDefaultValueSql("uuid_generate_v4()")
                .HasColumnName("ATTACHMENT_ID");
            entity.Property(e => e.AttachmentUrl)
                .HasMaxLength(255)
                .HasColumnName("ATTACHMENT_URL");
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .HasColumnName("TYPE");
        });

        modelBuilder.Entity<TblChatRoom>(entity =>
        {
            entity.HasKey(e => e.ChatRoomId).HasName("TBL_CHAT_ROOMS_pkey");

            entity.ToTable("TBL_CHAT_ROOMS");

            entity.Property(e => e.ChatRoomId)
                .HasMaxLength(40)
                .HasColumnName("CHAT_ROOM_ID");
            entity.Property(e => e.CreatedAt)
                .HasMaxLength(19)
                .HasColumnName("CREATED_AT");
            entity.Property(e => e.LastMessageId)
                .HasMaxLength(40)
                .HasColumnName("LAST_MESSAGE_ID");

            entity.HasOne(d => d.LastMessage).WithMany(p => p.TblChatRooms)
                .HasForeignKey(d => d.LastMessageId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_CHAT_ROOMS_LAST_MESSAGE_ID_fkey");
        });

        modelBuilder.Entity<TblChatRoomParticipant>(entity =>
        {
            entity.HasKey(e => e.ChatRoomParticipantId).HasName("TBL_CHAT_ROOM_PARTICIPANTS_pkey");

            entity.ToTable("TBL_CHAT_ROOM_PARTICIPANTS");

            entity.Property(e => e.ChatRoomParticipantId)
                .HasMaxLength(40)
                .HasDefaultValueSql("uuid_generate_v4()")
                .HasColumnName("CHAT_ROOM_PARTICIPANT_ID");
            entity.Property(e => e.ChatRoomId)
                .HasMaxLength(40)
                .HasColumnName("CHAT_ROOM_ID");
            entity.Property(e => e.ParticipantId)
                .HasMaxLength(40)
                .HasColumnName("PARTICIPANT_ID");

            entity.HasOne(d => d.ChatRoom).WithMany(p => p.TblChatRoomParticipants)
                .HasForeignKey(d => d.ChatRoomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_CHAT_ROOM_PARTICIPANTS_CHAT_ROOM_ID_fkey");

            entity.HasOne(d => d.ChatRoomParticipant).WithOne(p => p.TblChatRoomParticipant)
                .HasForeignKey<TblChatRoomParticipant>(d => d.ChatRoomParticipantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_CHAT_ROOM_PARTICIPANTS_CHAT_ROOM_PARTICIPANT_ID_fkey");
        });

        modelBuilder.Entity<TblMessage>(entity =>
        {
            entity.HasKey(e => e.MessageId).HasName("TBL_MESSAGES_pkey");

            entity.ToTable("TBL_MESSAGES");

            entity.Property(e => e.MessageId)
                .HasMaxLength(40)
                .HasDefaultValueSql("uuid_generate_v4()")
                .HasColumnName("MESSAGE_ID");
            entity.Property(e => e.AttachmentId)
                .HasMaxLength(40)
                .HasColumnName("ATTACHMENT_ID");
            entity.Property(e => e.ChatRoomId)
                .HasMaxLength(40)
                .HasColumnName("CHAT_ROOM_ID");
            entity.Property(e => e.Content)
                .HasMaxLength(500)
                .HasColumnName("CONTENT");
            entity.Property(e => e.CreatedAt)
                .HasMaxLength(19)
                .HasColumnName("CREATED_AT");
            entity.Property(e => e.ReadedAt)
                .HasMaxLength(19)
                .HasColumnName("READED_AT");
            entity.Property(e => e.RecieverUserId)
                .HasMaxLength(40)
                .HasColumnName("RECIEVER_USER_ID");
            entity.Property(e => e.SenderUserId)
                .HasMaxLength(40)
                .HasColumnName("SENDER_USER_ID");

            entity.HasOne(d => d.Attachment).WithMany(p => p.TblMessages)
                .HasForeignKey(d => d.AttachmentId)
                .HasConstraintName("TBL_MESSAGES_ATTACHMENT_ID_fkey");

            entity.HasOne(d => d.ChatRoom).WithMany(p => p.TblMessages)
                .HasForeignKey(d => d.ChatRoomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_MESSAGES_CHAT_ROOM_ID_fkey");

            entity.HasOne(d => d.RecieverUser).WithMany(p => p.TblMessageRecieverUsers)
                .HasForeignKey(d => d.RecieverUserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_MESSAGES_RECIEVER_USER_ID_fkey");

            entity.HasOne(d => d.SenderUser).WithMany(p => p.TblMessageSenderUsers)
                .HasForeignKey(d => d.SenderUserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_MESSAGES_SENDER_USER_ID_fkey");
        });

        modelBuilder.Entity<TblQr>(entity =>
        {
            entity.HasKey(e => e.QrId).HasName("TBL_QRS_pkey");

            entity.ToTable("TBL_QRS");

            entity.Property(e => e.QrId)
                .HasMaxLength(40)
                .HasDefaultValueSql("uuid_generate_v4()")
                .HasColumnName("QR_ID");
            entity.Property(e => e.CreatedAt)
                .HasMaxLength(19)
                .IsFixedLength()
                .HasColumnName("CREATED_AT");
            entity.Property(e => e.IsActive).HasColumnName("IS_ACTIVE");
            entity.Property(e => e.Note)
                .HasMaxLength(255)
                .HasColumnName("NOTE");
            entity.Property(e => e.ShareEmail).HasColumnName("SHARE_EMAIL");
            entity.Property(e => e.ShareNote).HasColumnName("SHARE_NOTE");
            entity.Property(e => e.SharePhone).HasColumnName("SHARE_PHONE");
            entity.Property(e => e.Title)
                .HasMaxLength(100)
                .HasColumnName("TITLE");
            entity.Property(e => e.UpdatedAt)
                .HasMaxLength(19)
                .IsFixedLength()
                .HasColumnName("UPDATED_AT");
            entity.Property(e => e.UserId)
                .HasMaxLength(40)
                .HasColumnName("USER_ID");

            entity.HasOne(d => d.User).WithMany(p => p.TblQrs)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("TBL_QRS_USER_ID_fkey");
        });

        modelBuilder.Entity<TblUser>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("TBL_USERS_pkey");

            entity.ToTable("TBL_USERS");

            entity.Property(e => e.UserId)
                .HasMaxLength(40)
                .HasDefaultValueSql("uuid_generate_v4()")
                .HasColumnName("USER_ID");
            entity.Property(e => e.AvatarUrl)
                .HasMaxLength(255)
                .HasColumnName("AVATAR_URL");
            entity.Property(e => e.CreatedAt)
                .HasMaxLength(19)
                .IsFixedLength()
                .HasColumnName("CREATED_AT");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("EMAIL");
            entity.Property(e => e.LastSeenAt)
                .HasMaxLength(19)
                .IsFixedLength()
                .HasColumnName("LAST_SEEN_AT");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("NAME");
            entity.Property(e => e.Phone)
                .HasMaxLength(10)
                .IsFixedLength()
                .HasColumnName("PHONE");
            entity.Property(e => e.Surname)
                .HasMaxLength(50)
                .HasColumnName("SURNAME");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .HasColumnName("TITLE");
            entity.Property(e => e.UpdatedAt)
                .HasMaxLength(19)
                .IsFixedLength()
                .HasColumnName("UPDATED_AT");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
