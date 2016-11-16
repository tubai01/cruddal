using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;

namespace DataAccessLayer
{
    public class CRUDDAL
    {
        string con = ConfigurationManager.ConnectionStrings["CRUDDALCON"].ConnectionString;

        /// <summary>
        /// Parameters objParameters=AddParameter("@ParameterName",value);
        /// </summary>
        /// <param name="ParameterName"></param>
        /// <param name="ParameterValue"></param>
        /// <returns></returns>
        public Parameters AddParameter(string ParameterName, string ParameterValue)
        {

            Parameters objParameters = new Parameters();
            objParameters.ParameterName = ParameterName;
            objParameters.ParameterValue = ParameterValue;

            return objParameters;
        }



        /// DataAccessLayer DAL=new DataAccessLayer();
        /// List<Parameters> Listparameters=new List<Parameters>();
        /// Listparameters.AddParameter(DAL.AddParameter("@ParameterName", value));
        /// List<Model> model = DAL.CRUD<Model>(Listparameters,"StoredProcedureName");

        /// <summary>
        /// CRUDE returns out put as message property only in model or whole model for Insert,Update in model,Delete and whole model for Retrieve
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="parameters"></param>
        /// <param name="SqlStatement"></param>
        /// <returns></returns>


        public List<T> CRUD<T>(String SqlStatement, List<Parameters> parameters = null)
        {

            SqlDataAdapter da = new SqlDataAdapter(SqlStatement, con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            if (parameters != null)
            {
                for (int i = 0; i < parameters.Count(); i++)
                {

                    da.SelectCommand.Parameters.AddWithValue(parameters[i].ParameterName.ToString(), parameters[i].ParameterValue.ToString());

                }
            }
            DataTable dt = new DataTable();
            da.Fill(dt);
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                if (row != null)
                {
                    T item = GetItem<T>(row);
                    data.Add(item);
                }
            }
            var columnNames = dt.Columns.Cast<DataColumn>()
           .Select(c => c.ColumnName)
           .ToList();



            return data;
        }


        public T GetItem<T>(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {

                foreach (PropertyInfo pro in temp.GetProperties())
                {

                    if (pro.Name == column.ColumnName)

                        pro.SetValue(obj, Convert.ChangeType(dr[column.ColumnName], pro.PropertyType), null);

                    else
                        continue;
                }
            }
            return obj;
        }
    }
    public class Parameters
    {

        public string ParameterName { get; set; }
        public string ParameterValue { get; set; }
    }
}
