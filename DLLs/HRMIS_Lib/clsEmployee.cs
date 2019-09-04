using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRMIS_Lib
{
   public class clsEmployee
    {
        public string Employee_ID { set; get; }
        public string Name { set; get; }
        public string Father_Name { set; get; }
        public string Grand_Father_Name { set; get; }
        public string Name_Local { set; get; }
        public string Father_Name_Local { set; get; }
        public string Grand_Father_Name_Local { set; get; }
        public string Gender { set; get; }
        public string Marital_Status { set; get; }
        public string Photo { set; get; }
        public string OtherId { set; get; }
        public string Date_Of_Birth { set; get; }
        public string Personal_Mobile_Number { set; get; }
        public string Personal_Email_Address { set; get; }
        public string Official_Contact_Number { set; get; }
        public string Official_Email_Address { set; get; }
        public string Emergency_Contact_Relationship { set; get; }
        public string Emergency_Contact_Name { set; get; }
        public string Emergency_Contact_Mobile { set; get; }
        public string National_ID_Card_NO { set; get; }
        public int Education_Grade_ID { set; get; }
        public string Main_Course_of_Study { set; get; }
        public string Specialization { set; get; }
        public string Remarks { set; get; }
        public string User_ID { set; get; }
        public int Permanent_Province_ID { set; get; }
        public int Permanent_District_ID { set; get; }
        public string Permanent_Village { set; get; }
        public int Present_Province_ID { set; get; }
        public int Present_District_ID { set; get; }
        public string Present_Village { set; get; }
    }
}
