<%@ Page Language="C#" AutoEventWireup="true" CodeFile="departments.aspx.cs" Inherits="departments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <label for="departidtxt">Department ID:</label><br />
            <asp:Label ID="labdepartid" runat="server" Text="D-"></asp:Label>
            <asp:TextBox ID="departidxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="DepartIDSearch" runat="server" Text="Search Department ID" />



            <br />


            <label for="departnametxt">Department Name:</label><br />

            <asp:TextBox ID="departnametxt" runat="server"></asp:TextBox>
            <asp:Button OnClick="NameSearch" runat="server" Text="Search Department Name" />
        </div>
        
        
        
        <div>
            <asp:GridView ID="DepartmentsGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." DataKeyNames="DepartmentID" OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="10" OnRowCommand="GridView1_OnRowCommand">
                <Columns>
                    


                    <asp:BoundField DataField="DepartmentID" HeaderText="Department ID" ItemStyle-Width="150" SortExpression="DepartmentID" />
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" ItemStyle-Width="150" sortexpression="DepartmentName"/>    

                    
                    
                    
                    <asp:ButtonField ButtonType="Button" Text="Employees" CommandName="Employees" />
                
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
