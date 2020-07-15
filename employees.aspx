<%@ Page Language="C#" AutoEventWireup="true" CodeFile="employees.aspx.cs" Inherits="employees" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- div section for both search textboxes and submit buttons-->

            <label for="employeeidtxt">Employee ID:</label><br />
            <asp:Label ID="employeelab" runat="server" Text="E-"></asp:Label>
            <asp:TextBox ID="employeeidtxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="EmployeeIDSearch" runat="server" Text="Search Employee ID" />

            <br />

            <label for="">Employee Name:</label><br />
            <asp:TextBox ID="employeenametxt" runat="server"></asp:TextBox>
            <asp:Button OnClick="EmployeeNameSearch" runat="server" Text="Search Employee Name" />


            <br />

            <label for="departidtxt">Department ID:</label><br />
            <asp:Label ID="departidlab" runat="server" Text="D-"></asp:Label>
            <asp:TextBox ID="departidtxt" runat="server"></asp:TextBox>
            <asp:Button  OnClick="DepartIDSearch" runat="server" Text="Search Department ID" />

            <br />

            <label for="departnametxt">Department Name:</label><br />
            <asp:TextBox ID="departnametxt" runat="server"></asp:TextBox>
            <asp:Button OnClick="DepartNameSearch" runat="server" Text="Search Department Name" />
        </div>


        <div>
            <!-- div section for checkbuttons to hide or show columns -->

            <asp:CheckBoxList ID="ColumnCheckBoxList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Check_Clicked" Width="262px">
                <asp:ListItem Value="1">First Name</asp:ListItem>
                <asp:ListItem Value="3">Admin</asp:ListItem>
                <asp:ListItem Value="4">Phone</asp:ListItem>
                <asp:ListItem Value="5">Email</asp:ListItem>
                <asp:ListItem Value="6">Mail Info</asp:ListItem>
                <asp:ListItem Value="10">Last Login</asp:ListItem>
                <asp:ListItem Value="11">Department</asp:ListItem>
            </asp:CheckBoxList>



        </div>


        <p></p>


        <div>
            <!-- div section for all radio buttons to filter for admins or not admins-->
            <asp:RadioButton ID="RadBoth" runat="server" GroupName="adminstatus" Text="Both" AutoPostBack="true" OnCheckedChanged="RadBoth_CheckedChanged"/>
            <asp:RadioButton ID="RadAdmin" runat="server" GroupName="adminstatus" Text="Only Admins" AutoPostBack="true" OnCheckedChanged="RadAdmin_CheckedChanged"/>
            <asp:RadioButton ID="RadNonAdmin" runat="server" GroupName="adminstatus" Text="Only NonAdmins" AutoPostBack="true" OnCheckedChanged="RadNonAdmin_CheckedChanged"/>
        </div>


        <p></p>
        <div>

            
            <!-- Table using asp GridView and connecting to database  This will also serve as the default style for now, Allows for sorting and paging.-->
            <asp:GridView ID="EmployeeGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="2">
                <Columns>
                    
                    <asp:TemplateField ItemStyle-Width="150px" HeaderText="Employee ID" SortExpression="EmployeeID">
                        <ItemTemplate>
                            <%# Eval("EmployeeID") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" ItemStyle-Width="150" sortexpression="FirstName"/>    
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" ItemStyle-Width="150" sortexpression="LastName"/>
                    <asp:BoundField DataField="Admin" HeaderText="Admin" ItemStyle-Width="30" SortExpression="Admin" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" ItemStyle-Width="150" sortexpression="Phone"/> 
                    <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Width="150" sortexpression="Email"/> 
                    <asp:BoundField DataField="HomeAddress" HeaderText="Home Address" ItemStyle-Width="150" sortexpression="HomeAddress"/> 
                    <asp:BoundField DataField="City" HeaderText="City" ItemStyle-Width="150" sortexpression="City"/> 
                    <asp:BoundField DataField="ZIP" HeaderText="ZIP Code" ItemStyle-Width="30" SortExpression="ZIP" />
                    <asp:BoundField DataField="State" HeaderText="State" ItemStyle-Width="150" SortExpression="State" />
                    <asp:BoundField DataField="LastLogged" HeaderText="Last Login" ItemStyle-Width="150" SortExpression="LastLogged" />
                    <asp:BoundField DataField="DepartmentID" HeaderText="Department ID" ItemStyle-Width="150" SortExpression="DepartmentID" />
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" ItemStyle-Width="150" SortExpression="DepartmentName" />
                
                </Columns>
            </asp:GridView>
            <p></p>
            
        </div>
    </form>
</body>
</html>
