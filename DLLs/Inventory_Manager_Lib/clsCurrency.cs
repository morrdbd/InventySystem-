using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
  public  class clsCurrency
    {
        //CurrencyID, CurrencyName, CurrencySymbol, ToBaseCurrencyOperator, FromBaseCurrencyOperator, IsBaseCurrency, StoreID, UserID, SystemDate, LastUpdateBy, LastUpdateDate
        public int CurrencyID { get; set; }
        public string CurrencyName { get; set; }
        public string CurrencySymbol { get; set; }
        public string ToBaseCurrencyOperator { get; set; }
        public string FromBaseCurrencyOperator { get; set; }
        public string IsBaseCurrency { get; set; }
        public int StoreID { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdatedBy { get; set; }
        public string LastUpdatedDate { get; set; }
    }
}
