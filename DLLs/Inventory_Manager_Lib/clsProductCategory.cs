using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
   public  class clsProductCategory
    {
        //CategoryCode, CategoryName, CategoryDescription, GroupID, StoreID, UserID, SystemDate, LastUpdateDate, LastUpdateBy
        public int CategoryCode { set; get; }
        public string CategoryName { get; set; }
        public string CategoryDescription { get; set; }
        public int GroupID { get; set; }
        public string GroupName { set; get; }
        public int StoreID { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdatedDate { get; set; }
        public string LastUpdatedBy { get; set; }
    }
}
