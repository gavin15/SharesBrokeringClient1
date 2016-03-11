using SharesBrokeringEntities;
using SharesBrokeringService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SharesBrokeringClient.Models
{
    public class SharesModel
    {
        public int companyId { get; set; }
        public string compapnyName { get; set; }
        public int availableShares { get; set; }
        public int noOfShares { get; set; }
        public string companySymbol { get; set; }
        public Price sharePrice;

        public List<SharesModel> companyList { get; set; }

        SharesAcquisitionService sharesAcquisitionService;
        public SharesModel()
        {
            companyList = new List<SharesModel>();
            sharesAcquisitionService = new SharesAcquisitionService();
        }

        /// <summary>
        /// List the company shares that are on offer.
        /// </summary>
        /// <returns></returns>
        public List<SharesModel> List()
        {
            CompanyShares companies = sharesAcquisitionService.List();
            MapCompany(companies);
            return companyList;
        }


        /// <summary>
        /// List the comapany shares purchased by a user.
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<SharesModel> ListUserShares(string userName)
        {
            CompanyShares companies = sharesAcquisitionService.ListUserShares(userName);
            foreach (var item in companies.company)
            {
                SharesModel company = new SharesModel();
                company.compapnyName = item.company_name;
                company.companySymbol = item.company_symbol;
                company.availableShares = item.available_shares;
                companyList.Add(company);
            }
            return companyList;
        }

        /// <summary>
        /// Map the entities to the model.
        /// </summary>
        /// <param name="companies"></param>
        private void MapCompany(CompanyShares companies)
        {
            foreach (var item in companies.company)
            {
                SharesModel company = new SharesModel();
                //company.companyId = 0;
                company.companySymbol = item.company_symbol;
                company.compapnyName = item.company_name;
                company.availableShares = item.available_shares;
                Price price = new Price();
                price.currency = item.share_price.currency;
                price.lastUpdate = item.share_price.last_update;
                price.value = item.share_price.value;
                company.sharePrice = price;
                companyList.Add(company);
            }
        }


        /// <summary>
        /// Buy shares from the market.
        /// </summary>
        /// <param name="userName">logged in user</param>
        /// <param name="symbol">company symbol of the purchased share</param>
        /// <param name="quantity">number of shares purchased.</param>
        /// <returns></returns>
        public List<SharesModel> BuyShares(string userName, string symbol, int quantity)
        {
            var companies = sharesAcquisitionService.Buy(userName, symbol, quantity);
            MapCompany(companies);
            return companyList;
        }

        /// <summary>
        /// Sell shares back to the market.
        /// </summary>
        /// <param name="userName">logged in user</param>
        /// <param name="symbol">symbol of the company to be sold</param>
        /// <param name="quantity">number of shares sold.</param>
        /// <returns></returns>
        public List<SharesModel> SellShares(string userName, string symbol, int quantity)
        {
            var companies = sharesAcquisitionService.Sell(userName, symbol, quantity);
            foreach (var item in companies.company)
            {
                SharesModel company = new SharesModel();
                company.compapnyName = item.company_name;
                company.companySymbol = item.company_symbol;
                company.availableShares = item.available_shares;
                companyList.Add(company);
            }
            return companyList;
        }

        /// <summary>
        /// get total amount of the share to be purchased.
        /// </summary>
        /// <param name="shares">number of shares</param>
        /// <param name="value">value per share</param>
        /// <param name="currency">currency of the company</param>
        /// <param name="userCurrency">currency of the user</param>
        /// <returns></returns>
        public string GetTotal(string shares, string value, string currency, string userCurrency)
        {
            var total = sharesAcquisitionService.GetTotal(shares, value, currency, userCurrency);
            return total;
        }


        /// <summary>
        /// Get available amount in the user account.
        /// </summary>
        /// <param name="userName">logged in user</param>
        /// <returns></returns>
        public string GetUserAmount(string userName)
        {
            var total = sharesAcquisitionService.GetUserAmount(userName);
            return total;
        }


        /// <summary>
        /// Check if user exists.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool CheckUserExists(string userName, string password)
        {
            return sharesAcquisitionService.CheckUserExists(userName, password);
        }

        /// <summary>
        /// Get currency of the user.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public string GetUserCurrency(string userName, string password)
        {
            return sharesAcquisitionService.GetUserCurrency(userName, password);
        }

        /// <summary>
        /// List of company shares that are purchased by a user.
        /// </summary>
        /// <returns></returns>
        public List<SharesModel> Sell()
        {
            CompanyShares companies = sharesAcquisitionService.List();
            MapCompany(companies);
            return companyList;


        }

        public class Price
        {
            public string currency { get; set; }
            public float value { get; set; }
            public string lastUpdate { get; set; }
        }
    }
}