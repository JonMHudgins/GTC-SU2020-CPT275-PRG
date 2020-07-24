using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Transactions;
using System.Data.SqlClient;

/// <summary>
/// Summary description for CreateTransactionScope
/// </summary>
static public class CreateTransactionScope 
{
    // This function takes arguments for 2 connection strings and commands to create a transaction 
    // involving two SQL Servers. It returns a value > 0 if the transaction is committed, 0 if the 
    // transaction is rolled back. To test this code, you can connect to two different databases 
    // on the same server by altering the connection string, or to another 3rd party RDBMS by 
    // altering the code in the connection2 code block.
    static public int MakeTransactionScope(
        string commandchange)
    {
        string connectString1 = ConnectionString.GetConnectionString("invDBConStr");
        // Initialize the return value to zero and create a StringWriter to display results.
        int returnValue = 0;
        System.IO.StringWriter writer = new System.IO.StringWriter();

        try
        {
            // Create the TransactionScope to execute the commands, guaranteeing
            // that both commands can commit or roll back as a single unit of work.
            using (TransactionScope scope = new TransactionScope())
            {
                using (SqlConnection connection1 = new SqlConnection(connectString1))
                {
                    // Opening the connection automatically enlists it in the 
                    // TransactionScope as a lightweight transaction.
                    connection1.Open();

                    // Create the SqlCommand object and execute the first command.
                    SqlCommand command1 = new SqlCommand(commandchange, connection1);
                    returnValue = command1.ExecuteNonQuery();
                    writer.WriteLine("Rows to be affected by command1: {0}", returnValue);


                }

                // The Complete method commits the transaction. If an exception has been thrown,
                // Complete is not  called and the transaction is rolled back.
                scope.Complete();
            }
        }
        catch (TransactionAbortedException ex)
        {
            writer.WriteLine("TransactionAbortedException Message: {0}", ex.Message);
        }

        // Display messages.
        Console.WriteLine(writer.ToString());

        return returnValue;
    }

}