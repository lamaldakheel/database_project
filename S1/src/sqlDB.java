/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging-Level; 
 import java.util.logging.Logger;
 import javax.swing.JOptionPane;
 *
 * @author Fay12
 */
public class sqlDB extends javax.swing.JFrame {
    public static void main(String[]args){
        // Creates new form SearchJdbc
    }
        
        
        
public sqlDB() {
    initComponents();
    Connect();
}

Connection con;
PreparedStatement pst;
ResultSet rs;

public void Connect() {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/studcrud");
    } catch (ClassNotFoundException ex) {
        // Handle exception
    }
}
        
    }
    
}
