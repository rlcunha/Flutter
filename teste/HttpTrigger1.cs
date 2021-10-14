using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Data.SqlClient;

namespace Company.Function
{
    public static class HttpTrigger1
    {
        [FunctionName("HttpTrigger1")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Admin, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            string responseMessage = string.IsNullOrEmpty(name)
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
                : $"Hello, {name}. This HTTP triggered function executed successfully.";

//----------------------------------------------------------------------
            // Adding custom code to log messages to the Azure SQL Database
            // Creating the connection string
            string connectionString = "Server=tcp:srv-sql-ditalia.database.windows.net,1433;Initial Catalog=dbDitalia;Persist Security Info=False;User ID=lopes;Password=Cesabe01@@;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
 
            // Using the connection string to open a connection
            try{
                using(SqlConnection connection = new SqlConnection(connectionString)){
                    // Opening a connection
                    connection.Open();
 
                    // Defining the log message and Create Date
                    var logMessage = $"{name} has logged in.";
                    var createDate = DateTime.UtcNow;
 
                    // Prepare the SQL Query
                    var query = $"INSERT INTO [ApplicationLogs] ([LogMessage],[CreateDate]) VALUES('{logMessage}', '{createDate}')";
 
                    // Prepare the SQL command and execute query
                    SqlCommand command = new SqlCommand(query,connection);
 
                    // Open the connection, execute and close connection
                    if(command.Connection.State == System.Data.ConnectionState.Open){
                        command.Connection.Close();
                    }
                    command.Connection.Open();
                    command.ExecuteNonQuery();
 
                }
            }
            catch(Exception e){
                log.LogError(e.ToString());
                responseMessage = e.ToString();
            }
 
            //------------------------------------------------------------------

            return new OkObjectResult(responseMessage);
        }
    }
}
