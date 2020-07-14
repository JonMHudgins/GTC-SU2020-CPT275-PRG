<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs"
Inherits="index" %>
<!DOCTYPE html>
<html lang="en"  xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="img/logo.ico" />
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.13.0/css/all.css"
          integrity="sha384-Bfad6CLCknfcloXFOyFnlgtENryhrpZCe29RTifKEixXQZ38WheV+i/6YWSzkz3V"
          crossorigin="anonymous" />
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous" />
    <link rel="stylesheet" href="css/style.css" />
    <title>IMS || Dashboard</title>
</head>
<body>
    <!-- START HERE -->
    <!-- Start Navbar -->
    <nav class="navbar navbar-expand-md bg-primary navbar-dark p-0">
        <div class="container">
            <a href="index.aspx" class="navbar-brand">
                <i class="fas fa-archive"></i> I<small>nventory</small> M<small>anagement</small>
                S<small>olutions</small>
            </a>
            <button class="navbar-toggler"
                    data-toggle="collapse"
                    data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav">
                    <li class="nav-item px-2">
                        <a href="index.aspx" class="nav-link active">Dashboard</a>
                    </li>
                    <li class="nav-item px-2">
                        <a href="inventory.html" class="nav-link">Inventory</a>
                    </li>
                    <li class="nav-item px-2">
                        <a href="purchaseorders.html" class="nav-link">Purchase Orders</a>
                    </li>
                    <li class="nav-item px-2">
                        <a href="employees.html" class="nav-link">Employees</a>
                    </li>
                    <li class="nav-item px-2">
                        <a href="departments.html" class="nav-link">Departments</a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown mr-3">
                        <a href="#"
                           class="nav-link dropdown-toggle"
                           data-toggle="dropdown">
                            <i class="fas fa-user"></i> Welcome <asp:Label ID="nameLabel" runat="server" Text="Label"></asp:Label>
                        </a>
                        <div class="dropdown-menu">
                            <a href="profile.html" class="dropdown-item">
                                <i class="fas fa-user-circle"></i> Profile
                            </a>
                            <form runat="server">
                        <asp:LinkButton runat="server" ID="LinkButton1" onclick="logoutLink_Click" class="dropdown-item">
                            <i class="fas fa-user-times"></i> Logout
                        </asp:LinkButton>
                        </form>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->
    <!-- Start Header -->
    <header id="main-header" class="py-2 bg-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1><i class="fas fa-cog"></i> Dashboard</h1>
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
                    <a href="#"
                       class="btn btn-primary btn-block mb-2"
                       data-toggle="modal"
                       data-target="#newItemModal">
                        <i class="fas fa-plus"></i> New Inventory Item
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#"
                       class="btn btn-success btn-block mb-2"
                       data-toggle="modal"
                       data-target="#addPOModal">
                        <i class="fas fa-plus"></i> New Purchase Order
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#"
                       class="btn btn-warning btn-block"
                       data-toggle="modal"
                       data-target="#addEmployeeModal">
                        <i class="fas fa-plus"></i> New Employee
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#"
                       class="btn btn-danger btn-block"
                       data-toggle="modal"
                       data-target="#addDepartmentModal">
                        <i class="fas fa-plus"></i> New Department
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
                        <table class="table table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Creator</th>
                                    <th>Source</th>
                                    <th>Date</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Jon Hudgins</td>
                                    <td>Office Depot</td>
                                    <td>May 20 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Jon Hudgins</td>
                                    <td>Staples</td>
                                    <td>May 17 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Gage McGarity</td>
                                    <td>Best Buy</td>
                                    <td>May 15 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>Joshua Weinstein</td>
                                    <td>Office Max</td>
                                    <td>May 13 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>Zach Jones</td>
                                    <td>Dunder Mifflin</td>
                                    <td>May 11 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>6</td>
                                    <td>Jon Hudgins</td>
                                    <td>Staples</td>
                                    <td>May 10 2018</td>
                                    <td>
                                        <a href="#" class="btn btn-secondary">
                                            <i class="fas fa-angle-double-right"></i> Details
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3 d-none d-lg-block">
                    <div class="card text-center bg-primary text-white mb-3">
                        <div class="card-body">
                            <h3>Inventory</h3>
                            <h4 class="display-4"><i class="fas fa-pencil-alt"></i></h4>
                            <a href="inventory.html" class="btn btn-outline-light btn-sm">View</a>
                        </div>
                    </div>
                    <div class="card text-center bg-success text-white mb-3">
                        <div class="card-body">
                            <h3>Purchase Orders</h3>
                            <h4 class="display-4"><i class="fas fa-folder"></i></h4>
                            <a href="purchaseorders.html"
                               class="btn btn-outline-light btn-sm">View</a>
                        </div>
                    </div>
                    <div class="card text-center bg-warning text-white mb-3">
                        <div class="card-body">
                            <h3>Employees</h3>
                            <h4 class="display-4"><i class="fas fa-users"></i></h4>
                            <a href="employees.html" class="btn btn-outline-light btn-sm">View</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Posts -->
    <!-- Start Footer -->
    <footer id="main-footer" class="bg-dark text-white mt-5 p-4">
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
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">New Inventory Item</h5>
                    <button class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="sku">SKU</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="itemName">Item Name</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="Quantity">Quantity</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="qoh">Quantity on Hand</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="price">Price</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="supplier">Supplier</label>
                            <select class="form-control">
                                <option value="">New Supplier</option>
                                <option value="">ITSupplies.com</option>
                                <option value="">Quill</option>
                                <option value="">TigerDirect</option>
                                <option value="">Costco</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="comments">Comments</label>
                            <textarea class="form-control"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-dismiss="modal">
                        Save Changes
                    </button>
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
                    <form>
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success" data-dismiss="modal">
                        Save Changes
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Purchase Order Modal -->
    <!-- Start Employee Modal -->
    <div class="modal fade" id="addEmployeeModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-warning text-white">
                    <h5 class="modal-title">New Employee</h5>
                    <button class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="password">Temporary Password</label>
                            <input type="password" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="passwordConfirm">Confirm Temporary Password</label>
                            <input type="password" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="supplier">Department</label>
                            <select class="form-control">
                                <option value="">Human Resources</option>
                                <option value="">Marketing</option>
                                <option value="">Customer Service</option>
                                <option value="">Sales</option>
                                <option value="">Accounting</option>
                                <option value="">Distribution</option>
                                <option value="">Management</option>
                                <option value="">Legal</option>
                                <option value="">IT</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="admin">Make this user an administrator?</label>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-success">
                                    <input type="radio"
                                           name="yesToggle"
                                           id="yesToggle"
                                           autocomplete="off" />Yes
                                </label>
                                <label class="btn btn-warning active">
                                    <input type="radio"
                                           name="noToggle"
                                           id="noToggle"
                                           autocomplete="off"
                                           checked />No
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-warning" data-dismiss="modal">
                        Save Changes
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Employee Modal -->
    <!-- End Modals -->
    <!-- END HERE -->
    <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
    <script>
        // Get the current year for the copyright
        $('#year').text(new Date().getFullYear());
    </script>
</body>
</html>
