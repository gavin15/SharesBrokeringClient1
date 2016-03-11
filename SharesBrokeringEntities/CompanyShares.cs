using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharesBrokeringEntities
{
    public class CompanyShares
    {

        private List<Company> companyField=new List<Company>();

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("company")]
        public List<Company> company
        {
            get
            {
                return this.companyField;
            }
            set
            {
                this.companyField = value;
            }
        }
    }
}
