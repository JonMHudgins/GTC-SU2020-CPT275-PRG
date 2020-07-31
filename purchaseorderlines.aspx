<%@ Page Language="C#" AutoEventWireup="true"
CodeFile="purchaseorderlines.aspx.cs" Inherits="purchaseorderlines" %>

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
    <title>IMS || Purchase Order</title>
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
              <!-- Start Order Information Section -->
              <div class="col-sm-6 mx-auto">
                <div class="card">
                  <div class="card-body">
                    <!-- Start Purchase ID Label -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="LabOrderID"
                            class="input-group-text bg-success text-white"
                            >Purchase ID</label
                          >
                        </div>
                        <asp:Label
                          ID="LabOrderID"
                          runat="server"
                          Text=""
                          CssClass="form-control"
                        ></asp:Label>
                      </div>
                    </div>
                    <!-- End Purchase ID Label -->
                    <!-- Start Order Creator Label -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="LabOrderer"
                            class="input-group-text bg-success text-white"
                            >Order Creator</label
                          >
                        </div>
                        <asp:Label
                          ID="LabOrderer"
                          runat="server"
                          Text=""
                          CssClass="form-control"
                        ></asp:Label>
                      </div>
                    </div>
                    <!-- End Order Creator Label -->
                    <!-- Start Date Ordered Label -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="LabODate"
                            class="input-group-text bg-success text-white"
                            >Ordered</label
                          >
                        </div>
                        <asp:Label
                          ID="LabODate"
                          runat="server"
                          Text=""
                          CssClass="form-control"
                        ></asp:Label>
                      </div>
                    </div>
                    <!-- End Date Ordered Label -->
                    <!-- Start Date Delivered Label -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="LabDDate"
                            class="input-group-text bg-success text-white"
                            >Delivered</label
                          >
                        </div>
                        <asp:Label
                          ID="LabDDate"
                          runat="server"
                          Text="N/A"
                          CssClass="form-control"
                        ></asp:Label>
                      </div>
                    </div>
                    <!-- End Date Delivered Label -->
                  </div>
                </div>
              </div>
              <!-- End Order Information Section -->
              <!-- Start Search Section -->
              <div class="col-xs-6 mx-auto">
                <div class="card">
                  <div class="card-body">
                    <!-- Item SKU Search Box -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="skutxt"
                            class="input-group-text bg-success text-white"
                            >Item SKU | I-</label
                          >
                        </div>
                        <asp:TextBox
                          ID="skutxt"
                          runat="server"
                          CssClass="form-control"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="SKUSearch"
                          runat="server"
                          Text="Search SKU"
                          CssClass="btn btn-success input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>

                    <!-- Item Name Search Box -->
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <label
                            for="itemname"
                            class="input-group-text bg-success text-white"
                            >Item Name</label
                          >
                        </div>
                        <asp:TextBox
                          ID="itemnametxt"
                          runat="server"
                          CssClass="form-control"
                        ></asp:TextBox>
                        <asp:LinkButton
                          OnClick="NameSearch"
                          runat="server"
                          Text="Search Item Name"
                          CssClass="btn btn-success input-group-append"
                          ><i class="fa fa-search fa-lg align-self-center"></i
                        ></asp:LinkButton>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- Start Purchase Order Lines Table -->
          <div class="card-body mx-auto">
            <asp:GridView
              ID="PurchaseOrderLinesGridView"
              runat="server"
              AllowPaging="True"
              AllowSorting="True"
              AutoGenerateColumns="false"
              emptydatatext="No data available."
              OnSorting="ItemLookUp_Sorting"
              OnPageIndexChanging="OnPageIndexChanging"
              PageSize="10"
              CssClass="table table-striped"
              HeaderStyle-CssClass="thead-dark"
            >
              <Columns>
                <asp:TemplateField
                  ItemStyle-Width="150px"
                  HeaderText="Purchase Line ID"
                  SortExpression="PurchID"
                  Visible="False"
                >
                  <ItemTemplate>
                    <%# Eval("PurchID") %>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField
                  DataField="SKU"
                  HeaderText="SKU"
                  ItemStyle-Width="150"
                  sortexpression="SKU"
                />
                <asp:BoundField
                  DataField="ItemName"
                  HeaderText="Item Name"
                  ItemStyle-Width="150"
                  SortExpression="ItemName"
                />
                <asp:BoundField
                  DataField="Quantity"
                  HeaderText="Quantity Ordered"
                  ItemStyle-Width="150"
                  sortexpression="Quantity"
                />
                <asp:BoundField
                  DataField="Cost"
                  HeaderText="Total Price"
                  ItemStyle-Width="150"
                  sortexpression="Cost"
                />

                <asp:ButtonField
                  ButtonType="Button"
                  Text="Details"
                  CommandName="Details"
                  ControlStyle-CssClass="btn btn-outline-success"
                />
              </Columns>
            </asp:GridView>
          </div>
          <!-- End Purchase Order Lines Table -->
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
