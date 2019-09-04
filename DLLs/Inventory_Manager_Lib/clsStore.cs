using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
    public class clsStore
    {
        // StoreID, StoreName, StoreLocation, StoreGPSPoints, UserID, SystemDate, LastUpdatedDate, LastUpdatedBy
        public int StoreID { get; set; }
        public string StoreName { get; set; }
        public string StoreLocation { get; set; }
        public string StoreGPSPoints { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdatedDate { get; set; }
        public string LastUpdatedBy { get; set; }
    }
}
