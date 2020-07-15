<%@ Page Language="C#" AutoEventWireup="true" CodeFile="inventory.aspx.cs" Inherits="ItemLookup" %>

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
    <title>Item Lookup</title>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <!-- div section for both search textboxes and submit buttons-->

            <label for="skutxt">Item SKU:</label><br />
            <asp:Label ID="skulab" runat="server" Text="I-"></asp:Label>
            <asp:TextBox ID="skutxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="SKUSearch" runat="server" Text="Search SKU" />

            <br />

            <label for="itemname">Item Name:</label><br />

            <asp:TextBox ID="itemnametxt" runat="server"></asp:TextBox>
            <asp:Button OnClick="NameSearch" runat="server" Text="Search Item Name" />

        </div>


        <div>
            <!-- div section for checkbuttons to hide or show columns -->

            <asp:CheckBoxList ID="ColumnCheckBoxList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Check_Clicked" Width="262px">
                <asp:ListItem Value="2">On Hand Quantity</asp:ListItem>
                <asp:ListItem Value="3">Total Quantity</asp:ListItem>
                <asp:ListItem Value="4">Price</asp:ListItem>
                <asp:ListItem Value="5">Last Order Date</asp:ListItem>
                <asp:ListItem Value="6">Status</asp:ListItem>
                <asp:ListItem Value="7">Supplier</asp:ListItem>
                <asp:ListItem Value="8">Comments</asp:ListItem>
            </asp:CheckBoxList>



        </div>


        <p></p>


        <div>
            <!-- div section for all radio buttons to filter for active or inactive items -->
            <asp:RadioButton ID="RadBoth" runat="server" GroupName="status" Text="Both" AutoPostBack="true" OnCheckedChanged="RadBoth_CheckedChanged"/>
            <asp:RadioButton ID="RadActive" runat="server" GroupName="status" Text="Active" AutoPostBack="true" OnCheckedChanged="RadActive_CheckedChanged"/>
            <asp:RadioButton ID="RadInactive" runat="server" GroupName="status" Text="Inactive" AutoPostBack="true" OnCheckedChanged="RadInactive_CheckedChanged"/>
        </div>


        <p></p>
        <div>

            
            <!-- Table using asp GridView and connecting to database  This will also serve as the default style for now, Allows for sorting and paging.-->
            <asp:GridView ID="ItemLookUpGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="2">
                <Columns>
                    
                    <asp:TemplateField ItemStyle-Width="150px" HeaderText="SKU" SortExpression="Items.SKU">
                        <ItemTemplate>
                            <%# Eval("SKU") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-Width="150" sortexpression="ItemName"/>    
                    <asp:BoundField DataField="OnHand" HeaderText="On Hand Quantity" ItemStyle-Width="150" sortexpression="OnHand"/>
                    <asp:BoundField DataField="Quantity" HeaderText="Total Quantity" ItemStyle-Width="150" sortexpression="Quantity"/> 
                    <asp:BoundField DataField="Price" HeaderText="Item Price" ItemStyle-Width="30" sortexpression="Price"/> 
                    <asp:BoundField DataField="LastOrderDate" HeaderText="Last Order" ItemStyle-Width="150" sortexpression="LastOrderDate"/> 
                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-Width="30" SortExpression="Status" />
                    <asp:BoundField DataField="SupplierID" HeaderText="Supplier ID" ItemStyle-Width="150" SortExpression="SupplierID" />
                    <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-Width="150" />
                
                </Columns>
            </asp:GridView>
            <p></p>
            
        </div>
    </form>
</body>
</html>
