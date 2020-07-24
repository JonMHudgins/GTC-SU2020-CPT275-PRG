using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// A class made to be used as an object in any webpages that has a database based table
/// </summary>
/// 

//Object is serializble in order to be usable in ViewState
[Serializable]
public class TableBase
{

    //Constructor used for initial loading of the page and table
    public TableBase(string query, string column)
    {
        Query = "SELECT * FROM " + query + " ";
        SortColumn = column;
        SortDirection = "ASC";
    }

    //Constructor used for postbacks along with ViewState
    public TableBase(string query, string column, string direction, string clause, string filter)
    {
        Query = "SELECT * FROM " + query + " ";
        SortColumn = column;
        SortDirection = direction;
        WhereClause = clause;
        Filter = filter;
    }

    //Properties used to store strings that need to be consistent through postbacks

    //String Property used to store the webpage's default query statement
    public string Query
    {
        get;set;
    }

    //String property used to store the last used/current sort column based on the name
    public string SortColumn
    {
        get;set;
    }

    //String property used to store the last used sorting direction on the table either ASC or DESC
    public string SortDirection
    {
        get;set;
    }

    //String property used to store the last used where clause statement 
    public string WhereClause
    {
        get;set;
    }

    //String property used to store the last used filter
    public string Filter
    {
        get;set;
    }



    public DataView BindGrid( string sortExpression = null, bool sort = false, bool where = false, string searchquery = null)  //Called to initially bind and display table on webpage with no sorting string by default || Search string is used to look for specific items with where clause statement
    {
        string constr = ConnectionString.GetConnectionString("invDBConStr");

        using (SqlConnection con = new SqlConnection(constr))  //Binds connection string to sql connection
        {

            string sqlquery = Query;  //The default query statement based on the webpage calling it

            if (where != false && searchquery != null) //Checks to see if a search is requested or not before sending statement and if it does a where clause is appended along with search string
            {
                sqlquery += "WHERE " + searchquery;
                WhereClause = searchquery;
                if (Filter != null) //If statement checks to see if the status filter string is null and if not will append the filter to the query
                {
                    sqlquery += " AND " + Filter;
                }
            }
            else if (WhereClause != null)  //Second check to see if the sorting method or new page index was called and if so will append the sotred wherecluase statement
            {
                sqlquery += "WHERE " + WhereClause;
                if (Filter != null)
                {
                    sqlquery += " AND " + Filter;
                }
            }
            else if (Filter != null) //checks to see if even in the event no other where clauses are being added that a status filter will still be appended
            {
                sqlquery += "WHERE " + Filter;
            }

            using (SqlCommand cmd = new SqlCommand(sqlquery))  //The query string sent to database
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())  //Creates new sqldataadapter to connect to database 
                {
                    cmd.Connection = con; //Connects to database using sqlconnection object

                    sda.SelectCommand = cmd; //Runs query select statement onto database
                    using (DataTable dt = new DataTable()) //Creates datatable to be filled by query
                    {
                        sda.Fill(dt);  //Fills the table with bound data
                        DataView dv = dt.AsDataView();

                        if (sortExpression != null)  //Any future column sorts are sent here after initial load and appends the desired sort direction to the query string.
                        {
                            if (sort) //checks to see if empty search was given in order to prevent sorting
                            {
                                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";  //swaps sorting direction if trying to use the same column to sort.
                            }
                            dv.Sort = sortExpression + " " + SortDirection;  //apends the column and sort direction to sort request.
           
                        }
                        SortColumn = sortExpression; //Updates the object's SortColumn string property to be the lastused sortexpression string 
                        return dv; //Returns generated dataview object based on query
                    }
                }
            }
        }
    }

    //Called when trying to sort columns on page.
    public DataView Sorting(GridViewSortEventArgs e)  
    {
        return BindGrid(e.SortExpression, true);  //Sends sort expression to refresh datatable
    }

    //Called when making use of paging on table when more than about 10 items by default
    public DataView Paging()  
    {
        return this.BindGrid(this.SortColumn);  //sends stored sorting column to reserve current sorting
    }

    //Method called when searching for specific items matching criteria with string
    public DataView Search(string search = "")
    {
        if (search != "")  //If condition on the case that the textbox being based on isnt empty
        {
            
            return BindGrid(SortColumn, false, true, search);  //Automatically will have the characters I- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            return RefreshTable("where");

        }
    }

    //Method used when a radio button filter has been cleared.
    public DataView FilterClear()
    {
        Filter = null;
        return RefreshTable();
    }

    //Method used when a radio button filter has been called for on the page.
    public DataView FilterActive(string f)
    {
        Filter = f;
        return RefreshTable();
    }

    //Method called when refreshing a table without needing to completely remake a statement
    public DataView RefreshTable( string element = null)  
    {

        if (element == "where")  //When refreshing a where clause it will also make the where clause null
        {
            WhereClause = null;
        }


        return BindGrid(SortColumn, false); //Clears any active filters on the table with a refresh
    }

}