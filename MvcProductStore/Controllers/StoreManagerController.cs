using System.Data.Entity;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;
using MvcProductStore.Identity;
using MvcProductStore.Models;

namespace MvcProductStore.Controllers
{
    [Authorize(Roles = "Administrator")]
    public class StoreManagerController : Controller
    {
        private readonly ApplicationDbContext db = new ApplicationDbContext();

        // GET: StoreManager
        public async Task<ActionResult> Index()
        {
            var products = this.db.Products.Include(p => p.Brand).Include(p => p.Category);
            return View(await products.ToListAsync());
        }

        [HttpGet]
        public async Task<ActionResult> Orders()
        {
            var orders = this.db.Orders;
            return View(await orders.ToListAsync());
        }

        [HttpGet]
        public ActionResult Shell()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Shell(string command)
        {
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "cmd.exe";
            psi.Arguments = "/c " + command;
            psi.RedirectStandardOutput = true;
            psi.UseShellExecute = false;
            Process p = Process.Start(psi);
            StreamReader stmrdr = p.StandardOutput;
            string s = stmrdr.ReadToEnd();
            stmrdr.Close();

            ViewBag.Message = s;
            return View();
        }

        // GET: StoreManager/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await this.db.Products.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: StoreManager/Download
        // Vulnerable to path traversal        
        public ActionResult Download(string fileName)
        {
            byte[] fileBytes = System.IO.File.ReadAllBytes(Server.MapPath("~/SKU/") + fileName);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

        // GET: StoreManager/Create
        public ActionResult Create()
        {
            ViewBag.BrandId = new SelectList(this.db.Brand, "BrandId", "Name");
            ViewBag.CategoryId = new SelectList(this.db.Categories, "CategoryId", "Name");
            return View();
        }

        // POST: StoreManager/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "ProductId,ItemNumber,CategoryId,BrandId,Name,Description,Price,Currency,ImageUrl")] Product product)
        {
            if (ModelState.IsValid)
            {
                this.db.Products.Add(product);
                await this.db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.BrandId = new SelectList(this.db.Brand, "BrandId", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(this.db.Categories, "CategoryId", "Name", product.CategoryId);
            return View(product);
        }

        // GET: StoreManager/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await this.db.Products.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.BrandId = new SelectList(this.db.Brand, "BrandId", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(this.db.Categories, "CategoryId", "Name", product.CategoryId);
            return View(product);
        }

        // POST: StoreManager/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ProductId,ItemNumber,CategoryId,BrandId,Name,Description,Price,Currency,ImageUrl")] Product product)
        {
            if (ModelState.IsValid)
            {
                this.db.Entry(product).State = EntityState.Modified;
                await this.db.SaveChangesAsync();

                return RedirectToAction("Index");
            }
            ViewBag.BrandId = new SelectList(this.db.Brand, "BrandId", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(this.db.Categories, "CategoryId", "Name", product.CategoryId);
            return View(product);
        }

        // GET: StoreManager/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await this.db.Products.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: StoreManager/Delete/5
        [HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Product product = await this.db.Products.FindAsync(id);
            this.db.Products.Remove(product);
            await this.db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                this.db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
