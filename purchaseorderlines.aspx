<%@ Page Language="C#" AutoEventWireup="true" CodeFile="purchaseorderlines.aspx.cs" Inherits="purchaseorderlines" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <asp:Label ID="LabOrdedID" runat="server" Text=""></asp:Label>
            <asp:Label ID="LabOrderer" runat="server" Text=""></asp:Label>
            <asp:Label ID="LabODate" runat="server" Text=""></asp:Label>
            <asp:Label ID="LabDDate" runat="server" Text=""></asp:Label>

        </div>
        
        <br />

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
        <br />
        
        <div>

             <asp:GridView ID="PurchaseOrderLinesGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                <Columns>
                    
                    <asp:TemplateField ItemStyle-Width="150px" HeaderText="Purchase Line ID" SortExpression="PurchID" Visible="False">
                        <ItemTemplate>
                            <%# Eval("PurchID") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SKU" HeaderText="SKU" ItemStyle-Width="150" sortexpression="SKU"/>   
                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-Width="150" SortExpression="ItemName" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity Ordered" ItemStyle-Width="150" sortexpression="Quantity"/>
                    <asp:BoundField DataField="Cost" HeaderText="Total Price" ItemStyle-Width="150" sortexpression="Cost"/> 

                    <asp:ButtonField ButtonType="Button" Text="Details" CommandName="Details" />
                
                </Columns>
            </asp:GridView>

        </div>
    </form>
</body>
</html>
