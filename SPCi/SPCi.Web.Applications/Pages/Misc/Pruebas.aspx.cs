using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Web.UI.WebControls;

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

        // Metodo Mostar Datos para la Visualizar la Vista
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

        // Metodo Actualizar Proceso de actualizar la el esrado de la vista
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

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            // Poder Actualizar la vista
            if (e.CommandName == "RebindGrid")
            {
                // Ejecutar el procedimiento almacenado para actualizar los datos
                EjecutarProcedimientoActualizarEstadoVista();

                // Volver a enlazar los datos con RadGrid1
                RadGrid1.Rebind();
            }

            // Insertar Datos Formulario
            if (e.CommandName == RadGrid.PerformInsertCommandName)
            {
                GridEditableItem editableItem = e.Item as GridEditableItem;

                // Extraer los valores de los controles en el formulario de edición
                int servicioGranel = Convert.ToInt32((editableItem["lx_ServicioGranel"].Controls[0] as TextBox).Text);
                int tipoCarga = Convert.ToInt32((editableItem["idTipoCarga"].Controls[0] as TextBox).Text);
                string chofer = (editableItem["cho_cedula"].Controls[0] as TextBox).Text;
                string camion = (editableItem["cam_placa"].Controls[0] as TextBox).Text;
                // No necesitamos extraer el valor del campo "estado"

                // Llamar al método para insertar el registro en la base de datos
                InsertarRegistro(servicioGranel, tipoCarga, chofer, camion);

                // Rebind para actualizar la grilla con el nuevo registro
                RadGrid1.Rebind();
            }

            // Eliminar Registro del Formulario
            if (e.CommandName == "Delete")
            {
                // Obtener el ID del elemento a eliminar
                string idVista = (e.Item as GridDataItem).GetDataKeyValue("lx_vista").ToString();

                // Llamar al método para eliminar el registro de la base de datos
                EliminarRegistro(idVista);

                // Volver a enlazar los datos para reflejar los cambios
                RadGrid1.Rebind();
            }
  
        }

        // Metodo de Insertar Registro
        private void InsertarRegistro(int servicioGranel, int tipoCarga, string chofer, string camion)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Vista (lx_ServicioGranel, idTipoCarga, cho_cedula, cam_placa) " +
                               "VALUES (@ServicioGranel, @TipoCarga, @Chofer, @Camion)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ServicioGranel", servicioGranel);
                    command.Parameters.AddWithValue("@TipoCarga", tipoCarga);
                    command.Parameters.AddWithValue("@Chofer", chofer);
                    command.Parameters.AddWithValue("@Camion", camion);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        // Metodo de Actualizar Registro
        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            // Obtener el ítem que está siendo editado
            GridEditableItem editedItem = e.Item as GridEditableItem;

            // Obtener los valores de los controles del formulario de edición
            int idVista = Convert.ToInt32(editedItem.GetDataKeyValue("lx_vista"));
            int servicioGranel = Convert.ToInt32((editedItem["lx_ServicioGranel"].Controls[0] as TextBox).Text);
            int tipoCarga = Convert.ToInt32((editedItem["idTipoCarga"].Controls[0] as TextBox).Text);
            string chofer = (editedItem["cho_cedula"].Controls[0] as TextBox).Text;
            string camion = (editedItem["cam_placa"].Controls[0] as TextBox).Text;

            // Lógica para actualizar la base de datos con los nuevos valores
            string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Vista SET lx_ServicioGranel = @ServicioGranel, idTipoCarga = @TipoCarga, cho_cedula = @Chofer, cam_placa = @Camion WHERE lx_vista = @IdVista";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ServicioGranel", servicioGranel);
                command.Parameters.AddWithValue("@TipoCarga", tipoCarga);
                command.Parameters.AddWithValue("@Chofer", chofer);
                command.Parameters.AddWithValue("@Camion", camion);
                command.Parameters.AddWithValue("@IdVista", idVista);

                connection.Open();
                command.ExecuteNonQuery();
            }

            // Vuelve a enlazar los datos para reflejar los cambios
            RadGrid1.Rebind();
        }



        // Metodo EliminarRegistro de la Base de Datos
        private void EliminarRegistro(string idVista)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("DELETE FROM Vista WHERE lx_vista = @lx_vista", connection))
                {
                    command.Parameters.AddWithValue("@lx_vista", idVista);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        // Metodo para obtener ID  
        public int SiguienteIdVista
        {
            get
            {
                return ObtenerSiguienteIdVista();
            }
        }

        protected int ObtenerSiguienteIdVista()
        {
            int siguienteId = 1; // Valor predeterminado si no hay registros

            string connectionString = ConfigurationManager.ConnectionStrings["SqlServerConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(lx_vista), 0) + 1 FROM Vista";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                siguienteId = (int)command.ExecuteScalar();
            }

            return siguienteId;
        }


    }
}
