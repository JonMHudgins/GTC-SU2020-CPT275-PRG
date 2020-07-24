<%@ Page Language="C#" AutoEventWireup="true" CodeFile="departments.aspx.cs"
Inherits="departments" %>

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
    <title>IMS || Departments</title>
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
                <a href="purchaseorders.aspx" class="nav-link"
                  >Purchase Orders</a
                >
              </li>
              <li class="nav-item px-2">
                <a href="employees.aspx" class="nav-link">Employees</a>
              </li>
              <li class="nav-item px-2">
                <a href="departments.aspx" class="nav-link active"
                  >Departments</a
                >
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
      <header id="main-header" class="py-2 bg-danger text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1><i class="fas fa-building"></i> Departments</h1>
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
                  for="departidtxt"
                  class="input-group-text bg-danger text-white"
                  >Department ID D-</label
                >
              </div>
              <asp:TextBox
                ID="departidxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="DepartIDSearch"
                runat="server"
                Text="Search Department ID"
                CssClass="btn btn-danger input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
          <div class="col-xs-3 mb-2 mx-auto">
            <div class="input-group">
              <div class="input-group-prepend">
                <label
                  for="departnametxt"
                  class="input-group-text bg-danger text-white"
                  >Department Name</label
                >
              </div>
              <asp:TextBox
                ID="departnametxt"
                runat="server"
                CssClass="input-group-text"
              ></asp:TextBox>
              <asp:LinkButton
                OnClick="NameSearch"
                runat="server"
                Text="Search Department Name"
                CssClass="btn btn-danger input-group-append"
                ><i class="fa fa-search fa-lg align-self-center"></i
              ></asp:LinkButton>
            </div>
          </div>
        </div>
      </div>
      <!-- End Actions Section -->
      <!-- Start Table Section -->
      <div class="container">
        <div class="row">
          <div class="col-sm-4 mx-auto">
            <asp:GridView
              ID="DepartmentsGridView"
              runat="server"
              AllowPaging="True"
              AllowSorting="True"
              AutoGenerateColumns="false"
              emptydatatext="No data available."
              DataKeyNames="DepartmentID"
              OnSorting="ItemLookUp_Sorting"
              OnPageIndexChanging="OnPageIndexChanging"
              PageSize="10"
              OnRowCommand="GridView1_OnRowCommand"
              CssClass="table table-striped"
              HeaderStyle-CssClass="thead-dark"
            >
              <Columns>
                <asp:BoundField
                  DataField="DepartmentID"
                  HeaderText="Department ID"
                  ItemStyle-Width="150"
                  SortExpression="DepartmentID"
                />
                <asp:BoundField
                  DataField="DepartmentName"
                  HeaderText="Department Name"
                  ItemStyle-Width="150"
                  sortexpression="DepartmentName"
                />

                <asp:ButtonField
                  ButtonType="Button"
                  Text="Employees"
                  CommandName="Employees"
                  ControlStyle-CssClass="btn btn-outline-danger"
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
