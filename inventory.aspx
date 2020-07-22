<%@ Page Language="C#" AutoEventWireup="true" CodeFile="inventory.aspx.cs"
Inherits="ItemLookup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="img/logo.ico" />
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.13.0/css/all.css"
      integrity="sha384-Bfad6CLCknfcloXFOyFnlgtENryhrpZCe29RTifKEixXQZ38WheV+i/6YWSzkz3V"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="css/style.css" />
    <title>IMS || Inventory</title>
  </head>
  <body>
    <form id="form1" runat="server">
      <!-- Start Navbar -->
      <nav class="navbar navbar-expand-md bg-dark navbar-dark p-0">
        <div class="container">
          <a href="index.aspx" class="navbar-brand">
            <i class="fas fa-archive"></i>I<small>nventory</small> M<small
              >anagement</small
            >
            S<small>olutions</small>
          </a>
          <button
            class="navbar-toggler"
            data-toggle="collapse"
            data-target="#navbarCollapse"
          >
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav">
              <li class="nav-item px-2">
                <a href="index.aspx" class="nav-link">Dashboard</a>
              </li>
              <li class="nav-item px-2">
                <a href="inventory.aspx" class="nav-link active">Inventory</a>
              </li>
              <li class="nav-item px-2">
                <a href="purchaseorders.aspx" class="nav-link"
                  >Purchase Orders</a
                >
              </li>
              <li class="nav-item px-2">
                <a href="employees.aspx" class="nav-link">Employees</a>
              </li>
              <li class="nav-item px-2">
                <a href="departments.aspx" class="nav-link">Departments</a>
              </li>
            </ul>
            <ul class="navbar-nav ml-auto">
              <li class="nav-item dropdown mr-3">
                <a
                  href="#"
                  class="nav-link dropdown-toggle"
                  data-toggle="dropdown"
                >
                  <i class="fas fa-user"></i> Welcome
                  <asp:Label
                    ID="nameLabel"
                    runat="server"
                    Text="Label"
                  ></asp:Label>
                </a>
                <div class="dropdown-menu">
                  <a href="profile.aspx" class="dropdown-item">
                    <i class="fas fa-user-circle"></i>Profile
                  </a>
                  <asp:LinkButton
                    runat="server"
                    ID="LinkButton1"
                    OnClick="logoutLink_Click"
                    class="dropdown-item"
                  >
                    <i class="fas fa-user-times"></i> Logout
                  </asp:LinkButton>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
      <!-- Start Header -->
      <header id="main-header" class="py-2 bg-primary text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1><i class="fas fa-archive"></i> Inventory</h1>
            </div>
          </div>
        </div>
      </header>
      <!-- End Header -->
      <!-- Start Actions Section -->
      <div class="container my-5">
        <div class="row">
          <div class="col-xs-4 mx-auto">
            <div class="input-group">
              <div class="input-group-prepend">
                <label
                  for="skutxt"
                  class="input-group-text bg-primary text-white"
                  >Item SKU I-</label
                >
              </div>
              <asp:TextBox
                ID="skutxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="SKUSearch"
                runat="server"
                Text="Search SKU"
                CssClass="btn btn-primary input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <div class="col-xs-4 mx-auto">
            <div class="input-group">
              <div class="input-group-prepend">
                <label
                  for="itemname"
                  class="input-group-text bg-primary text-white"
                  >Item Name</label
                >
              </div>
              <asp:TextBox
                ID="itemnametxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="NameSearch"
                runat="server"
                CssClass="btn btn-primary input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <!-- Start Active Item Filter Section -->
          <div class="col-xs-4 mx-auto">
            <!-- div section for all radio buttons to filter for active or inactive items -->
            <asp:RadioButton
              ID="RadBoth"
              runat="server"
              GroupName="status"
              Text="Both"
              AutoPostBack="true"
              OnCheckedChanged="RadBoth_CheckedChanged"
            />
            <asp:RadioButton
              ID="RadActive"
              runat="server"
              GroupName="status"
              Text="Active"
              AutoPostBack="true"
              OnCheckedChanged="RadActive_CheckedChanged"
            />
            <asp:RadioButton
              ID="RadInactive"
              runat="server"
              GroupName="status"
              Text="Inactive"
              AutoPostBack="true"
              OnCheckedChanged="RadInactive_CheckedChanged"
            />
          </div>
          <!-- End Active Item Filter Section -->
        </div>
      </div>
      <!-- End Actions Section -->
      <!-- Start Table Management Section -->
      <div class="container">
        <div class="row">
          <!-- Start Column Selector Section -->
          <div class="col-xs-3 mx-auto">
            <div class="card">
              <div class="card-body">
                <div class="form-group">
                  <asp:CheckBoxList
                    ID="ColumnCheckBoxList"
                    runat="server"
                    AutoPostBack="True"
                    OnSelectedIndexChanged="Check_Clicked"
                    CssClass="asp-checklist ml-3"
                    Width="100%"
                  >
                    <asp:ListItem Value="2">LocationID</asp:ListItem>
                    <asp:ListItem Value="3">On Hand Quantity</asp:ListItem>
                    <asp:ListItem Value="4">Total Quantity</asp:ListItem>
                    <asp:ListItem Value="5">Price</asp:ListItem>
                    <asp:ListItem Value="6">Last Order Date</asp:ListItem>
                    <asp:ListItem Value="7">Status</asp:ListItem>
                    <asp:ListItem Value="8">Supplier</asp:ListItem>
                    <asp:ListItem Value="9">Comments</asp:ListItem>
                  </asp:CheckBoxList>
                </div>
              </div>
            </div>
          </div>
          <!-- End Column Selector Section -->
          <!-- Start Inventory Table Section -->
          <div class="col-sm-9 mx-auto">
            <!-- Table using asp GridView and connecting to database  This will also serve as the default style for now, Allows for sorting and paging.-->
            <asp:GridView
              ID="ItemLookUpGridView"
              runat="server"
              AllowPaging="True"
              AllowSorting="True"
              AutoGenerateColumns="false"
              EmptyDataText="No data available."
              OnSorting="ItemLookUp_Sorting"
              OnPageIndexChanging="OnPageIndexChanging"
              PageSize="10"
              CssClass="table table-striped"
            >
              <Columns>
                <asp:TemplateField
                  ItemStyle-Width="150px"
                  HeaderText="SKU"
                  SortExpression="SKU"
                >
                  <ItemTemplate>
                    <%# Eval("SKU") %>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField
                  DataField="ItemName"
                  HeaderText="Item Name"
                  ItemStyle-Width="150"
                  SortExpression="ItemName"
                />
                <asp:BoundField
                  DataField="LocationID"
                  HeaderText="Location ID"
                  ItemStyle-Width="150"
                  SortExpression="LocationID"
                />
                <asp:BoundField
                  DataField="OnHand"
                  HeaderText="On Hand Quantity"
                  ItemStyle-Width="150"
                  SortExpression="OnHand"
                />
                <asp:BoundField
                  DataField="Quantity"
                  HeaderText="Total Quantity"
                  ItemStyle-Width="150"
                  SortExpression="Quantity"
                />
                <asp:BoundField
                  DataField="Price"
                  HeaderText="Item Price"
                  ItemStyle-Width="30"
                  SortExpression="Price"
                />
                <asp:BoundField
                  DataField="LastOrderDate"
                  HeaderText="Last Order"
                  ItemStyle-Width="150"
                  SortExpression="LastOrderDate"
                />
                <asp:BoundField
                  DataField="Status"
                  HeaderText="Status"
                  ItemStyle-Width="30"
                  SortExpression="Status"
                />
                <asp:BoundField
                  DataField="SupplierID"
                  HeaderText="Supplier ID"
                  ItemStyle-Width="150"
                  SortExpression="SupplierID"
                />
                <asp:BoundField
                  DataField="Comments"
                  HeaderText="Comments"
                  ItemStyle-Width="150"
                />
              </Columns>
            </asp:GridView>
          </div>
          <!-- End Inventory Table Section -->
        </div>
      </div>
      <!-- End Table Management Section -->
      <!-- Start Footer -->
      <footer id="main-footer" class="bg-dark text-white fixed-bottom p-0">
        <div class="container">
          <div class="row">
            <div class="col">
              <p class="lead text-center">
                Copyright &copy; <span id="year"></span>
                Abyssal Technology Solutions
              </p>
            </div>
          </div>
        </div>
      </footer>
      <!-- End Footer -->
    </form>
  </body>
</html>
