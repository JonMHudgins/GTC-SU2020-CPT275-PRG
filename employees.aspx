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
                <asp:ListItem Value="2">Admin</asp:ListItem>
                <asp:ListItem Value="3">Department Info</asp:ListItem>
                <asp:ListItem Value="5">Phone</asp:ListItem>
                <asp:ListItem Value="6">Email</asp:ListItem>
                <asp:ListItem Value="7">Home Address</asp:ListItem>
                <asp:ListItem Value="8">Last Login</asp:ListItem>
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
            <asp:GridView ID="EmployeeGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" emptydatatext="No data available." OnSorting="ItemLookUp_Sorting" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                <Columns>
                    
                    <asp:TemplateField ItemStyle-Width="150px" HeaderText="Employee ID" SortExpression="ID">
                        <ItemTemplate>
                            <%# Eval("ID") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="150" sortexpression="Name"/>    
                    <asp:BoundField DataField="Admin" HeaderText="Admin" ItemStyle-Width="30" SortExpression="Admin" />
                    <asp:BoundField DataField="DepartmentID" HeaderText="Department ID" ItemStyle-Width="150" SortExpression="DepartmentID" />
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" ItemStyle-Width="150" SortExpression="DepartmentName" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" ItemStyle-Width="150" sortexpression="Phone"/> 
                    <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Width="150" sortexpression="Email"/> 
                    <asp:BoundField DataField="Address" HeaderText="Home Address" ItemStyle-Width="150" sortexpression="Address"/> 
                    <asp:BoundField DataField="LastLogged" HeaderText="Last Login" ItemStyle-Width="150" SortExpression="LastLogged" />

                
                </Columns>
            </asp:GridView>
            <p></p>
            
        </div>
    </form>
</body>
</html>
