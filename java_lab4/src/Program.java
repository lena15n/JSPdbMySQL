import dbcommunications.DBComm;

import java.sql.*;

public class Program {
    public static void main(String[] args) throws SQLException {
        DBComm.openConnection();

        ResultSet resultSet = dbcommunications.DBComm.selectAll(0);
        while(resultSet.next()){
            System.out.println(resultSet.getString("Name") + " and " + resultSet.getString("Manager_name") + ";");

        }

        System.out.println("---select end");

        //dbcommunications.DBComm.insertToSecondTable("ExampleOfManager", "ExampleSurname");

        //dbcommunications.DBComm.insertToFirstTable(5, "ExampleOfEmp");

        //DBComm.deleteFromFirstTable(133);


        DBComm.closeConnection();
    }
}


/*public class Program {
    private static final String USERNAME = "root";
    private static final String PASSWORD = "admin";
    private static final String URL = "jdbc:mysql://localhost:3306/my_java_db_schema";


    public static void main(String[] args) {
        Connection connection;
        PreparedStatement preparedStatement = null;

        try {
            Driver driver = new FabricMySQLDriver();
            DriverManager.registerDriver(driver);

            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            Statement statement = connection.createStatement();
            //statement.execute("INSERT INTO `my_java_db_schema`.`dependent_java_table`\n" +
            //       "(`Id`, `Name`, `Manager_id`) VALUES (12, \"Лала\", 6);");

            ResultSet result = statement.executeQuery("SELECT * FROM dependent_java_table");

            while(result.next()){
                String name = result.getString(2);
                System.out.println(name);
            }

            preparedStatement = connection.prepareStatement("INSERT INTO `my_java_db_schema`.`dependent_java_table`\n" +
                    "(`Id`, `Name`, `Manager_id`) " +
                    "VALUES (?, ?, ?);");

            preparedStatement.setInt(1, 133);
            preparedStatement.setString(2, "Ксения");
            preparedStatement.setInt(3, 4);
            preparedStatement.execute();

            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }


        /*
        try {
            Driver driver = new FabricMySQLDriver();
            DriverManager.registerDriver(driver);

            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            if(!connection.isClosed()){
                System.out.println("zbs");
            }

            connection.close();

            if(connection.isClosed()){
                System.out.println("closed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
            */
