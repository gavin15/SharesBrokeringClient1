using SharesBrokeringEntities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharesBrokeringService
{
    public class SharesAcquisitionService
    {
        SharesAcquisitionProxy proxy = new SharesAcquisitionProxy();
        CompanyShares companies = new CompanyShares();

        /// <summary>
        /// Fetched the list of companies that has shares on offer.
        /// </summary>
        /// <returns> List of companies</returns>
        public CompanyShares List()
        {
            try
            {
                var companyList = proxy.ListCompanies();
                MapCompany(companyList);
            }
            catch (Exception ex)
            {
                // Logging. To be implemented.
            }

            return companies;
        }

        /// <summary>
        /// List the company shares that are purchased by a user.
        /// </summary>
        /// <param name="userName">Logged in user</param>
        /// <returns>List of companies.</returns>
        public CompanyShares ListUserShares(string userName)
        {
            try
            {
                var companyList = proxy.ListUserShares(userName);
                foreach (var item in companyList)
                {
                    Company company = new Company();
                    company.company_name = item.companyName;
                    company.company_symbol = item.companySymbol;
                    company.available_shares = item.sharesPurchased;
                    companies.company.Add(company);
                }
            }
            catch (Exception ex)
            {
                // Logging. To be implemented.
            }

            return companies;
        }

        /// <summary>
        /// Buy a share from the market
        /// </summary>
        /// <param name="userName">Logged in user</param>
        /// <param name="symbol">Company Symbol</param>
        /// <param name="quantity">quantity of shares purchased.</param>
        /// <returns></returns>
        public CompanyShares Buy(string userName, string symbol, int quantity)
        {
            try
            {
                var companyList = proxy.BuyShare(symbol, quantity.ToString(), userName);
                MapCompany(companyList);
            }
            catch (Exception ex)
            {
                //Logging. To be implemented.
            }

            return companies;
        }

        /// <summary>
        /// Allows user to sell the shares back to the market.
        /// </summary>
        /// <param name="userName">logged in user</param>
        /// <param name="symbol">company symbol</param>
        /// <param name="quantity">number of shares to be sold</param>
        /// <returns></returns>
        public CompanyShares Sell(string userName, string symbol, int quantity)
        {
            try
            {
                var companyList = proxy.SellShare(userName, symbol, quantity.ToString());
                foreach (var item in companyList)
                {
                    Company company = new Company();
                    company.company_name = item.company_name;
                    company.company_symbol = item.company_symbol;
                    company.available_shares = item.available_shares;
                    companies.company.Add(company);
                }
            }
            catch (Exception ex)
            {
                //Logging. To be implemented.
            }

            return companies;
        }

        /// <summary>
        /// Maps from returned list to the entities.
        /// </summary>
        /// <param name="companyList"></param>
        private void MapCompany(companyType[] companyList)
        {
            foreach (var item in companyList)
            {
                Company company = new Company();
                company.company_name = item.company_name;
                company.company_symbol = item.company_symbol;
                company.available_shares = item.available_shares;
                Price price = new Price();
                price.currency = item.share_price.currency;
                price.value = item.share_price.value;
                price.last_update = item.share_price.last_update;
                company.share_price = price;
                companies.company.Add(company);
            }
        }

        /// <summary>
        /// Fetch the total amount of the purchased shares.
        /// </summary>
        /// <param name="shares">number of shares</param>
        /// <param name="value">value of each share</param>
        /// <param name="currency1">currency of the company</param>
        /// <param name="currency2">currency of the user</param>
        /// <returns></returns>
        public string GetTotal(string shares, string value, string currency1, string currency2)
        {
            var total = string.Empty;
            try
            {
                total = proxy.GetTotal(shares, value, currency1.Trim(), currency2.Trim());
            }
            catch (Exception ex)
            {
                //Logging. To be implemented.
            }

            return total;
        }

        /// <summary>
        /// Fetch the available amount in the user account.
        /// </summary>
        /// <param name="userName">logged in user</param>
        /// <returns>available amount</returns>
        public string GetUserAmount(string userName)
        {
            var total = string.Empty;
            try
            {
                total = proxy.GetUserAmount(userName);
            }
            catch (Exception ex)
            {
                //Logging. To be implemented.
            }

            return total.ToString();
        }

        /// <summary>
        /// Get the list of currencies
        /// </summary>
        /// <returns></returns>
        public List<string> GetCurrencies()
        {
            try
            {
                var currencyCodes = proxy.GetCurrencyCodes();
                return currencyCodes.ToList();
            }
            catch (Exception ex)
            {
                return null;
                //Logging. To be implemented.
            }

        }

        /// <summary>
        /// Creates a new user.
        /// </summary>
        /// <param name="userName">username</param>
        /// <param name="password">password</param>
        /// <param name="currency">currency of the user</param>
        public void CreateUser(string userName, string password, string currency)
        {
            try
            {
                proxy.CreateUser(userName, password, currency);
            }
            catch (Exception ex)
            {
                //Logging. To be implemented.
            }

        }

        /// <summary>
        /// Get the currency of the user.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public string GetUserCurrency(string userName, string password)
        {
            try
            {
                var currency = proxy.GetUserCurrency(userName, password);
                return currency;
            }
            catch (Exception ex)
            {
                //Logging. TO be implemented.
                return null;
            }
        }

        /// <summary>
        /// Check if the user exist.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool CheckUserExists(string userName, string password)
        {
            try
            {
                return proxy.CheckUserExists(userName, password);
            }
            catch (Exception)
            {
                return false;
                //Logging. To be implemented.
            }

        }
    }
}
