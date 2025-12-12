package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * connect to database
 *
 * @author dat20
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "sa";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=MiniWallet;encrypt=true;trustServerCertificate=true";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            System.err.println("Lỗi kết nối DB: " + ex.getMessage());
        }
    }
}
