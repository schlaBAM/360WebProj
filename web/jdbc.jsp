<!--
A JSP file that encapsulates all database access.

Public methods:
- public void getConnection() throws SQLException
- public ResultSet executeQuery(String query) throws SQLException
- public void executeUpdate(String query) throws SQLException
- public void closeConnection() throws SQLException

-->

<%@ page import="java.sql.*" %>

<%!
    // User id, password, and server information
    private String url = "jdbc:mysql://localhost:3306/beerproject";
    private String uid = "root";
    private String pw = "1234";


    // Connection
    private Connection con = null;

%>

<%!
    public void getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
//            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, uid, pw);
        } catch (Exception e) {
            e.printStackTrace();
        }
        con = DriverManager.getConnection(url, uid, pw);
    }

    public void closeConnection() throws SQLException {
        if (con != null)
            con.close();
        con = null;
    }
%>
