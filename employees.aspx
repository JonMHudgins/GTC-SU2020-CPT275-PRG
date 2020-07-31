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
        crossorigin="anonymous" />
    <link
        rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
        crossorigin="anonymous" />
    <link rel="stylesheet" href="css/style.css" />
    <title>IMS || Employees</title>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Start Navbar -->
        <nav class="navbar navbar-expand-md bg-dark navbar-dark p-0">
            <div class="container">
                <a href="index.aspx" class="navbar-brand">
                    <i class="fas fa-archive"></i>I<small>nventory</small> M<small>anagement</small>
                    S<small>olutions</small>
                </a>
                <button
                    class="navbar-toggler"
                    type="button"
                    data-toggle="collapse"
                    data-target="#navbarCollapse"
                    aria-controls="navbarCollapse"
                    aria-expanded="false"
                    aria-label="Toggle navigation">
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
                            <a href="purchaseorders.aspx" class="nav-link">Purchase Orders</a>
                        </li>
                        <li class="nav-item px-2" runat="server" id="employeenav" visible="false">
                            <a href="employees.aspx" class="nav-link active">Employees</a>
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
                                data-toggle="dropdown">
                                <i class="fas fa-user"></i>Welcome
                  <asp:Label
                      ID="nameLabel"
                      runat="server"
                      Text="Label"></asp:Label>
                            </a>
                            <div class="dropdown-menu">
                                <a href="profile.aspx" class="dropdown-item">
                                    <i class="fas fa-user-circle"></i>Profile
                                </a>
                                <asp:LinkButton
                                    runat="server"
                                    ID="LinkButton1"
                                    OnClick="logoutLink_Click"
                                    class="dropdown-item">
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
        <header id="main-header" class="py-2 bg-warning">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h1><i class="fas fa-users"></i>Employees</h1>
                    </div>
                </div>
            </div>
        </header>
        <!-- End Header -->

        <!-- Start Table Management Section -->
        <div class="container mt-5">
            <div class="card mb-5" style="overflow-x: auto;">
                <div class="card-header">
                    <!-- Start Field Selector Section -->
                    <div class="row align-items-center">
                        <div class="col-md-6 mx-auto">
                            <div class="card">
                                <div class="card-header pt-2 pb-0">
                                    <header class="h5">Items to Display</header>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Admin1"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Admin1" class="form-check-label">
                                                        Admin</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Department2"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Department2" class="form-check-label">
                                                        Department Info</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Phone4"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Phone4" class="form-check-label">
                                                        Phone</label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Email5"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Email5" class="form-check-label">
                                                        Email</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Address6"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Address6" class="form-check-label">
                                                        Address</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:CheckBox
                                                        ID="Login7"
                                                        runat="server"
                                                        AutoPostBack="True"
                                                        Checked="True"
                                                        OnCheckedChanged="ColumnShow_CheckedChanged"
                                                        CssClass="form-check-input" />
                                                    <label for="Login7" class="form-check-label">
                                                        Last Login</label>
                                                </div>
                                            </div>
                                        </div>

                                        <hr />

                                        <div class="form-group">
                                            <div class="form-check form-check-inline">
                                                <asp:CheckBox
                                                    ID="Admin"
                                                    runat="server"
                                                    AutoPostBack="True"
                                                    Checked="True"
                                                    OnCheckedChanged="ShowRank_CheckedChanged"
                                                    CssClass="form-check-input" />
                                                <label for="Admin" class="form-check-label">
                                                    Admins</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <asp:CheckBox
                                                    ID="Employee"
                                                    runat="server"
                                                    AutoPostBack="True"
                                                    Checked="True"
                                                    OnCheckedChanged="ShowRank_CheckedChanged"
                                                    CssClass="form-check-input" />
                                                <label for="Employee" class="form-check-label">
                                                    Employees</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Field Selector Section -->
                        <!-- Start Search Section -->
                        <div class="col-xs-6 mx-auto">
                            <div class="card">
                                <div class="card-body">
                                    <!-- Employee ID Search Box -->
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <label
                                                    for="employeeidtxt"
                                                    class="input-group-text bg-warning">
                                                    Employee ID | E-</label>
                                            </div>
                                            <asp:TextBox
                                                ID="employeeidtxt"
                                                runat="server"
                                                CssClass="form-control"></asp:TextBox>
                                            <asp:LinkButton
                                                OnClick="EmployeeIDSearch"
                                                runat="server"
                                                Text="Search Employee ID"
                                                CssClass="btn btn-warning input-group-append"><i class="fa fa-search fa-lg align-self-center"></i
                      ></asp:LinkButton>
                                        </div>
                                    </div>

                                    <!-- Employee Name Search Box -->
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <label
                                                    for="employeenametxt"
                                                    class="input-group-text bg-warning">
                                                    Employee Name</label>
                                            </div>
                                            <asp:TextBox
                                                ID="employeenametxt"
                                                runat="server"
                                                CssClass="form-control"></asp:TextBox>
                                            <asp:LinkButton
                                                OnClick="EmployeeNameSearch"
                                                runat="server"
                                                Text="Search Employee Name"
                                                CssClass="btn btn-warning input-group-append"><i class="fa fa-search fa-lg align-self-center"></i
                      ></asp:LinkButton>
                                        </div>
                                    </div>

                                    <!-- Department ID Search Box -->
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <label
                                                    for="departidtxt"
                                                    class="input-group-text bg-warning">
                                                    Department ID D-</label>
                                            </div>
                                            <asp:TextBox
                                                ID="departidtxt"
                                                runat="server"
                                                CssClass="form-control"></asp:TextBox>
                                            <asp:LinkButton
                                                OnClick="DepartIDSearch"
                                                runat="server"
                                                Text="Search Department ID"
                                                CssClass="btn btn-warning input-group-append"><i class="fa fa-search fa-lg align-self-center"></i
                      ></asp:LinkButton>
                                        </div>
                                    </div>

                                    <!-- Department Name Search Box -->
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <label
                                                    for="departnametxt"
                                                    class="input-group-text bg-warning">
                                                    Department Name</label>
                                            </div>
                                            <asp:TextBox
                                                ID="departnametxt"
                                                runat="server"
                                                CssClass="form-control"></asp:TextBox>
                                            <asp:LinkButton
                                                OnClick="DepartNameSearch"
                                                runat="server"
                                                Text="Search Department Name"
                                                CssClass="btn btn-warning input-group-append"><i class="fa fa-search fa-lg align-self-center"></i
                      ></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Search Section -->
                        <asp:Label ID="emplbl" runat="server" Text="" Visible="false"></asp:Label>
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
                        EmptyDataText="No data available."
                        OnSorting="ItemLookUp_Sorting"
                        OnPageIndexChanging="OnPageIndexChanging"
                        PageSize="10"
                        CssClass="table table-striped"
                        HeaderStyle-CssClass="thead-dark"
                        OnRowUpdating="EmployeeGridView_RowUpdating"
                        OnRowCancelingEdit="EmployeeGridView_RowCancelingEdit"
                        OnRowEditing="EmployeeGridView_RowEditing"
                        OnRowDeleting="EmployeeGridView_RowDeleting">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" CssClass="btn btn-warning"/>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Button ID="btn_Update" runat="server" Text="Update" CommandName="Update" CssClass="btn btn-outline-success"/>
                                    <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="btn btn-outline-danger"/>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="DeleteButton" runat="server"
                                        CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this event?');"
                                        Text="Delete" CssClass="btn btn-danger"/>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmployeeID" SortExpression="ID">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField
                                DataField="Name"
                                HeaderText="Name"
                                SortExpression="Name"
                                ReadOnly="true" />
                            <asp:BoundField
                                DataField="Admin"
                                HeaderText="Admin"
                                SortExpression="Admin" />
                            <asp:BoundField
                                DataField="DepartmentID"
                                HeaderText="Department ID"
                                SortExpression="DepartmentID" />
                            <asp:BoundField
                                DataField="DepartmentName"
                                HeaderText="Department Name"
                                SortExpression="DepartmentName"
                                ReadOnly="true" />
                            <asp:BoundField
                                DataField="Phone"
                                HeaderText="Phone"
                                SortExpression="Phone" />
                            <asp:BoundField
                                DataField="Email"
                                HeaderText="Email"
                                SortExpression="Email" />
                            <asp:BoundField
                                DataField="Address"
                                HeaderText="Home Address"
                                SortExpression="Address"
                                ReadOnly="true" />
                            <asp:BoundField
                                DataField="LastLogged"
                                HeaderText="Last Login"
                                SortExpression="LastLogged"
                                ReadOnly="true" />
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
    <!-- Start Script Section -->
    <script
        src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
    <script>
        // Get the current year for the copyright
        $('#year').text(new Date().getFullYear());
    </script>
    <!-- End Script Section -->
</body>
</html>
