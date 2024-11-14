public static Connection getConnection() {
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
    }