<%@ Page Language="C#" AutoEventWireup="true" CodeFile="employees.aspx.cs"
Inherits="employees" %>

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
    <title>IMS || Employees</title>
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
                <a href="employees.aspx" class="nav-link active">Employees</a>
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
      <header id="main-header" class="py-2 bg-warning text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1><i class="fas fa-users"></i> Employees</h1>
            </div>
          </div>
        </div>
      </header>
      <!-- End Header -->

      <!-- Start Table Management Section -->
      <div class="container my-5">
        <div class="card">
          <div class="card-body">
            <div class="card-header">
              <!-- Start Column Selector Section -->
              <div class="row align-items-center">
                <div class="col-md-2">
                  <div class="card">
                    <div class="card-header py-1">
                      <header class="h5">Columns</header>
                    </div>
                    <div class="card-body">
                      <div class="form-group">
                        <asp:CheckBoxList
                          ID="ColumnCheckBoxList"
                          runat="server"
                          AutoPostBack="True"
                          OnSelectedIndexChanged="Check_Clicked"
                          CssClass="asp-checklist ml-2"
                          Width="100%"
                        >
                          <asp:ListItem Value="2">Admin</asp:ListItem>
                          <asp:ListItem Value="3">Department Info</asp:ListItem>
                          <asp:ListItem Value="5">Phone</asp:ListItem>
                          <asp:ListItem Value="6">Email</asp:ListItem>
                          <asp:ListItem Value="7">Home Address</asp:ListItem>
                          <asp:ListItem Value="8">Last Login</asp:ListItem>
                        </asp:CheckBoxList>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Column Selector Section -->
                <!-- Start Actions Section -->
                <div class="col-md-10">
                  <div class="row my-3">
                    <div class="col-xs-6 mx-auto">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="employeeidtxt"
                            class="input-group-text bg-warning text-white"
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
                          Text="Search Employee ID"
                          CssClass="btn btn-warning input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                    <div class="col-xs-6 mx-auto">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="employeenametxt"
                            class="input-group-text bg-warning text-white"
                            >Employee Name</label
                          >
                        </div>
                        <asp:TextBox
                          ID="employeenametxt"
                          runat="server"
                          CssClass="input-group-text"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="EmployeeNameSearch"
                          runat="server"
                          Text="Search Employee Name"
                          CssClass="btn btn-warning input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                  </div>
                  <div class="row my-3">
                    <div class="col-xs-6 mx-auto">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="departidtxt"
                            class="input-group-text bg-warning text-white"
                            >Department ID D-</label
                          >
                        </div>
                        <asp:TextBox
                          ID="departidtxt"
                          runat="server"
                          CssClass="input-group-text"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="DepartIDSearch"
                          runat="server"
                          Text="Search Department ID"
                          CssClass="btn btn-warning input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                    <div class="col-xs-6 mx-auto">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="departnametxt"
                            class="input-group-text bg-warning text-white"
                            >Department Name</label
                          >
                        </div>
                        <asp:TextBox
                          ID="departnametxt"
                          runat="server"
                          CssClass="input-group-text"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="DepartNameSearch"
                          runat="server"
                          Text="Search Department Name"
                          CssClass="btn btn-warning input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                  </div>
                  <!-- Start Admin Filter Section -->
                  <div class="row my-3">
                    <div class="col-md-6 mx-auto">
                      <!-- div section for all radio buttons to filter for admins or not admins-->
                      <asp:RadioButton
                        ID="RadBoth"
                        runat="server"
                        GroupName="adminstatus"
                        Text="Both"
                        AutoPostBack="true"
                        OnCheckedChanged="RadBoth_CheckedChanged"
                      />
                      <asp:RadioButton
                        ID="RadAdmin"
                        runat="server"
                        GroupName="adminstatus"
                        Text="Only Admins"
                        AutoPostBack="true"
                        OnCheckedChanged="RadAdmin_CheckedChanged"
                      />
                      <asp:RadioButton
                        ID="RadNonAdmin"
                        runat="server"
                        GroupName="adminstatus"
                        Text="Only NonAdmins"
                        AutoPostBack="true"
                        OnCheckedChanged="RadNonAdmin_CheckedChanged"
                      />
                    </div>
                  </div>
                </div>
                <!-- End Admin Filter Section -->
                <!-- End Actions Section -->
              </div>
            </div>
            <!-- Start Employee Table Section -->
            <div class="card-body mx-auto">
              <!-- Table using asp GridView and connecting to database  This will also serve as the default style for now, Allows for sorting and paging.-->
              <asp:GridView
                ID="EmployeeGridView"
                runat="server"
                AllowPaging="True"
                AllowSorting="True"
                AutoGenerateColumns="false"
                emptydatatext="No data available."
                OnSorting="ItemLookUp_Sorting"
                OnPageIndexChanging="OnPageIndexChanging"
                PageSize="10"
                CssClass="table table-striped"
              >
                <Columns>
                  <asp:TemplateField
                    HeaderText="Employee ID"
                    SortExpression="ID"
                  >
                    <ItemTemplate>
                      <%# Eval("ID") %>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField
                    DataField="Name"
                    HeaderText="Name"
                    sortexpression="Name"
                  />
                  <asp:BoundField
                    DataField="Admin"
                    HeaderText="Admin"
                    SortExpression="Admin"
                  />
                  <asp:BoundField
                    DataField="DepartmentID"
                    HeaderText="Department ID"
                    SortExpression="DepartmentID"
                  />
                  <asp:BoundField
                    DataField="DepartmentName"
                    HeaderText="Department Name"
                    SortExpression="DepartmentName"
                  />
                  <asp:BoundField
                    DataField="Phone"
                    HeaderText="Phone"
                    sortexpression="Phone"
                  />
                  <asp:BoundField
                    DataField="Email"
                    HeaderText="Email"
                    sortexpression="Email"
                  />
                  <asp:BoundField
                    DataField="Address"
                    HeaderText="Home Address"
                    sortexpression="Address"
                  />
                  <asp:BoundField
                    DataField="LastLogged"
                    HeaderText="Last Login"
                    SortExpression="LastLogged"
                  />
                </Columns>
              </asp:GridView>
            </div>
            <!-- End Employee Table Section -->
          </div>
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
