
import com.sun.jdi.connect.spi.Connection;
import java.sql.Connection;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Fay12
 */
public class sql {
    
   public static void main(String[]args){
       
    try{  
   Class.forName("com.mysql.cj.jdbc.Driver");
    
   Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/university","root","");  

   Statement stmt=con.createStatement();
    
   ResultSet rs=stmt.executeQuery("select * from user"); 

   while(rs.next())  
    System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
     
   con.close();  
   
   }catch(Exception e){
    System.out.println(e);
   }
           
       }
   /* public static Connection getConnection() {
        Connection con = null;
        try {
            // Load the MySQL JDBC driver (optional if using newer versions of JDBC)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/table", "root", "3560");
            System.out.println("Connected to the database successfully!");

        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error connecting to the database.");
            e.printStackTrace();
        }
        return con;
    } */

   
}

