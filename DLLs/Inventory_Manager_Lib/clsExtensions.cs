using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Inventory_Manager_Lib
{
    public static class clsExtensions
    {
        public static IList<T> ToList<T>(this DataTable table) where T : new()
        {
            var props = typeof(T).GetProperties().ToList();
            var result = new List<T>();
            Parallel.ForEach(table.AsEnumerable(), row =>
                    result.Add(DataRowToObject<T>(row, props)));
            return result;
        }
        private static T DataRowToObject<T>(DataRow row, IList<PropertyInfo> props) where T : new()
        {
            T item = new T();
            foreach (var prop in props)
            {
                if (row.Table.Columns.Contains(prop.Name))
                {
                    Type proptype = prop.PropertyType;
                    var targetType = IsNullableType(prop.PropertyType) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType;
                    var propertyVal = row[prop.Name];
                    try
                    {
                        propertyVal = Convert.ChangeType(propertyVal, targetType);
                        prop.SetValue(item, propertyVal, null);
                    }
                    catch (InvalidCastException ae)
                    {
                        propertyVal = 0;
                    }
                }
            }
            return item;
        }
        private static bool IsNullableType(Type type)
        {
            return type.IsGenericType && type.GetGenericTypeDefinition().Equals(typeof(Nullable<>));
        }
        public static bool HasProperty(this object obj, string propertyName)
        {
            return obj.GetType().GetProperty(propertyName) != null;
        }
    }
}
