<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/RLSiteMenu.Master" AutoEventWireup="true" CodeBehind="Pruebas.aspx.cs" Inherits="SPCi.Web.Applications.Pages.Misc.Pruebas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Puedes agregar contenido para la cabecera aquí si es necesario -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadPageLayout runat="server" ID="JumbotronLayout" CssClass="jumbotron" GridType="Fluid">
  
    </telerik:RadPageLayout>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" CssClass="grid_wrapper">
        <telerik:RadGrid ID="RadGrid1" runat="server" PageSize="50" PagerStyle-PageButtonCount="5"
            OnNeedDataSource="RadGrid1_NeedDataSource" AllowPaging="True" AllowSorting="true" ShowGroupPanel="false"
            OnItemCommand="RadGrid1_ItemCommand" OnUpdateCommand="RadGrid1_UpdateCommand" RenderMode="Auto" Width="100%" Height="920px">
            <GroupingSettings ShowUnGroupButton="true" />
            <ExportSettings ExportOnlyData="true" IgnorePaging="true" FileName="Gestión de Placas y Choferes para Servicio a Granel"></ExportSettings>

            <MasterTableView AutoGenerateColumns="False"
                AllowFilteringByColumn="false" TableLayout="Fixed"
                DataKeyNames="lx_vista" CommandItemDisplay="Top"
                InsertItemPageIndexAction="ShowItemOnFirstPage">
                <CommandItemSettings ShowAddNewRecordButton="true" ShowExportToCsvButton="true" ShowExportToExcelButton="true" ShowExportToPdfButton="true" ShowExportToWordButton="true" AddNewRecordText="Formulario" RefreshText="Actualizar" 
                    ShowRefreshButton="true"/>
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="ID Vista" UniqueName="lx_vista">
                <HeaderStyle Width="150px" />
                <ItemTemplate>
                    <asp:Label ID="lblIdVista" runat="server" Text='<%# Eval("lx_vista") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblIdVistaEdit" runat="server" Text='<%# Bind("lx_vista") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:Label ID="lblIdVistaInsert" runat="server" Text='<%# SiguienteIdVista %>' />
                </InsertItemTemplate>
            </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="lx_ServicioGranel" HeaderText="Servicio Granel" SortExpression="lx_ServicioGranel"
                        UniqueName="lx_ServicioGranel">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="idTipoCarga" HeaderText="Tipo Carga" SortExpression="idTipoCarga"
                        UniqueName="idTipoCarga">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="cho_cedula" HeaderText="Chofer" SortExpression="cho_cedula"
                        UniqueName="cho_cedula">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="cam_placa" HeaderText="Camión" SortExpression="cam_placa"
                        UniqueName="cam_placa">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Fecha" UniqueName="fecha_hora">
                <HeaderStyle Width="150px" />
                <ItemTemplate>
                    <asp:Label ID="lblFechaHora" runat="server" Text='<%# Eval("fecha_hora") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblFechaHoraEdit" runat="server" Text='<%# Bind("fecha_hora") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:Label ID="lblFechaHoraInsert" runat="server" Text='<%# DateTime.Now.ToString("G") %>' />
                </InsertItemTemplate>
            </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Estado" UniqueName="estado">
                        <HeaderStyle Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lblEstado" runat="server" 
                                Text='<%# Eval("estado") != DBNull.Value ? (Convert.ToBoolean(Eval("estado")) ? "✔" : "✘") : "" %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridEditCommandColumn UniqueName="EditColumn" HeaderText="Editar Columna">
                        <HeaderStyle Width="70px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Borrar Columna"
                        ConfirmText="¿Está seguro que desea eliminar este registro?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Confirmación de eliminación">
                        <HeaderStyle Width="70px" />
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>

            <ClientSettings AllowColumnsReorder="true" AllowColumnHide="true" AllowDragToGroup="true">
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
        </telerik:RadGrid>

        

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" HeaderText="Borrar Columna">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>