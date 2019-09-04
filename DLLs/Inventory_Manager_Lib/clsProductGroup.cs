using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
   public class clsProductGroup
    {
        public int GroupID { get; set; }
        public string GroupName { get; set; }
        public int StoreID { get; set; }
        public string UserID { get; set; }
        public string  SystemDate { get; set; }
        public string LastUpdatedBy { get; set; }
        public string LastUpdatedDate { get; set; }
    }
}
