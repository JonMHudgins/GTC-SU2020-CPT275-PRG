<%@ Page Language="C#" AutoEventWireup="true" CodeFile="purchaseorders.aspx.cs"
Inherits="purchaseorders" %>

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
    <title>IMS || Purchase Orders</title>
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
                <a href="inventory.aspx" class="nav-link">Inventory</a>
              </li>
              <li class="nav-item px-2">
                <a href="purchaseorders.aspx" class="nav-link active"
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
                  <i class="fas fa-user"></i>Welcome
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
      <header id="main-header" class="py-2 bg-success text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1><i class="fa fa-shopping-cart"></i> Purchase Orders</h1>
            </div>
          </div>
        </div>
      </header>
      <!-- End Header -->
      <!-- Start Actions Section -->
      <div class="container my-5">
        <div class="row my-2">
          <div class="col-xs-3 mb-2 mx-auto">
            <div class="input-group">
              <div class="input-group-prepend">
                <label
                  for="orderidtxt"
                  class="input-group-text bg-success text-white"
                  >Order ID P-</label
                >
              </div>
              <asp:TextBox
                ID="orderidxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="OrderIDSearch"
                runat="server"
                CssClass="btn btn-success input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <div class="col-xs-3 mb-2 mx-auto">
            <div class="input-group">
              <div class="input-group-prepend">
                <label
                  for="employeeidtxt"
                  class="input-group-text bg-success text-white"
                  >Employee ID E-</label
                >
              </div>
              <asp:TextBox
                ID="employeeidtxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="EmployeeIDSearch"
                runat="server"
                CssClass="btn btn-success input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <div class="col-xs-3 mb-2 mx-auto">
            <div class="input-group px-0">
              <div class="input-group-prepend">
                <label
                  for="employeenametxt"
                  class="input-group-text bg-success text-white"
                  >Employee Name</label
                >
              </div>
              <asp:TextBox
                ID="employeenametxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="NameSearch"
                runat="server"
                CssClass="btn btn-success input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <div class="col-xs-3 mb-2 mx-auto">
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
              ID="RadDel"
              runat="server"
              GroupName="status"
              Text="Delivered"
              AutoPostBack="true"
              OnCheckedChanged="RadDel_CheckedChanged"
            />
            <asp:RadioButton
              ID="RadNotDel"
              runat="server"
              GroupName="status"
              Text="Not Delivered"
              AutoPostBack="true"
              OnCheckedChanged="RadNotDel_CheckedChanged"
            />
          </div>
        </div>
      </div>
      <!-- End Actions Section -->
      <!-- Start Table Section -->
      <div class="container">
        <div class="row">
          <div class="col-sm-9 mx-auto">
            <asp:GridView
              ID="PurchaseOrdersGridView"
              runat="server"
              AllowPaging="True"
              AllowSorting="True"
              AutoGenerateColumns="false"
              emptydatatext="No data available."
              DataKeyNames="PurchID"
              OnSorting="ItemLookUp_Sorting"
              OnPageIndexChanging="OnPageIndexChanging"
              PageSize="10"
              OnRowCommand="GridView1_OnRowCommand"
              CssClass="table table-striped"
            >
              <Columns>
                <asp:BoundField
                  DataField="PurchID"
                  HeaderText="Purchase Order ID"
                  ItemStyle-Width="150"
                  SortExpression="PurchID"
                />
                <asp:BoundField
                  DataField="EmployeeID"
                  HeaderText="Employee ID"
                  ItemStyle-Width="150"
                  sortexpression="EmployeeID"
                />
                <asp:BoundField
                  DataField="Name"
                  HeaderText="Creator"
                  ItemStyle-Width="150"
                  sortexpression="Name"
                />
                <asp:BoundField
                  DataField="DateOrdered"
                  HeaderText="Ordered Date"
                  ItemStyle-Width="150"
                  sortexpression="DateOrdered"
                />
                <asp:BoundField
                  DataField="DateDelivered"
                  HeaderText="Delivered Date"
                  ItemStyle-Width="150"
                  sortexpression="DateDelivered"
                  NullDisplayText="Not yet delivered"
                />

                <asp:ButtonField
                  ButtonType="Button"
                  Text="Details"
                  CommandName="Details"
                />
              </Columns>
            </asp:GridView>
          </div>
        </div>
      </div>
      <!-- End Table Section -->
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
