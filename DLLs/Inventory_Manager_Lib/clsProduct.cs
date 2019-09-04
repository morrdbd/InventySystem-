using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
    public class clsProduct
    {
        public int SNO { get; set; }
        public string ProductCode { set; get; }
        public string ProductName { set; get; }
        public string ProductDescription { set; get; }
        public int ProductUsageTypeID { get; set; }
        public string ProductUsageTypeName { get; set; }
        public string ProductBarCode { get; set; }
        public int GroupID { get; set; }
        public int ProductCategoryID { get; set; }
        public int ProductBrandID { get; set; }
        public int ProductOriginID { get; set; }
        public int UnitID { get; set; }
        public int PackingID { get; set; }
        public int ColorID { get; set; }
        public int SizeID { get; set; }
        public int StoreID { get; set; }
        public float SalePrice { get; set; }
        public string ProductImagePath { get; set; }
        public string UserID { get; set; }
        public string SystemDate { get; set; }
        public string LastUpdateBy { get; set; }
        public string LastUpdateDate { get; set; }
        public string GroupName { get; set; }
        public string CategoryName { get; set; }
        public string ProductOriginName { get; set; }
        public string BrandName { get; set; }
        public string SizeName { get; set; }
        public string ColorName { get; set; }
        public string ProductImageChange { set; get; }
        public string UsageName { set; get; }
    
    }



}
