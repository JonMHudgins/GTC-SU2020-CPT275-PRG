<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Placeholdmodal.aspx.cs"
Inherits="Placeholdmodal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title></title>
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
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="container mt-5">
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
                >Quantity:
              </label>
            </div>

            <asp:TextBox ID="QuantityText" runat="server"></asp:TextBox>
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
            AllowPaging="true"
            AllowSorting="true"
            OnPageIndexChanging="GridViewOrder_PageIndexChanging"
            OnSorting="GridViewOrder_Sorting"
            AutoGenerateSelectButton="True"
            ShowHeaderWhenEmpty="True"
            CssClass="table table-striped"
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
            <EmptyDataTemplate
              >No Items Added to Purchase Order</EmptyDataTemplate
            >
          </asp:GridView>
          <div class="form-group">
            <div class="row mb-2">
              <div class="input-group">
                <asp:Button
                  ID="DeleteBtn"
                  runat="server"
                  Text="Delete"
                  OnClick="DeleteBtn_Click"
                  ViewStateMode="Inherit"
                  Enabled="False"
                  CssClass="btn btn-danger"
                />

                <asp:Label
                  ID="TotalLabel"
                  runat="server"
                  CssClass="input-group-text bg-white d-flex ml-auto"
                ></asp:Label>
              </div>
            </div>
            <div class="row mb-2">
              <div class="input-group">
                <asp:Button
                  ID="DeleteAllBtn"
                  runat="server"
                  Text="Delete All"
                  OnClick="DeleteAllBtn_Click"
                  Enabled="False"
                  CssClass="btn btn-danger"
                />
                <asp:Button
                  ID="CreateButton"
                  runat="server"
                  Text="Create"
                  OnClick="CreateButton_Click"
                  Enabled="False"
                  CssClass="btn btn-success d-flex ml-auto"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
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
