using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
namespace Inventory_Manager_Lib
{
    interface IDBCommon
    {
        void Insert();
        void Update();
        void Delete();
    }
    public class clsDbGeneral : IDBCommon
    {
        public SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        public void ExecuteStoreProcedure(string procedureName, SqlParameter[] commandParameter)
        {
            con.Open();
            SqlTransaction tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Transaction = tran;
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = procedureName;
            cmd.Parameters.AddRange(commandParameter);
            try
            {
                cmd.ExecuteNonQuery();
                tran.Commit();
            }
            catch (SqlException Sexp)
            {
                tran.Rollback();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
            }
            finally
            {
                con.Close();
            }
        }
        public DataTable GetData(string Query)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(Query, con);
            da.Fill(dt);
            return dt;
        }
        #region IDBCommon Members
        public virtual void Insert()
        {
            throw new NotImplementedException();
        }
        public virtual void Update()
        {
            throw new NotImplementedException();
        }
        public virtual void Delete()
        {
            throw new NotImplementedException();
        }
        #endregion
        public void fillDll(DropDownList dname, string dm, string vm, string query)
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dname.DataTextField = dm;
            dname.DataValueField = vm;
            dname.DataSource = dt;
            dname.DataBind();
        }
        public void fillList(CheckBoxList dname, string dm, string vm, string query)
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dname.DataTextField = dm;
            dname.DataValueField = vm;
            dname.DataSource = dt;
            dname.DataBind();
        }
        public  string ShamsiToGregorian(string shamsiDate)
        {
            //1395/06/03
            string[] date = shamsiDate.Split('/');
            string day = date[2];
            string month = date[1];
            string year = date[0];
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand("select dbo.ShamsiToGreg(" + day + "," + month + "," + year + ")", con2);
            if (con2.State == ConnectionState.Closed)
                con2.Open();
            DateTime gd = DateTime.Parse(com.ExecuteScalar().ToString());
            con2.Close();
            return gd.ToString("MM/dd/yyyy");
        }
        public  string GregorianToShamsi(string gdate)
        {
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand("select dbo.funGregToShamsi('" + gdate + "')", con2);
            if (con2.State == ConnectionState.Closed)
                con2.Open();
            string gd = com.ExecuteScalar().ToString();
            con2.Close();
            return gd;
        }
        public int GetMaxID(string ColumnName, string TableName)
        {
            try
            {
                int id;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "select isnull(max(" + ColumnName + "),0)+1 from " + TableName + "";
                cmd.Connection = con;
                con.Open();
                return id = int.Parse(cmd.ExecuteScalar().ToString());
            }
            catch (Exception ex)
            {
                throw new Exception("max id error:", ex);
            }

            finally
            {
                con.Close();
            }
        }
        public void ExecuteQuery(string Query)
        {
            SqlCommand cmd = new SqlCommand(Query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
