﻿using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WhiteLagoon.Application.Common.Interfaces;
using WhiteLagoon.Application.Common.Utility;
using WhiteLagoon.Domain.Entities;

namespace WhiteLagoon.Infrastructure.Data
{
// esto es para el pull
// esto es para el Merge Branch
    public class DbInitializer : IDbInitializer
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ApplicationDbContext _db;
   
        public DbInitializer( 
            UserManager<ApplicationUser> userManager,
            RoleManager<IdentityRole> roleManager,
            ApplicationDbContext db)
        {
            _roleManager = roleManager;
            _userManager = userManager;
            _db = db;
        }
        public void Initialize()
        {
            try
            {
                if(_db.Database.GetPendingMigrations().Count()>0)
                {
                    _db.Database.Migrate();
                }
                if (!_roleManager.RoleExistsAsync(SD.Role_Admin).GetAwaiter().GetResult())
                {
                    _roleManager.CreateAsync(new IdentityRole(SD.Role_Admin)).Wait();
                    _roleManager.CreateAsync(new IdentityRole(SD.Role_Customer)).Wait();

                    _userManager.CreateAsync(new ApplicationUser
                    {
                        UserName = "masteromnimtv@gmail.com",
                        Email = "masteromnimtv@gmail.com",
                        Name = "Ricardo Mendoza",
                        NormalizedUserName = "MASTEROMNIMTV@GMAIL.COM",
                        NormalizedEmail = "MASTEROMNIMTV@GMAIL.COM",
                        PhoneNumber = "514-813-6032",
                    }, "Gabrielamontiel1974!").GetAwaiter().GetResult();


                    ApplicationUser user = _db.ApplicationUsers.FirstOrDefault(u=>u.Email== "masteromnimtv@gmail.com");
                    _userManager.AddToRoleAsync(user, SD.Role_Admin).GetAwaiter().GetResult();
                }
               

            }
            catch(Exception e)
            {
                throw;
            }
        }
    }
}
