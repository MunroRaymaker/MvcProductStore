using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace MvcProductStore.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit https://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }

    public class IdentityManager
    {
        public bool RoleExists(string name)
        {
            var rm = new RoleManager<IdentityRole>(
                new RoleStore<IdentityRole>(new ApplicationDbContext()));
            return rm.RoleExists(name);
        }

        public bool AddUserToRole(string userId, string roleName)
        {
            var um = new UserManager<ApplicationUser>(
                new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var idResult = um.AddToRole(userId, roleName);
            return idResult.Succeeded;
        }

        public void ClearUserRoles(string userId)
        {
            var um = new UserManager<ApplicationUser>(
                new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var rm = new RoleManager<IdentityRole>(
                new RoleStore<IdentityRole>(new ApplicationDbContext()));
            var user = um.FindById(userId);
            var currentRoles = new List<IdentityUserRole>(user.Roles);
            var activeRoles = rm.Roles;
            foreach (var role in currentRoles)
            {
                var ac = activeRoles.FirstAsync(x => x.Id == role.RoleId).Result;
                um.RemoveFromRole(userId, ac.Name);
            }
        }

        public void CreateSuperUsers()
        {
            var um = new UserManager<ApplicationUser>(
                new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var rm = new RoleManager<IdentityRole>(
                new RoleStore<IdentityRole>(new ApplicationDbContext()));

            string[] roleNames = new[] { "Administrator", "User", "SuperUser" };

            foreach (var roleName in roleNames)
            {
                if (!RoleExists(roleName))
                {
                    var role = new IdentityRole(roleName);
                    rm.Create(role);
                }
            }

            var users = um.Users.ToList();
            if (!users.Any())
            {
                um.Create(new ApplicationUser
                {
                    Email = "admin" + "@runnershop.com",
                    UserName = "admin",
                    EmailConfirmed = true,
                    LockoutEnabled = false                    
                }, "123qwe");
                var admin = um.FindByName("admin");
                AddUserToRole(admin.Id, "Administrator");

                um.Create(new ApplicationUser
                {
                    Email = "bob" + "@runnershop.com",
                    UserName = "bob",
                    EmailConfirmed = true,
                    LockoutEnabled = false,
                }, "SecureP@ssword1234");
                var su = um.FindByName("bob");
                AddUserToRole(su.Id, "SuperUser");
            }
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Database.SetInitializer<ApplicationDbContext>(new ProductStoreInitializer());
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Brand> Brand { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }
    }
}