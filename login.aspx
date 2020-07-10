<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

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
    <title>IMS | Login</title>
</head>
<body>
     <!-- START HERE -->
    <!-- Start Nav -->
    <nav id="main-nav" class="navbar navbar-expand-md bg-primary navbar-dark p-0">
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
              <a href="login.aspx" class="nav-link active">Sign In</a>
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
          <div class="col-md-8 d-none d-lg-block text-right">
            <h1 class="heading-1 text-primary mt-5">
              Welcome to your inventory management portal!
            </h1>
          </div>
          <div class="col-lg-4">
            <div class="card card-body text-center my-5">
              <h3 class="text-primary mb-4">Sign In</h3>
                <asp:Label ID="errorLabel" runat="server" class="text-danger" Text="" Visible="False"></asp:Label>
              <form id="signInForm" runat="server">
                  
                  <asp:RequiredFieldValidator
                    ID="nameValidator"
                    runat="server"
                    ErrorMessage="Required"
                    ControlToValidate="email"
                    Display="Dynamic"
                    class="text-danger h5 float-right"
                  >
                  </asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator
                    ID="emailRegExValidator"
                    runat="server"
                    ErrorMessage="Invalid email"
                    ControlToValidate="email"
                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                    Display="Dynamic"
                    class="text-danger h5 float-right"
                  ></asp:RegularExpressionValidator>
                <div class="row ml-auto">
                  <h5>Email</h5>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="fas fa-user"></i>
                      </span>
                    </div>
                    <asp:TextBox
                        id="email"
                        class="form-control"
                        runat="server"
                      >
                      </asp:TextBox>
                  </div>
                </div>
                  <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    runat="server"
                    ErrorMessage="Required"
                    ControlToValidate="password"
                    Display="Dynamic"
                    class="text-danger h5 float-right"
                  >
                  </asp:RequiredFieldValidator>
                <div class="row ml-auto">
                  <h5>Password</h5>
                </div>
                <div class="form-group mb-3">
                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="fas fa-key"></i>
                      </span>
                    </div>
                    <asp:TextBox
                        id="password"
                        class="form-control"
                        runat="server"
                      TextMode="Password">
                      </asp:TextBox>
                  </div>
                </div>
                  <asp:Button
                    ID="submitButton"
                    runat="server"
                    text="Sign In"
                    class="btn btn-outline-primary btn-block"
                    OnClick="submitButton_Click"
                  />
              </form>
              <div class="row ml-auto mt-2 mb-0">
                <a href="#">Forgot password?</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- End Main Content -->
    <!-- Start Footer -->
    <footer id="main-footer" class="fixed-bottom bg-dark text-white mt-5 p-2">
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
