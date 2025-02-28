﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs"
Inherits="index" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <meta charset="UTF-8" />
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
    <title>IMS || Dashboard</title>
  </head>
  <body>
    <!-- START HERE -->
    <form runat="server">
      <asp:ScriptManager
        ID="ScriptManager"
        runat="server"
        EnablePartialRendering="true"
      />
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
                <a href="index.aspx" class="nav-link active">Dashboard</a>
              </li>
              <li class="nav-item px-2">
                <a href="inventory.aspx" class="nav-link">Inventory</a>
              </li>
              <li class="nav-item px-2">
                <a href="purchaseorders.aspx" class="nav-link"
                  >Purchase Orders</a
                >
              </li>
              <li
                class="nav-item px-2"
                runat="server"
                id="employeenav"
                visible="false"
              >
                <a href="employees.aspx" class="nav-link">Employees</a>
              </li>
              <li
                class="nav-item px-2"
                runat="server"
                id="departmentnav"
                visible="false"
              >
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
                    <i class="fas fa-user-circle"></i> Profile
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
      <header id="main-header" class="py-2 bg-light">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1><i class="fas fa-cog"></i>Dashboard</h1>
            </div>
          </div>
        </div>
      </header>
      <!-- End Header -->
      <!-- Start Actions Section -->
      <section id="actions" class="py-4 mb-4">
        <div class="container">
          <div class="row">
            <div class="col-md-3">
              <a
                href="#"
                class="btn btn-primary btn-block mb-2"
                data-toggle="modal"
                data-target="#newItemModal"
              >
                <i class="fas fa-plus"></i>New Inventory Item
              </a>
            </div>
            <div class="col-md-3">
              <a
                href="#"
                class="btn btn-success btn-block mb-2"
                data-toggle="modal"
                data-target="#addPOModal"
              >
                <i class="fas fa-plus"></i>New Purchase Order
              </a>
            </div>
            <div
              class="col-md-3"
              runat="server"
              id="openemployeemodal"
              visible="false"
            >
              <a
                href="#"
                class="btn btn-warning btn-block mb-2"
                data-toggle="modal"
                data-target="#addEmployeeModal"
              >
                <i class="fas fa-plus"></i>New Employee
              </a>
            </div>
            <div
              class="col-md-3"
              runat="server"
              id="opendepartmodal"
              visible="false"
            >
              <a
                href="#"
                class="btn btn-danger btn-block"
                data-toggle="modal"
                data-target="#addDepartmentModal"
              >
                <i class="fas fa-plus"></i>New Department
              </a>
            </div>
          </div>
        </div>
      </section>
      <!-- End Actions Section -->
      <!-- Start Recent Purchase Orders -->
      <section id="RPOs">
        <div class="container">
          <div class="row">
            <div class="col-md-9">
              <div class="card">
                <div class="card-header">
                  <h4>Recent Purchase Orders</h4>
                </div>
                <asp:GridView
                  ID="IndexGridView"
                  runat="server"
                  AutoGenerateColumns="false"
                  EmptyDataText="No data available."
                  DataKeyNames="PurchID"
                  OnRowCommand="GridView1_OnRowCommand"
                  CssClass="table table-striped"
                  ShowHeader="true"
                  GridLines="None"
                  CellSpacing="-1"
                  DataSourceID=""
                >
                  <HeaderStyle CssClass="thead-dark" />
                  <Columns>
                    <asp:TemplateField HeaderText="#">
                      <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PurchID" HeaderText="ID" />

                    <asp:BoundField DataField="Name" HeaderText="Creator" />
                    <asp:BoundField
                      DataField="DateOrdered"
                      HeaderText="Ordered Date"
                      DataFormatString="{0:MMM d, yyyy}"
                    />

                    <asp:ButtonField
                      ButtonType="Link"
                      Text="<i class='fas fa-angle-double-right'></i> Details"
                      CommandName="Details"
                      ControlStyle-CssClass="btn btn-secondary"
                    />
                  </Columns>
                </asp:GridView>
              </div>
            </div>
            <div class="col-lg-3 d-none d-lg-block">
              <div class="card text-center bg-primary text-white mb-3">
                <div class="card-body">
                  <h3>Inventory</h3>
                  <h4 class="display-4"><i class="fas fa-archive"></i></h4>
                  <a href="inventory.aspx" class="btn btn-outline-light btn-sm"
                    >View</a
                  >
                </div>
              </div>
              <div class="card text-center bg-success text-white mb-3">
                <div class="card-body">
                  <h3>Purchase Orders</h3>
                  <h4 class="display-4">
                    <i class="fas fa-shopping-cart"></i>
                  </h4>
                  <a
                    href="purchaseorders.aspx"
                    class="btn btn-outline-light btn-sm"
                    >View</a
                  >
                </div>
              </div>
              <div
                class="card text-center bg-warning mb-5"
                runat="server"
                id="blockopenemployees"
                visible="false"
              >
                <div class="card-body">
                  <h3>Employees</h3>
                  <h4 class="display-4"><i class="fas fa-users"></i></h4>
                  <a href="employees.aspx" class="btn btn-outline-dark btn-sm"
                    >View</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- End Recent Purchase Orders -->
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
      <!-- Start Modals -->
      <!-- Start Inventory Item Modal -->
      <div class="modal fade" id="newItemModal">
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header bg-primary text-white">
              <h5 class="modal-title">New Inventory Item</h5>
              <button class="close" data-dismiss="modal">
                <span>&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="itemSKUTxt"
                      class="input-group-text bg-primary text-white"
                    >
                      SKU I-</label
                    >
                  </div>
                  <asp:TextBox
                    ID="itemSKUTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="itemNameTxt"
                      class="input-group-text bg-primary text-white"
                    >
                      Item Name</label
                    >
                  </div>
                  <asp:TextBox
                    ID="itemNameTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="itemQTYTxt"
                      class="input-group-text bg-primary text-white"
                    >
                      Quantity</label
                    >
                  </div>
                  <asp:TextBox
                    ID="itemQTYTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="itemQOHTxt"
                      class="input-group-text bg-primary text-white"
                    >
                      Quantity on Hand</label
                    >
                  </div>
                  <asp:TextBox
                    ID="itemQOHTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="itemPriceTxt"
                      class="input-group-text bg-primary text-white"
                    >
                      Price</label
                    >
                  </div>
                  <asp:TextBox
                    ID="itemPriceTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="DropDownListsupplier"
                      class="input-group-text bg-primary text-white"
                    >
                      Supplier</label
                    >
                  </div>
                  <asp:UpdatePanel ID="NSupUpdatePanel" runat="server">
                    <ContentTemplate>
                      <asp:DropDownList
                        ID="DropDownListsupplier"
                        runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="DropDownListsupplier_SelectedIndexChanged"
                      ></asp:DropDownList>
                      <asp:Panel ID="NSupPanel" runat="server" Visible="false">
                        <div class="form-group">
                          <div class="input-group">
                            <div class="input-group-prepend">
                              <label
                                for="supNameTxt"
                                class="input-group-text bg-primary text-white"
                              >
                                Name</label
                              >
                            </div>
                            <asp:TextBox
                              ID="supNameTxt"
                              runat="server"
                              CssClass="form-control"
                            ></asp:TextBox>
                          </div>
                        </div>
                        <asp:RequiredFieldValidator
                          ID="SupNameValid"
                          runat="server"
                          ErrorMessage="Supplier name required"
                          ControlToValidate="supNameTxt"
                        ></asp:RequiredFieldValidator>
                        <div class="form-group">
                          <div class="input-group">
                            <div class="input-group-prepend">
                              <label
                                for="supPhoneTxt"
                                class="input-group-text bg-primary text-white"
                              >
                                Phone</label
                              >
                            </div>
                            <asp:TextBox
                              ID="supPhoneTxt"
                              runat="server"
                              CssClass="form-control"
                            ></asp:TextBox>
                          </div>
                        </div>
                        <asp:RegularExpressionValidator
                          ID="PhoneRegexValid"
                          runat="server"
                          ErrorMessage="Phone number not proper format"
                          ControlToValidate="supPhoneTxt"
                          ValidationExpression="^[2-9]\d{2}-\d{3}-\d{4}$"
                        ></asp:RegularExpressionValidator>
                        <div class="form-group">
                          <div class="input-group">
                            <div class="input-group-prepend">
                              <label
                                for="supEmailTxt"
                                class="input-group-text bg-primary text-white"
                              >
                                Email</label
                              >
                            </div>
                            <asp:TextBox
                              ID="supEmailTxt"
                              runat="server"
                              CssClass="form-control"
                            ></asp:TextBox>
                          </div>
                        </div>
                        <asp:RegularExpressionValidator
                          ID="EmailRegexValid"
                          runat="server"
                          ErrorMessage="Email not in proper format"
                          ControlToValidate="supEmailTxt"
                          ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                        ></asp:RegularExpressionValidator>
                      </asp:Panel>
                    </ContentTemplate>
                  </asp:UpdatePanel>
                </div>
              </div>
              <div class="form-group">
                <label for="comments">Comments</label>
                <asp:TextBox
                  ID="itemCommentsTxt"
                  runat="server"
                  TextMode="MultiLine"
                  Wrap="True"
                  Rows="4"
                  Style="white-space: pre-wrap;"
                  CssClass="form-control"
                ></asp:TextBox>
              </div>
            </div>
            <div class="modal-footer">
              <asp:UpdatePanel ID="IUpdatePanel" runat="server">
                <ContentTemplate>
                  <asp:Label
                    ID="itemstatuslabel"
                    runat="server"
                    Text=""
                    Visible="false"
                  ></asp:Label>
                  <asp:Button
                    ID="createItemButton"
                    runat="server"
                    Text="Create"
                    class="btn btn-success"
                    OnClick="createItemButton_Click"
                  />
                </ContentTemplate>
              </asp:UpdatePanel>
              <asp:Button
                ID="cancelItemButton"
                runat="server"
                Text="Cancel"
                class="btn btn-danger"
                data-dismiss="modal"
              />
            </div>
          </div>
        </div>
      </div>
      <!-- End Inventory Item Modal -->
      <!-- Start Purchase Order Modal -->
      <div class="modal fade" id="addPOModal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header bg-success text-white">
              <h5 class="modal-title">New Purchase Order</h5>
              <button class="close" data-dismiss="modal">
                <span>&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <asp:UpdatePanel ID="POUpdatePanel" runat="server">
                <ContentTemplate>
                  <div class="form-group">
                    <div class="input-group">
                      <asp:TextBox
                        ID="SearchText"
                        runat="server"
                        CssClass="form-control"
                      ></asp:TextBox>
                      <asp:LinkButton
                        ID="Search"
                        runat="server"
                        Text="Search"
                        OnClick="Search_Click"
                        CssClass="btn btn-success input-group-append mr-5"
                        ><i class="fa fa-search fa-lg align-self-center"></i
                      ></asp:LinkButton>
                      <div class="input-group-prepend ml-5">
                        <label
                          for="QuantityText"
                          class="input-group-text bg-success text-white"
                        >
                          Quantity:
                        </label>
                      </div>

                      <asp:TextBox
                        ID="QuantityText"
                        runat="server"
                      ></asp:TextBox>
                    </div>

                    <asp:GridView
                      ID="GridViewItem"
                      runat="server"
                      DataKeyNames="SKU"
                      AutoGenerateColumns="false"
                      OnSelectedIndexChanged="GridViewItem_SelectedIndexChanged"
                      AllowPaging="true"
                      AllowSorting="true"
                      OnPageIndexChanging="GridViewItem_PageIndexChanging"
                      EmptyDataText="No data available."
                      OnSorting="GridViewItem_Sorting"
                      AutoGenerateSelectButton="True"
                      PageSize="3"
                      CssClass="table table-striped mt-3"
                      HeaderStyle-CssClass="thead-dark"
                      HeaderStyle-ForeColor="White"
                      HeaderStyle-Wrap="False"
                    >
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
                          DataField="SupplierID"
                          HeaderText="Supplier ID"
                          SortExpression="SupplierID"
                        />
                        <asp:BoundField
                          DataField="LastOrderDate"
                          HeaderText="Last Order"
                          SortExpression="LastOrderDate"
                        />
                        <asp:BoundField
                          DataField="Price"
                          HeaderText="Item Price"
                          SortExpression="Price"
                        />
                      </Columns>
                      <SelectedRowStyle BackColor="LightCoral" />
                    </asp:GridView>

                    <asp:Button
                      ID="AddItemButton"
                      runat="server"
                      Text="Add Item"
                      OnClick="AddItemButton_Click"
                      Enabled="False"
                      CssClass="btn btn-success d-flex ml-auto"
                    />
                  </div>
                  <hr />
                  <div class="form-group">
                    <asp:GridView
                      ID="GridViewOrder"
                      runat="server"
                      DataKeyNames="SKU"
                      AutoGenerateColumns="false"
                      OnSelectedIndexChanged="GridViewOrder_SelectedIndexChanged"
                      AllowSorting="true"
                      OnSorting="GridViewOrder_Sorting"
                      AutoGenerateSelectButton="True"
                      ShowHeaderWhenEmpty="True"
                      CssClass="table table-striped"
                      HeaderStyle-ForeColor="White"
                      HeaderStyle-CssClass="thead-dark"
                      HeaderStyle-Wrap="False"
                    >
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
                          DataField="SupplierID"
                          HeaderText="Supplier ID"
                          SortExpression="SupplierID"
                        />
                        <asp:BoundField
                          DataField="Quantity"
                          HeaderText="Quantity"
                          SortExpression="Quantity"
                        />
                        <asp:BoundField
                          DataField="Price"
                          HeaderText="Item Price"
                          SortExpression="Price"
                        />
                      </Columns>
                      <SelectedRowStyle BackColor="LightCoral" />
                      <EmptyDataTemplate>
                        No Items Added to Purchase Order
                      </EmptyDataTemplate>
                    </asp:GridView>

                    <div class="input-group">
                      <asp:Button
                        ID="DeleteBtn"
                        runat="server"
                        Text="Delete"
                        OnClick="DeleteBtn_Click"
                        ViewStateMode="Inherit"
                        Enabled="False"
                        CssClass="btn btn-danger mb-2"
                      />

                      <asp:Label
                        ID="TotalLabel"
                        runat="server"
                        CssClass="input-group-text bg-white d-flex ml-auto mb-2"
                      ></asp:Label>
                    </div>

                    <div class="input-group">
                      <asp:Button
                        ID="DeleteAllBtn"
                        runat="server"
                        Text="Delete All"
                        OnClick="DeleteAllBtn_Click"
                        Enabled="False"
                        CssClass="btn btn-danger"
                      />
                    </div>
                  </div>
                </ContentTemplate>
              </asp:UpdatePanel>
            </div>

            <div class="modal-footer">
              <asp:UpdatePanel ID="POBUpdatePanel" runat="server">
                <ContentTemplate>
                  <asp:Label
                    ID="POstatuslbl"
                    runat="server"
                    Text=""
                    Visible="false"
                  ></asp:Label>
                  <asp:Button
                    ID="CreatePOButton"
                    runat="server"
                    Text="Create"
                    class="btn btn-success"
                    OnClick="CreatePOButton_Click"
                  />
                </ContentTemplate>
              </asp:UpdatePanel>
              <asp:Button
                ID="CancelPOButton"
                runat="server"
                Text="Cancel"
                class="btn btn-danger"
                data-dismiss="modal"
              />
            </div>
          </div>
        </div>
      </div>
      <!-- End Purchase Order Modal -->
      <!-- Start Employee Modal -->
      <div
        class="modal fade"
        id="addEmployeeModal"
        runat="server"
        visible="false"
      >
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header bg-warning">
              <h5 class="modal-title">New Employee</h5>
              <button class="close" data-dismiss="modal">
                <span>&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label for="efirsttxt" class="input-group-text bg-warning"
                      >First Name</label
                    >
                  </div>
                  <asp:TextBox
                    ID="efirsttxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label for="elasttxt" class="input-group-text bg-warning"
                      >Last Name</label
                    >
                  </div>
                  <asp:TextBox
                    ID="elasttxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label for="emailtxt" class="input-group-text bg-warning"
                      >Email</label
                    >
                  </div>
                  <asp:TextBox
                    ID="emailtxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label for="passwordtxt" class="input-group-text bg-warning"
                      >Temp Password</label
                    >
                  </div>
                  <asp:TextBox
                    ID="passwordtxt"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                  ></asp:TextBox>
                </div>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="tempassconftxt"
                      class="input-group-text bg-warning"
                    >
                      Confirm Password</label
                    >
                  </div>
                  <asp:TextBox
                    CssClass="form-control"
                    TextMode="Password"
                    ID="tempassconftxt"
                    runat="server"
                  ></asp:TextBox>
                </div>
                <asp:CompareValidator
                  ID="PassValid"
                  runat="server"
                  ErrorMessage="Passwords do not match"
                  ControlToCompare="passwordtxt"
                  ControlToValidate="tempassconftxt"
                  CssClass="text-danger"
                ></asp:CompareValidator>
              </div>

              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="DropDownListDep"
                      class="input-group-text bg-warning"
                      >Department</label
                    >
                  </div>
                  <asp:DropDownList
                    ID="DropDownListDep"
                    runat="server"
                    CssClass="form-control"
                  ></asp:DropDownList>
                </div>
              </div>

              <div class="form-group">
                <label for="admin" class="mr-2"
                  >Make this user an administrator?</label
                >
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                  <label class="btn btn-success">
                    <asp:RadioButton
                      ID="yesToggle"
                      runat="server"
                      GroupName="admintoggle"
                    />

                    Yes
                  </label>
                  <label class="btn btn-warning active">
                    <asp:RadioButton
                      ID="noToggle"
                      runat="server"
                      GroupName="admintoggle"
                      Checked="True"
                    />
                    No
                  </label>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <asp:UpdatePanel ID="EUpdatePanel" runat="server">
                <ContentTemplate>
                  <asp:Label
                    ID="employeestatuslabel"
                    runat="server"
                    Text=""
                    Visible="false"
                  ></asp:Label>
                  <asp:Button
                    ID="createEmployeeBtn"
                    runat="server"
                    Text="Create"
                    CssClass="btn btn-success"
                    OnClick="createEmployeeButton_Click"
                  />
                </ContentTemplate>
              </asp:UpdatePanel>

              <button class="btn btn-danger" data-dismiss="modal">
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
      <!-- End Employee Modal -->
      <!-- Start Department Modal -->
      <div
        class="modal fade"
        id="addDepartmentModal"
        runat="server"
        visible="false"
      >
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header bg-danger text-white">
              <h5 class="modal-title">New Department</h5>
              <button class="close" data-dismiss="modal">
                <span>&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="depIDTxt"
                      class="input-group-text bg-danger text-white"
                    >
                      Department ID | D-</label
                    >
                  </div>
                  <asp:TextBox
                    ID="depIDTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <label
                      for="depNameTxt"
                      class="input-group-text bg-danger text-white"
                    >
                      Department Name</label
                    >
                  </div>
                  <asp:TextBox
                    ID="depNameTxt"
                    runat="server"
                    CssClass="form-control"
                  ></asp:TextBox>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <asp:UpdatePanel ID="DUpdatePanel" runat="server">
                <ContentTemplate>
                  <asp:Label
                    ID="departmentstatuslabel"
                    runat="server"
                    Text=""
                    Visible="false"
                  ></asp:Label>
                  <asp:Button
                    ID="createDepartmentButton"
                    runat="server"
                    Text="Create"
                    CssClass="btn btn-success"
                    OnClick="createDepartmentButton_Click"
                    CausesValidation="false"
                  />
                </ContentTemplate>
              </asp:UpdatePanel>

              <asp:Button
                ID="cancelDepartmentButton"
                runat="server"
                Text="Cancel"
                class="btn btn-danger"
                data-dismiss="modal"
              />
            </div>
          </div>
        </div>
      </div>
      <!-- End Department Modal -->
      <!-- End Modals -->
    </form>
    <!-- END HERE -->
    <!-- Start Script Section -->
    <script
      src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
      integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
      integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
      crossorigin="anonymous"
    ></script>
    <script>
      // Get the current year for the copyright
      $('#year').text(new Date().getFullYear());
    </script>
    <!-- End Script Section -->
  </body>
</html>
