using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharesBrokeringEntities
{
    public class Company
    {

        private string company_nameField;

        private string company_symbolField;

        private int available_sharesField;

        private Price share_priceField;

        /// <remarks/>
        public string company_name
        {
            get
            {
                return this.company_nameField;
            }
            set
            {
                this.company_nameField = value;
            }
        }

        /// <remarks/>
        public string company_symbol
        {
            get
            {
                return this.company_symbolField;
            }
            set
            {
                this.company_symbolField = value;
            }
        }

        /// <remarks/>
        public int available_shares
        {
            get
            {
                return this.available_sharesField;
            }
            set
            {
                this.available_sharesField = value;
            }
        }

        /// <remarks/>
        public Price share_price
        {
            get
            {
                return this.share_priceField;
            }
            set
            {
                this.share_priceField = value;
            }
        }
    }
}
