using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

namespace SPCi.Web.Applications.Pages.Misc
{
    public partial class Pruebas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ejecutar el procedimiento almacenado para actualizar los datos
                EjecutarProcedimientoActualizarEstadoVista();

                // Solo rebind si RadGrid1 no es null
                if (RadGrid1 != null)
                {
                    RadGrid1.Rebind();
                }
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (RadGrid1 != null)
            {
                MostrarDatos();
            }
        }

        protected void MostrarDatos()
        {
            // Solo muestra datos si RadGrid1 no es null
            if (RadGrid1 != null)
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
        }

        private void EjecutarProcedimientoActualizarEstadoVista()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("ActualizarEstadoVista", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            // Ejecutar el procedimiento almacenado para actualizar los datos
            EjecutarProcedimientoActualizarEstadoVista();

            // Volver a enlazar los datos con RadGrid1
            RadGrid1.Rebind();
        }
    }
}
