<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeFile="Grid.aspx.cs" Inherits="Grid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="styles/grid.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadPageLayout runat="server" ID="JumbotronLayout" CssClass="jumbotron" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="10" SpanMd="12" SpanSm="12" SpanXs="12">
                        <h1>H1 title, font size 36px. Duis nibh dolor, rhoncus in euismod at, feugiat id magna.</h1>
                        <h2>H2 Title, font size 30 px.</h2>
                    </telerik:LayoutColumn>
                    <telerik:LayoutColumn Span="2" HiddenMd="true" HiddenSm="true" HiddenXs="true">
                        <img src="images/Thumbnails/Desert.jpg" />
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" CssClass="grid_wrapper">
        <telerik:RadGrid ID="RadGrid1" runat="server" PageSize="10" PagerStyle-PageButtonCount="5"
            OnNeedDataSource="RadGrid1_NeedDataSource" AllowPaging="True" AllowSorting="true" ShowGroupPanel="true" RenderMode="Auto">
            <GroupingSettings ShowUnGroupButton="true" />
            <ExportSettings ExportOnlyData="true" IgnorePaging="true"></ExportSettings>
            <MasterTableView AutoGenerateColumns="False"
                AllowFilteringByColumn="true" TableLayout="Fixed"
                DataKeyNames="lx_vista" CommandItemDisplay="Top"
                InsertItemPageIndexAction="ShowItemOnFirstPage">
                <CommandItemSettings ShowExportToCsvButton="true" ShowExportToExcelButton="true" ShowExportToPdfButton="true" ShowExportToWordButton="true" />
                <Columns>
                    <telerik:GridBoundColumn DataField="lx_vista" HeaderText="ID Vista" SortExpression="lx_vista"
                        UniqueName="lx_vista">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
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
                    <telerik:GridBoundColumn DataField="fecha_hora" HeaderText="Fecha" SortExpression="fecha_hora"
                        UniqueName="fecha_hora">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Estado" UniqueName="estado">
                        <ItemTemplate>
                            <asp:Label ID="lblEstado" runat="server" 
                                Text='<%# Convert.ToBoolean(Eval("estado")) ? "✔" : "✘" %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridEditCommandColumn UniqueName="EditColumn" HeaderText="Edit Command Column">
                        <HeaderStyle Width="70px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete Command Column">
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
</asp:Content>