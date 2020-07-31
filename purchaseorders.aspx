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
            <i class="fas fa-archive"></i> I<small>nventory</small> M<small
              >anagement</small
            >
            S<small>olutions</small>
          </a>
          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#navbarCollapse"
            aria-controls="navbarCollapse"
            aria-expanded="false"
            aria-label="Toggle navigation"
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
              <li class="nav-item px-2" runat="server" id="employeenav" visible="false">
                <a href="employees.aspx" class="nav-link">Employees</a>
              </li>
              <li class="nav-item px-2" runat="server" id="departmentnav" visible="false">
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
      <!-- Start Table Management Section -->
      <div class="container mt-5">
        <div class="card mb-5">
          <div class="card-header">
            <div class="row align-items-center">
              <!-- Start Search Section -->
              <div class="col-xs-6 mx-auto">
                <div class="card">
                  <div class="card-body">
                    <!-- Order ID Search Box -->
                    <div class="form-group">
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
                          CssClass="form-control"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="OrderIDSearch"
                          runat="server"
                          CssClass="btn btn-success input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>

                    <!-- Employee ID Search Box -->
                    <div class="form-group">
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
                          CssClass="form-control"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="EmployeeIDSearch"
                          runat="server"
                          CssClass="btn btn-success input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>

                    <!-- Employee Name Search Box -->
                    <div class="form-group">
                      <div class="input-group">
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
                          CssClass="form-control"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="NameSearch"
                          runat="server"
                          CssClass="btn btn-success input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                    <hr />
                    <!-- Delivered Filter Check Boxes -->
                    <div class="form-group">
                      <div class="form-check form-check-inline">
                        <asp:CheckBox
                          ID="Delivered"
                          runat="server"
                          AutoPostBack="True"
                          Checked="True"
                          OnCheckedChanged="ShowDeliver_CheckedChanged"
                          CssClass="form-check-input"
                        />
                        <label for="Delivered" class="form-check-label"
                          >Delivered</label
                        >
                      </div>
                      <div class="form-check form-check-inline">
                        <asp:CheckBox
                          ID="NotDelivered"
                          runat="server"
                          AutoPostBack="True"
                          Checked="True"
                          OnCheckedChanged="ShowDeliver_CheckedChanged"
                          CssClass="form-check-input"
                        />
                        <label for="NotDelivered" class="form-check-label"
                          >Not Delivered</label
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Search Section -->
            </div>
          </div>
          <!-- Start Purchase Order Table -->
          <div class="card-body mx-auto">
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
              HeaderStyle-CssClass="thead-dark"
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
                  ControlStyle-CssClass="btn btn-outline-success"
                />
                  <asp:TemplateField>
                      <ItemTemplate>
                          <asp:Button ID="btnDeliv" runat="server" Text="Delivered" Visible='<%# string.IsNullOrEmpty(Eval("DateDelivered").ToString())%>' CommandName="ConfDeliv" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
          <!-- End Purchase Order Table -->
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
    <!-- Start Script Section -->
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
      integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
      crossorigin="anonymous"
    ></script>
    <script>
      // Get the current year for the copyright
      $('#year').text(new Date().getFullYear());
    </script>
    <!-- End Script Section -->
  </body>
</html>
