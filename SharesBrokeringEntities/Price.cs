using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharesBrokeringEntities
{
    public class Price
    {

        private string currencyField;

        private float valueField;

        private string last_updateField;

        /// <remarks/>
        public string currency
        {
            get
            {
                return this.currencyField;
            }
            set
            {
                this.currencyField = value;
            }
        }

        /// <remarks/>
        public float value
        {
            get
            {
                return this.valueField;
            }
            set
            {
                this.valueField = value;
            }
        }

        /// <remarks/>
        public string last_update
        {
            get
            {
                return this.last_updateField;
            }
            set
            {
                this.last_updateField = value;
            }
        }
    }
}
