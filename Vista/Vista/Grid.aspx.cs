using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

public partial class Grid : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadGrid1.Rebind();
        }
    }

    protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        MostrarDatos();
    }

    protected void MostrarDatos()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Vista";
            SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            RadGrid1.DataSource = dataTable;
        }
    }

    protected void verificacion()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand("ActualizarEstadoVista", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }
        
        // Rebind the RadGrid to reflect the updated data
        RadGrid1.Rebind();
    }

}
