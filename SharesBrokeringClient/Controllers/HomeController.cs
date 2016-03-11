using SharesBrokeringClient.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SharesBrokeringClient.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Gavin Shares Brokering";
            return View();
        }

        [HttpPost]
        public ActionResult Buy(SharesModel model)
        {
            if (!model.CheckUserExists(User.Identity.Name,""))
            {
                model.BuyShares(User.Identity.Name, model.companySymbol, model.noOfShares);
                return RedirectToAction("List", model);
            }
            else
            {
                TempData["LoginError"] = "Please login to buy shares.";
                return RedirectToAction("List");
            }      
        }

        public ActionResult List()
        {
            var test = User.Identity.Name;
            SharesModel sharesModel = new SharesModel();
            sharesModel.List();
            return View(sharesModel);
        }

        public ActionResult Sell()
        {
            var test = User.Identity.Name;
            SharesModel sharesModel = new SharesModel();
            sharesModel.ListUserShares(User.Identity.Name);
            return View(sharesModel);
        }

        [HttpPost]
        public ActionResult Sell(SharesModel model)
        {
            if (!model.CheckUserExists(User.Identity.Name, ""))
            {
                model.SellShares(User.Identity.Name, model.companySymbol, model.noOfShares);
                return RedirectToAction("Sell", model);
            }
            {
                TempData["LoginError"] = "Please login to sell shares.";
                return RedirectToAction("List");
            }            
        }

        public string GetTotal(string shares, string price, string currency)
        {
            SharesModel sharesModel = new SharesModel();
            var total = sharesModel.GetTotal(shares.Trim(), price.Trim(), currency,sharesModel.GetUserCurrency(User.Identity.Name,""));
            return total;
        }

        public string GetUserAmount()
        {
            SharesModel sharesModel = new SharesModel();
            var total = sharesModel.GetUserAmount(User.Identity.Name);
            return total;
        }
    }
}
