<%@ Page Language="C#" AutoEventWireup="true" CodeFile="profile.aspx.cs"
Inherits="profile" %>

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
    <title>IMS || Profile</title>
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
                <a href="purchaseorders.aspx" class="nav-link"
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
                  class="nav-link active dropdown-toggle"
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
      <header id="main-header" class="py-2 bg-warning">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <h1>
                <i class="fas fa-user"></i> Profile -
                <asp:Label
                  ID="profilenamelabel"
                  runat="server"
                  Text=""
                ></asp:Label>
              </h1>
            </div>
          </div>
        </div>
      </header>
      <!-- End Header -->
      <!-- Start Profile Page -->
      <div class="container my-5">
        <div class="row">
          <div class="col-sm-6 ml-5">
            <div class="form-group row">
              <label for="Email" class="col-sm-4 col-form-label">Email: </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="Email"
                  runat="server"
                  ReadOnly="True"
                  CssClass="form-control-plaintext"
                ></asp:TextBox>
              </div>
            </div>

            <!-- Password can be changed without updating all data -->

            <div class="form-group row">
              <label for="EntCurPassword" class="col-sm-4 col-form-label"
                >Current Password:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="EntCurPassword"
                  runat="server"
                  TextMode="Password"
                  CssClass="form-control"
                ></asp:TextBox>
                <asp:RequiredFieldValidator
                  ID="CurrentPassValid"
                  runat="server"
                  ErrorMessage="Current password is required"
                  ControlToValidate="EntCurPassword"
                  CssClass="text-danger"
                ></asp:RequiredFieldValidator>
              </div>
            </div>

            <div class="form-group row">
              <label for="NewPass" class="col-sm-4 col-form-label"
                >New Password:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="NewPass"
                  runat="server"
                  TextMode="Password"
                  onkeyup="javascript:SetPasswordButton();"
                  CssClass="form-control"
                ></asp:TextBox>
              </div>
            </div>

            <div class="form-group row">
              <label for="NewPassConf" class="col-sm-4 col-form-label"
                >Confirm Password:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="NewPassConf"
                  runat="server"
                  TextMode="Password"
                  onkeyup="javascript:SetPasswordButton();"
                  ClientIDMode="Static"
                  CssClass="form-control"
                ></asp:TextBox>
                <asp:CompareValidator
                  ID="CompareNewPass"
                  runat="server"
                  ErrorMessage="Password doesn't match"
                  ControlToCompare="NewPass"
                  ControlToValidate="NewPassConf"
                  CssClass="text-danger"
                ></asp:CompareValidator>
              </div>
            </div>
            <div class="form-group row">
              <div class="col-sm-4 ml-auto">
                <asp:Button
                  ID="SendPassChange"
                  runat="server"
                  Text="Change Password"
                  Enabled="False"
                  OnClick="SendPassChange_Click"
                  ClientIDMode="Static"
                  CssClass="btn btn-outline-dark"
                />
              </div>
            </div>

            <hr />
            <div class="form-group row">
              <label for="Phone" class="col-sm-4 col-form-label"
                >Phone Number:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="Phone"
                  runat="server"
                  ReadOnly="True"
                  AutoCompleteType="HomePhone"
                  onkeyup="javascript:SetInfoButton();"
                  CssClass="form-control-plaintext"
                ></asp:TextBox>
                <asp:RegularExpressionValidator
                  ID="PhoneRegexValid"
                  runat="server"
                  ErrorMessage="Invalid phone number"
                  ControlToValidate="Phone"
                  ValidationExpression="^[2-9]\d{2}-\d{3}-\d{4}$"
                  CssClass="text-danger"
                ></asp:RegularExpressionValidator>
              </div>
            </div>

            <div class="form-group row">
              <label for="HomeAddr" class="col-sm-4 col-form-label"
                >Street Address:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="HomeAddr"
                  runat="server"
                  ReadOnly="True"
                  AutoCompleteType="HomeStreetAddress"
                  onkeyup="javascript:SetInfoButton();"
                  CssClass="form-control-plaintext"
                ></asp:TextBox>
              </div>
            </div>

            <div class="form-group row">
              <label for="City" class="col-sm-4 col-form-label">City: </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="City"
                  runat="server"
                  ReadOnly="True"
                  AutoCompleteType="HomeCity"
                  onkeyup="javascript:SetInfoButton();"
                  CssClass="form-control-plaintext"
                ></asp:TextBox>
              </div>
            </div>

            <div class="form-group row">
              <label for="Zip" class="col-sm-4 col-form-label"
                >Postal Code:
              </label>
              <div class="col-sm-8">
                <asp:TextBox
                  ID="Zip"
                  runat="server"
                  ReadOnly="True"
                  AutoCompleteType="HomeZipCode"
                  onkeyup="javascript:SetInfoButton();"
                  CssClass="form-control-plaintext"
                ></asp:TextBox>
                <asp:RegularExpressionValidator
                  ID="ZipCodeValid"
                  runat="server"
                  ErrorMessage="Invalid zip code"
                  ControlToValidate="Zip"
                  ValidationExpression="^\d{5}$"
                  CssClass="text-danger"
                ></asp:RegularExpressionValidator>
              </div>
            </div>

            <div class="form-group row">
              <label for="State" class="col-sm-4 col-form-label">State: </label>
              <div class="col-sm-8">
                <asp:DropDownList
                  ID="DropDownListState"
                  runat="server"
                  Enabled="False"
                  onchange="javascript:SetInfoButton();"
                  CssClass="form-control"
                >
                  <asp:ListItem Value="-1">Choose State</asp:ListItem>
                  <asp:ListItem Value="AL">Alabama</asp:ListItem>
                  <asp:ListItem Value="AK">Alaska</asp:ListItem>
                  <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                  <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                  <asp:ListItem Value="CA">California</asp:ListItem>
                  <asp:ListItem Value="CO">Colorado</asp:ListItem>
                  <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                  <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                  <asp:ListItem Value="DE">Delaware</asp:ListItem>
                  <asp:ListItem Value="FL">Florida</asp:ListItem>
                  <asp:ListItem Value="GA">Georgia</asp:ListItem>
                  <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                  <asp:ListItem Value="ID">Idaho</asp:ListItem>
                  <asp:ListItem Value="IL">Illinois</asp:ListItem>
                  <asp:ListItem Value="IN">Indiana</asp:ListItem>
                  <asp:ListItem Value="IA">Iowa</asp:ListItem>
                  <asp:ListItem Value="KS">Kansas</asp:ListItem>
                  <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                  <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                  <asp:ListItem Value="ME">Maine</asp:ListItem>
                  <asp:ListItem Value="MD">Maryland</asp:ListItem>
                  <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                  <asp:ListItem Value="MI">Michigan</asp:ListItem>
                  <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                  <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                  <asp:ListItem Value="MO">Missouri</asp:ListItem>
                  <asp:ListItem Value="MT">Montana</asp:ListItem>
                  <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                  <asp:ListItem Value="NV">Nevada</asp:ListItem>
                  <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                  <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                  <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                  <asp:ListItem Value="NY">New York</asp:ListItem>
                  <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                  <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                  <asp:ListItem Value="OH">Ohio</asp:ListItem>
                  <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                  <asp:ListItem Value="OR">Oregon</asp:ListItem>
                  <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                  <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                  <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                  <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                  <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                  <asp:ListItem Value="TX">Texas</asp:ListItem>
                  <asp:ListItem Value="UT">Utah</asp:ListItem>
                  <asp:ListItem Value="VT">Vermont</asp:ListItem>
                  <asp:ListItem Value="VA">Virginia</asp:ListItem>
                  <asp:ListItem Value="WA">Washington</asp:ListItem>
                  <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                  <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                  <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                </asp:DropDownList>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-sm-4 mr-auto">
                <asp:Button
                  ID="ActEdits"
                  runat="server"
                  Text="Edit Profile"
                  OnClick="ActEdits_Click"
                  CssClass="btn btn-outline-danger"
                />
              </div>
              <div class="col-sm-4 ml-auto">
                <asp:Button
                  ID="SaveChange"
                  runat="server"
                  Text="Save Changes"
                  Enabled="False"
                  OnClick="SaveChange_Click"
                  CssClass="btn btn-outline-dark"
                />
              </div>
            </div>
          </div>
        </div>
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

    <script
      src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.9.0.min.js"
      type="text/javascript"
    ></script>
    <script type="text/javascript">
      function SetPasswordButton() {
        var newp = document.getElementById('<%=NewPass.ClientID%>').value;
        var newc = document.getElementById('<%=NewPassConf.ClientID%>').value;

        if (newc.length > 7 && newp.length > 7)
          document.getElementById(
            '<%=SendPassChange.ClientID%>'
          ).disabled = false;
        else
          document.getElementById(
            '<%=SendPassChange.ClientID%>'
          ).disabled = true;
      }

      function SetInfoButton() {
        var phonev = /^\(?([0-9]{3})\)?[-]?([0-9]{3})[-]?([0-9]{4})$/;
        var phone = document.getElementById('<%=Phone.ClientID%>').value;
        var zipv = /^[0-9]{5}(?:-[0-9]{4})?$/;
        var zip = document.getElementById('<%=Zip.ClientID%>').value;

        if (
          (phone.match(phonev) || phone.length === 0) &&
          (zip.match(zipv) || zip.length === 0)
        )
          document.getElementById('<%=SaveChange.ClientID%>').disabled = false;
        else
          document.getElementById('<%=SaveChange.ClientID%>').disabled = true;
      }
    </script>
    <!-- End Script Section -->
  </body>
</html>
