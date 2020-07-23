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
      <div>
        <asp:Label ID="LabOrdedID" runat="server" Text=""></asp:Label>
        <asp:Label ID="LabOrderer" runat="server" Text=""></asp:Label>
        <asp:Label ID="LabODate" runat="server" Text=""></asp:Label>
        <asp:Label ID="LabDDate" runat="server" Text=""></asp:Label>
      </div>

      <br />

      <div>
        <!-- div section for both search textboxes and submit buttons-->

        <label for="skutxt">Item SKU:</label><br />
        <asp:Label ID="skulab" runat="server" Text="I-"></asp:Label>
        <asp:TextBox ID="skutxt" runat="server"></asp:TextBox>
        <asp:Button OnClick="SKUSearch" runat="server" Text="Search SKU" />

        <br />

        <label for="itemname">Item Name:</label><br />

        <asp:TextBox ID="itemnametxt" runat="server"></asp:TextBox>
        <asp:Button
          OnClick="NameSearch"
          runat="server"
          Text="Search Item Name"
        />
      </div>
      <br />

      <div>
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
            />
          </Columns>
        </asp:GridView>
      </div>
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
