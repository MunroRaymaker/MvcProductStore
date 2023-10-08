using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace MvcProductStore.Identity
{
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
                    Email = "admin@runnershop.com",
                    UserName = "admin@runnershop.com",
                    EmailConfirmed = true,
                    LockoutEnabled = false
                }, "123qwe");
                var admin = um.FindByName("admin@runnershop.com");
                AddUserToRole(admin.Id, "Administrator");

                um.Create(new ApplicationUser
                {
                    Email = "bob@runnershop.com",
                    UserName = "bob@runnershop.com",
                    EmailConfirmed = true,
                    LockoutEnabled = false,
                }, "SecureP@ssword1234");
                var su = um.FindByName("bob@runnershop.com");
                AddUserToRole(su.Id, "SuperUser");
            }
        }
    }
}