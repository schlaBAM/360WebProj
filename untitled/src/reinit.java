package untitled.src;
import java.io.File;
import java.sql.*;
import java.util.Scanner;

public class reinit{
    public static void main(String[]args){

        Connection connection;
        try
        {
            String path = "\\CashmereFreeway\\web\\SQLDDL\\TableDDL.txt";
            File test = new File(path);
            File currentDir = new File(".");
            File parentDir = currentDir.getParentFile();
            File newFile = new File(parentDir,"web/SQLDDL/CashmereDDL.txt");
            // Create statement
            String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_jsoloshy";
            String uid = "jsoloshy";
            String pw = "34620104";

            System.out.println("Connecting to database.");
            // Note: Must assign connection to instance variable as well as returning it back to the caller
            connection = DriverManager.getConnection(url, uid, pw);

            Statement statement = connection.createStatement();

            Scanner scanner = new Scanner(newFile);
            // Read commands separated by ;
            scanner.useDelimiter(";");
            while (scanner.hasNext())
            {
                String command = scanner.next();
                if (command.trim().equals(""))
                    continue;
                // System.out.println(command);        // Uncomment if want to see commands executed
                statement.execute(command);
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
        }


    }


}