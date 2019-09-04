using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
    public class clsProductSize
    {
        //SizeID, SizeName, SizeShortName, StoreID, UserID, SystemDate, LastUpdatedBy, LastUpdateDate
        public int SizeID { get; set; }
        public string SizeName { get; set; }
        public string SizeShortName { get; set; }
        public int StoreID { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdatedBy { set; get; }
        public string LastUpdateDate { get; set; }
    }
}
