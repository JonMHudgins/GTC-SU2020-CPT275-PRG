<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Placeholdmodal.aspx.cs" Inherits="Placeholdmodal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            
            <asp:TextBox ID="SearchText" runat="server"></asp:TextBox>
            <asp:Button ID="Search" runat="server" Text="Search" OnClick="Search_Click"/> <br />
            <label for="QuantityText">Quantity: </label>
            <asp:TextBox ID="QuantityText" runat="server"></asp:TextBox> <br />

            <asp:GridView ID="GridViewItem" runat="server" DataKeyNames="SKU" AutoGenerateColumns="false"   OnSelectedIndexChanged="GridViewItem_SelectedIndexChanged" AllowPaging="true" AllowSorting="true"  OnPageIndexChanging="GridViewItem_PageIndexChanging" EmptyDataText="No data available." OnSorting="GridViewItem_Sorting" AutoGenerateSelectButton="True">
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
                <SelectedRowStyle  BackColor="LightCoral"/>
            </asp:GridView>


            <asp:Button ID="AddItemButton" runat="server" Text="Add Item" OnClick="AddItemButton_Click" Enabled="False" />

            <hr />

            <asp:GridView ID="GridViewOrder" runat="server" DataKeyNames="SKU" AutoGenerateColumns="false"   OnSelectedIndexChanged="GridViewOrder_SelectedIndexChanged"  AllowPaging="true" AllowSorting="true"  OnPageIndexChanging="GridViewOrder_PageIndexChanging" OnSorting="GridViewOrder_Sorting" AutoGenerateSelectButton="True" ShowHeaderWhenEmpty="True">
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
                <SelectedRowStyle  BackColor="LightCoral"/>
                <EmptyDataTemplate>No Items Added to Purchase Order</EmptyDataTemplate>
            </asp:GridView>

            <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click" ViewStateMode="Inherit" Enabled="False" /> <br />

            <asp:Button ID="DeleteAllBtn" runat="server" Text="Delete All" OnClick="DeleteAllBtn_Click" Enabled="False" /> 

            <asp:Label ID="TotalLabel" runat="server"></asp:Label> <br />

            <asp:Button ID="CreateButton" runat="server" Text="Create" OnClick="CreateButton_Click" Enabled="False" /> <br />

        </div>
    </form>
</body>
</html>
