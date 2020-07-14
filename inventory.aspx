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



        <p></p>
        <div>

            
            <!-- Table using asp GridView and connecting to database  This will also serve as the default style for now, Allows for sorting and paging.-->
            <asp:GridView ID="ItemLookUpGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="2">
                <Columns>
                    
                    <asp:TemplateField ItemStyle-Width="150px" HeaderText="SKU" SortExpression="SKU">
                        <ItemTemplate>
                            <%# Eval("SKU") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    

                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-Width="150" sortexpression="ItemName"/>    
                    <asp:BoundField DataField="Quantity" HeaderText="Item Quantity" ItemStyle-Width="150" sortexpression="Quantity"/> 
                    <asp:BoundField DataField="Price" HeaderText="Item Price" ItemStyle-Width="30" sortexpression="Price"/> 
                    <asp:BoundField DataField="LastOrderDate" HeaderText="Last Order" ItemStyle-Width="150" sortexpression="LastOrderDate"/> 
                
                </Columns>
            </asp:GridView>
            <p></p>
            
        </div>
    </form>
</body>
</html>
