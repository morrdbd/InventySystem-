using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
namespace Inventory_Manager_Lib
{
    public class clsEmployeeInfo : clsDbGeneral
  {
      #region privatememeber
     string   Emp_No, Emp_Name, Designation, Mobile_no, Login_Name, status, E_Mail,
      Emp_Grade_Code, Emp_Manager, Gender, Nationality, Address1, Address2;
     byte[] Password;
      int Department_Id;
      DateTime Joining_date,DOB;

      #endregion
      #region properties
      public DateTime DOBp
      {
          set { DOB = value; }
          get { return DOB; }
      }
      public DateTime Joining_datep
      {
          set { Joining_date = value; }
          get { return Joining_date; }
      }
      public int Department_Idp
      {
          set { Department_Id = value; }
          get { return Department_Id; }
      }
      public string Address2p
      {
          set { Address2 = value; }
          get { return Address2; }
      }
      public string Address1p
      {
          set { Address1 = value; }
          get { return Address1; }
      }
      public string Nationalityp
      {
          set { Nationality = value; }
          get { return Nationality; }
      }
      public string Genderp
      {
          set { Gender = value; }
          get { return Gender; }
      }
      public string Emp_Managerp
      {
          set { Emp_Manager = value; }
          get { return Emp_Manager; }
      }
      public string Emp_Grade_Codep
      {
          set { Emp_Grade_Code = value; }
          get { return Emp_Grade_Code; }
      }
      public string E_Mailp
      {
          set { E_Mail = value; }
          get { return E_Mail; }
      }
      public string statusp
      {
          set { status = value; }
          get { return status; }
      
      }
      public byte[] Passwordp
      {
          set { Password = value; }
          get { return Password; }
      }
      public string Login_Namep
      {
          set { Login_Name = value; }
          get { return Login_Name; }
      }
      public string Mobile_nop
      {
          set { Mobile_no = value; }
          get { return Mobile_no; }
      }
      public string Designationp
      {
          set { Designation = value; }
          get { return Designation; }
      }
      public string Emp_Namep
      {
          set { Emp_Name = value; }
          get { return Emp_Name; }
      }

      public string Emp_Nop
      {
          set { Emp_No = value; }
          get { return Emp_No; }
      }

      #endregion
      public bool Insert()
      {
          try
          {
              SqlCommand cmd = new SqlCommand();
              cmd.CommandType = CommandType.StoredProcedure;
              cmd.CommandText = "Employee_Insert";
              cmd.Connection = con;
              cmd.Parameters.Add("@Emp_No", SqlDbType.VarChar).Value = Emp_No;
              cmd.Parameters.Add("@Emp_Name", SqlDbType.VarChar).Value = Emp_Name;
              cmd.Parameters.Add("@Designation", SqlDbType.VarChar).Value = Designation;
              cmd.Parameters.Add("@Department_Id", SqlDbType.Int).Value = Department_Id;
              cmd.Parameters.Add("@Mobile_no", SqlDbType.VarChar).Value = Mobile_no;
              cmd.Parameters.Add("@Login_Name", SqlDbType.VarChar).Value = Login_Name;
              cmd.Parameters.Add("@Password", SqlDbType.VarBinary).Value = Password;
              cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
              cmd.Parameters.Add("@E_Mail", SqlDbType.VarChar).Value = E_Mail;
              cmd.Parameters.Add("@DOB", SqlDbType.DateTime).Value = DOB;
              cmd.Parameters.Add("@Emp_Grade_Code", SqlDbType.VarChar).Value = Emp_Grade_Code;
              cmd.Parameters.Add("@Emp_Manager", SqlDbType.VarChar).Value = Emp_Manager;
              cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = Gender;
              cmd.Parameters.Add("@Joining_date", SqlDbType.DateTime).Value = Joining_date;
              cmd.Parameters.Add("@Nationality", SqlDbType.VarChar).Value = Nationality;
              cmd.Parameters.Add("@Address1", SqlDbType.VarChar).Value = Address1;
              cmd.Parameters.Add("@Address2", SqlDbType.VarChar).Value = Address2;
              con.Open();
              cmd.ExecuteNonQuery();
              return true;

          }
          catch (Exception ex)
          {
              throw new Exception("Insertion Error", ex);
          }
          finally
          {
              con.Close();

          }
      }
      public  bool Update()
      {
          try
          {
              SqlCommand cmd = new SqlCommand();
              cmd.CommandType = CommandType.StoredProcedure;
              cmd.CommandText = "Employee_Update";
              cmd.Connection = con;
              cmd.Parameters.Add("@Emp_No", SqlDbType.VarChar).Value = Emp_No;
              cmd.Parameters.Add("@Emp_Name", SqlDbType.VarChar).Value = Emp_Name;
              cmd.Parameters.Add("@Designation", SqlDbType.VarChar).Value = Designation;
              cmd.Parameters.Add("@Department_Id", SqlDbType.Int).Value = Department_Id;
              cmd.Parameters.Add("@Mobile_no", SqlDbType.VarChar).Value = Mobile_no;
              cmd.Parameters.Add("@Login_Name", SqlDbType.VarChar).Value = Login_Name;
             
              cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
              cmd.Parameters.Add("@E_Mail", SqlDbType.VarChar).Value = E_Mail;
              cmd.Parameters.Add("@DOB", SqlDbType.DateTime).Value = DOB;
              cmd.Parameters.Add("@Emp_Grade_Code", SqlDbType.VarChar).Value = Emp_Grade_Code;
              cmd.Parameters.Add("@Emp_Manager", SqlDbType.VarChar).Value = Emp_Manager;
              cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = Gender;
              cmd.Parameters.Add("@Joining_date", SqlDbType.DateTime).Value = Joining_date;
              cmd.Parameters.Add("@Nationality", SqlDbType.VarChar).Value = Nationality;
              cmd.Parameters.Add("@Address1", SqlDbType.VarChar).Value = Address1;
              cmd.Parameters.Add("@Address2", SqlDbType.VarChar).Value = Address2;
              con.Open();
              cmd.ExecuteNonQuery();
              return true;

          }
          catch (Exception ex)
          {
              throw new Exception("Insertion Error", ex);
          }
          finally
          {
              con.Close();

          }


      }
  }
}
