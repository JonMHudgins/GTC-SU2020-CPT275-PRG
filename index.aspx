<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

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
    <title>IMS | Home</title>
</head>
<body>
     <!-- START HERE -->
    <!-- Start Nav -->
    <nav id="main-nav" class="navbar navbar-expand-md bg-primary navbar-light">
      <div class="container">
        <a href="#" class="navbar-brand">
          <i class="fas fa-archive align-middle"></i>
          <h5 class="d-inline align-middle">Inventory Management Solutions</h5>
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarCollapse"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a href="index.aspx" class="nav-link active">Home</a>
            </li>
            <li class="nav-item">
              <a href="index.aspx" class="nav-link">Inventory</a>
            </li>
            <li class="nav-item">
              <a href="index.aspx" class="nav-link">Purchase Orders</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- End Nav -->
    <!-- Start Main Content -->
    <section id="signInMain" class="my-5 py-5 h-50">
      <div class="container">
        <div class="row">
          <div class="col-md-8 d-none d-lg-block text-left">
            <h1 class="heading-1 text-primary mt-5">
              Welcome to your inventory management portal home page <asp:Label ID="nameLabel" runat="server" Text="Label"></asp:Label>!
            </h1>
          </div>
          <div class="col-lg-4">
           
          </div>
        </div>
      </div>
    </section>
    <!-- End Main Content -->
    <!-- END HERE -->
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
</body>
</html>
