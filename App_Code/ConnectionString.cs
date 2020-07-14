using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for ConnectionString
/// </summary>
public class ConnectionString
{
    public ConnectionString()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetConnectionString(string keyname)
    {
        string connection = string.Empty;
        switch (keyname)
        {
            case "invDBConStr":
                connection = ConfigurationManager.ConnectionStrings["invDBConStr"].ConnectionString;
                break;
            default:
                break;
        }
        return connection;

    }
}