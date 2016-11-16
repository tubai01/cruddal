using CMS.Models;
using CMS.Repository;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace CMS.Controllers
{
    public class CMSController : Controller
    {
        PagesRepository repository = new PagesRepository();

        public ActionResult Index()
        {
            return View(repository.getPages());
        }
        [HttpPost]
        public ActionResult Index(string PageName, string Top, string Header, string Footer, string Middle, string Bottom)
        {
            Pages objPage = new Pages();
            objPage.PAGENAME = PageName;
            List<Contents> lstContents = new List<Contents>();
            Contents objContents = new Contents();
            objContents.TOP = Top;
            objContents.MIDDLE = Middle;
            objContents.HEADER = Header;
            objContents.BOTTOM = Bottom;
            objContents.FOOTER = Footer;
            lstContents.Add(objContents);
            objPage.PageContents = lstContents;
            repository.CreateNewPages(objPage);

            return View("Index", repository.getPages());
        }
        public ActionResult PageContent(long id)
        {
            Contents obj = repository.getPagecontents().Where(m => m.PAGEID == id).FirstOrDefault();
            return View(obj);
        }
    }
}