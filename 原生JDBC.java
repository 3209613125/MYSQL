import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;


public class JDBCCase1 {
    public static void main(String[] args)  {
//        1. 加载驱动（pom文件中配置MySQL驱动程序，通过Class加载驱动类）
        try {
            Class.forName("com.mysql.jdbc.Driver");

//        2. 创建连接
            Connection connection =  DriverManager.getConnection
                    ("jdbc:mysql://127.0.0.1:3306/memo?user=root&password=88888888&useSSL=false");

//        3. 准备SQL语句
            String sql = "select id,name,created_time,modify_time from memo_group";
//        4. 创建命令
            Statement statement = connection.createStatement();
//        5. 执行命令
            ResultSet resultSet = statement.executeQuery(sql);
//        6. 返回结果处理
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                LocalDateTime createdTime = resultSet.getTimestamp("created_time").toLocalDateTime();
                LocalDateTime modifyTime = resultSet.getTimestamp("modify_time").toLocalDateTime();
                System.out.println(id + " " + name + " " + createdTime + " " + modifyTime + " ");
            }
//        7. 关闭结果
            resultSet.close();
//        8. 关闭命令
            statement.close();
//        9. 关闭连接
            connection.close();
        }
     catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    }
}
