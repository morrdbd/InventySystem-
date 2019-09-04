using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRMIS_Lib
{
   public class EmpAtDepartmentList
    {
        public string ID { set; get; }
        public string Employee_ID { set; get; }
        public string Name { get; set; }
        public string FName { get; set; }
        public string GFName { get; set; }
        public string Department_Name { set; get; }
        public string Department_Location { set; get; }
        public string Position { set; get; }
        public string Reporting_To { set; get; }
        public string Status { set; get; }
        public string System_Date { set; get; }
        public string Photo { set; get; }
    }
}
