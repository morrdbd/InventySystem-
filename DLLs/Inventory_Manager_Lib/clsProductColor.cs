using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
   public class clsProductColor
    {

       //ColorID, ColorName, ColorShortName, StoreID, UserID, SystemDate, LastUpdatedBy, LastUpdatedDate

        public int ColorID { get; set; }
        public string ColorName { get; set; }
        public string ColorShortName { get; set; }
        public int StoreID { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdatedBy { set; get; }
        public string LastUpdateDate { get; set; }
    }
}
