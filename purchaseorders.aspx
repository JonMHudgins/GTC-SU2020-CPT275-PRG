<%@ Page Language="C#" AutoEventWireup="true" CodeFile="purchaseorders.aspx.cs" Inherits="purchaseorders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <label for="orderidtxt">Order ID:</label><br />
            <asp:Label ID="laborderid" runat="server" Text="P-"></asp:Label>
            <asp:TextBox ID="orderidxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="OrderIDSearch" runat="server" Text="Search Order ID" />

            <br />

            <label for="employeeidtxt">Employee ID:</label><br />
            <asp:Label ID="employeelab" runat="server" Text="E-"></asp:Label>
            <asp:TextBox ID="employeeidtxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="EmployeeIDSearch" runat="server" Text="Search Employee ID" />

            <br />


            <label for="employeenametxt">Employee Name:</label><br />

            <asp:TextBox ID="employeenametxt" runat="server"></asp:TextBox>
            <asp:Button OnClick="NameSearch" runat="server" Text="Search Employee Name" />
        </div>

        <br />
        
        <div>
            <!-- div section for all radio buttons to filter for active or inactive items -->
            <asp:RadioButton ID="RadBoth" runat="server" GroupName="status" Text="Both" AutoPostBack="true" OnCheckedChanged="RadBoth_CheckedChanged"/>
            <asp:RadioButton ID="RadDel" runat="server" GroupName="status" Text="Delivered" AutoPostBack="true" OnCheckedChanged="RadDel_CheckedChanged"/>
            <asp:RadioButton ID="RadNotDel" runat="server" GroupName="status" Text="Not Delivered" AutoPostBack="true" OnCheckedChanged="RadNotDel_CheckedChanged"/>
        </div>
        
        <br />

        <div>
            <asp:GridView ID="PurchaseOrdersGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." DataKeyNames="PurchID" OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="10" OnRowCommand="GridView1_OnRowCommand">
                <Columns>
                    


                    <asp:BoundField DataField="PurchID" HeaderText="Purchase Order ID" ItemStyle-Width="150" SortExpression="PurchID" />
                    <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" ItemStyle-Width="150" sortexpression="EmployeeID"/>    
                    <asp:BoundField DataField="Name" HeaderText="Creator" ItemStyle-Width="150" sortexpression="Name"/>
                    <asp:BoundField DataField="DateOrdered" HeaderText="Ordered Date" ItemStyle-Width="150" sortexpression="DateOrdered"/> 
                    <asp:BoundField DataField="DateDelivered" HeaderText="Delivered Date" ItemStyle-Width="150" sortexpression="DateDelivered" NullDisplayText="Not yet delivered"/> 
                    
                    
                    
                    
                    <asp:ButtonField ButtonType="Button" Text="Details" CommandName="Details" />
                
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
