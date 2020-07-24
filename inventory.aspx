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
            <!-- div section for all radio buttons to filter for active or inactive items -->
         
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
                    <div class="asp-checklist ml-3">
                  
                    <br />
                    <asp:CheckBox ID="Location1" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Location1">LocationID</label> <br />
                    <asp:CheckBox ID="Hand2" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Hand2">On Hand Quantity</label> <br />
                    <asp:CheckBox ID="Total3" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Total3">Total Quantity</label> <br />
                    <asp:CheckBox ID="Price4" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Price4">Price</label><br />
                    <asp:CheckBox ID="Last5" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Last5">Last Order Date</label> <br />
                    <asp:CheckBox ID="Status6" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Status6">Status</label> <br />
                    <asp:CheckBox ID="Supplier7" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Supplier7">Supplier</label> <br />
                    <asp:CheckBox ID="Comments8" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ColumnShow_CheckedChanged" />
                    <label for="Comments8">Comments</label> <br />

                    <hr />

                    <asp:CheckBox ID="Active" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ShowStatus_CheckedChanged" />
                    <label for="Active">Active</label> <br />
                    <asp:CheckBox ID="Inactive" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="ShowStatus_CheckedChanged" />
                    <label for="Inactive">Inactive</label> <br />
                    </div>
                    </div>
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
              HeaderStyle-CssClass="thead-dark"
            HeaderStyle-Wrap="False">
              <Columns>
                <asp:BoundField 
                  DataField="SKU"
                  HeaderText="SKU"
                    
                  SortExpression="SKU"
                      />
                <asp:BoundField
                  DataField="ItemName"
                  HeaderText="Item Name"
                  SortExpression="ItemName"
                />
                <asp:BoundField
                  DataField="LocationID"
                  HeaderText="Location ID"
                  SortExpression="LocationID"
                />
                <asp:BoundField
                  DataField="OnHand"
                  HeaderText="On Hand Quantity"
                  SortExpression="OnHand"
                />
                <asp:BoundField
                  DataField="Quantity"
                  HeaderText="Total Quantity"
                  SortExpression="Quantity"
                />
                <asp:BoundField
                  DataField="Price"
                  HeaderText="Item Price"
                  SortExpression="Price"
                />
                <asp:BoundField
                  DataField="LastOrderDate"
                  HeaderText="Last Order"
                  SortExpression="LastOrderDate"
                />
                <asp:BoundField
                  DataField="Status"
                  HeaderText="Status"
                  SortExpression="Status"
                />
                <asp:BoundField
                  DataField="SupplierID"
                  HeaderText="Supplier ID"
                  SortExpression="SupplierID"
                />
                <asp:BoundField
                  DataField="Comments"
                  HeaderText="Comments"
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
