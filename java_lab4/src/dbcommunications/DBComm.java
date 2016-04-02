package dbcommunications;

import com.mysql.fabric.jdbc.FabricMySQLDriver;

import java.sql.*;
import java.util.Properties;

/**
 * Created by Lena on 24.03.2016.
 */
public class DBComm {
    private static final String USERNAME = "root";
    private static final String PASSWORD = "admin";
    private static final String URL = "jdbc:mysql://localhost:3306/my_java_db_schema";
    private static int id = 10000;
    private static Connection connection;

    public static void openConnection() {
        PreparedStatement preparedStatement = null;

        try {
            //Driver driver = new FabricMySQLDriver();
            //DriverManager.registerDriver(driver);//это должно вызываться автоматически, не писать так
            Class.forName("com.mysql.fabric.jdbc.FabricMySQLDriver").newInstance();//динамически подгружает драйвер
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet selectAll(int flag) {
        Statement statement = null;
        String query = null;

        switch(flag) {
            case 0:{
                query = "Select * From my_java_db_schema.dependent_java_table LEFT JOIN my_java_db_schema.main_table ON (my_java_db_schema.dependent_java_table.Manager_id = my_java_db_schema.main_table.Manager_id);";
                        /*"Select *\n" +
                        "From my_java_db_schema.dependent_java_table \n" +
                        "LEFT JOIN my_java_db_schema.main_table \n" +
                        "ON (my_java_db_schema.dependent_java_table.Manager_id = " +
                        "my_java_db_schema.main_table.Manager_id);";*/
            }
            break;

            case 1:{
                query = "Select * From my_java_db_schema.dependent_java_table;";
            }
            break;

            case 2:{
                query = "Select * From my_java_db_schema.main_table";
            }
            break;
        }

        try {
            statement = connection.createStatement();
            return statement.executeQuery(query);

        } catch (SQLException e) {
            e.printStackTrace();

            return null;
        }
    }

    public static void insertToSecondTable(String firstName, String name) {
        Statement statement = null;
        id = findMaxId() + 1;



        try {
            statement = connection.createStatement();
            statement.execute("INSERT INTO `my_java_db_schema`.`main_table`" +
                                "(`Manager_id`, `Manager_first_name`, `Manager_name`) VALUES " +
                                "(" + id + ", '" + firstName + "', '"+ name +"');");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void insertToFirstTable(int managerId, String name) {
        Statement statement = null;
        id = findMaxId() + 1;

        try {
            statement = connection.createStatement();
            statement.execute("INSERT INTO `my_java_db_schema`.`dependent_java_table`\n" +
                    "(`Id`, `Name`, `Manager_id`) VALUES " +
                    "(" + id + ", '" + name + "', '"+ managerId +"');");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void closeConnection() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteFromSecondTable(int idOfItem) {
        try {
            PreparedStatement findDependendIdsStatement = connection.prepareStatement("SELECT Id FROM `my_java_db_schema`.`dependent_java_table`\n" +
                    "WHERE `my_java_db_schema`.`dependent_java_table`.Manager_id = ? ;");

            findDependendIdsStatement.setInt(1, idOfItem);
            ResultSet dependentIds = findDependendIdsStatement.executeQuery();

            while(dependentIds.next()){
                int depId = dependentIds.getInt(1);

                deleteFromFirstTable(depId);
            }



            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM `my_java_db_schema`.`main_table` WHERE " +
                    "`my_java_db_schema`.`main_table`.Manager_id = ? ;");

            preparedStatement.setInt(1, idOfItem);
            preparedStatement.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteFromFirstTable(int idOfItem) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM `my_java_db_schema`.`dependent_java_table`\n" +
                    "WHERE `my_java_db_schema`.`dependent_java_table`.Id = ? ;");
            preparedStatement.setInt(1, idOfItem);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static int findMaxId(){
        Statement statement = null;
        ResultSet resultSet;
        int maxId = 1000;
        String query1 = "SELECT MAX(Id) FROM dependent_java_table";
        String query2 = "SELECT MAX(Manager_id) FROM main_table";

        try {

            statement = connection.createStatement();
            resultSet = statement.executeQuery(query1);
            resultSet.next();
            maxId = resultSet.getInt(1);

            resultSet = statement.executeQuery(query2);
            resultSet.next();
            int temp = resultSet.getInt(1);

            if(maxId < temp)
                maxId = temp;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxId;
    }

    /*public static void deleteFromFirstTable(int idOfItem) {
        try {
            Statement statement = connection.createStatement();
            statement.execute("DELETE FROM `my_java_db_schema`.`dependent_java_table`\n" +
                    "WHERE `my_java_db_schema`.`dependent_java_table`.Manager_id = " + idOfItem +
            "; DELETE FROM `my_java_db_schema`.`main_table` WHERE " +
            "`my_java_db_schema`.`main_table`.Manager_id = " + idOfItem + ";");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteFromSecondTable(int idOfItem) {
        try {
            Statement statement = connection.createStatement();
            statement.execute("DELETE FROM `my_java_db_schema`.`main_table` WHERE " +
                    "`my_java_db_schema`.`main_table`.Manager_id = " + idOfItem + ";");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }*/
}
