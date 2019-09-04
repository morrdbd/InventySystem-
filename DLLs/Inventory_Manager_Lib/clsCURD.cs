using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
    public static class clsCURD
    {
        public static SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        public static void ExecuteStoreProcedure(string procedureName, SqlParameter[] commandParameter)
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
        public static DataTable GetData(string procedureName)
        {
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procedureName;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            catch (SqlException Sexp)
            {

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return dt;
        }
        public static DataTable GetData(string procedureName, SqlParameter[] commandParameter)
        {
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procedureName;
                cmd.Parameters.AddRange(commandParameter);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            catch (SqlException Sexp)
            {

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return dt;
        }
    }
}
