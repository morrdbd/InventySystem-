using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
  public class clsAssetsOfEmployee
    {
        //EmployeeID, FullName, FatherName, RequestNumber, RequestByDepartment, RequestDate, TicketNumber, SystemDate, ProductCode, ProductName, SerialNumber, Quantity, AveragePrice, Total, AssetStatus
      public string EmployeeID { set; get; }
      public string FullName { set; get; }
      public string FatherName { set; get; }
      public string ProductCode { set; get; }
      public string ProductName { set; get; }
      public string SerialNumber { set; get; }
      public string Quantity { set; get; }
      public string AveragePrice { set; get; }
      public string Total { set; get; }
      public string ID { set; get; }

      //ReturnDate, ReturnRemarks, ReturnBy

      public string ReturnRemarks { set; get; }
      public string ReturnBy { set; get; }

  }
}
