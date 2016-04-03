
<%--
  Created by IntelliJ IDEA.
  User: Lena
  Date: 14.03.2016
  Time: 0:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.*" %>
<%@ page import="dbcommunications.DBComm" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Calculator</title>
</head>
<body>

<div style="padding-left: 10%; height: 100%; width: 100%">
    <%
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
    %>


    <div style="width: 80%; height: 50%;">
        <div  style="margin-bottom: 15%; height: 100%; width: 100%">
            <p style=" margin-left: 20%; margin-bottom: -1%; margin-top: 2%"><b>ТАБЛИЦА 1</b></p>
            <table style="float: left; width: 50%; margin-bottom: 5%; padding: 3%;">
                <% %>
                <tr>
                    <th>Номер  <br>сотрудника</th>
                    <th>Имя <br>сотрудника</th>
                    <th>Номер <br>менеджера</th>
                </tr>

                <% DBComm.openConnection();

                    ResultSet resultSet1 = DBComm.selectAll(1);

                    while(resultSet1.next()){
                %>
                <tr><td><%out.println(resultSet1.getString("Id"));%></td>
                    <td><%out.println(resultSet1.getString("Name"));%></td>
                    <td><%out.println(resultSet1.getString("Manager_id"));%></td>
                </tr>

                <% }
                    DBComm.closeConnection();
                %>
            </table>


            <p style="margin-left: 75%; margin-top: -1%"><b>ТАБЛИЦА 2</b></p>
            <table style="margin-bottom: 5%; margin-top: -2%; width: 40%; float: right; padding: 2%; ">
                <% %>
                <tr>
                    <th>Номер  <br>менеджера</th>
                    <th>Фамилия <br>менеджера</th>
                    <th>Имя  <br>менеджера</th>
                </tr>

                <% DBComm.openConnection();

                    ResultSet resultSet2 = DBComm.selectAll(2);

                    while(resultSet2.next()){
                %>
                <tr><td><%out.println(resultSet2.getString("Manager_id"));%></td>
                    <td><%out.println(resultSet2.getString("Manager_first_name"));%></td>
                    <td><%out.println(resultSet2.getString("Manager_name"));%></td>
                </tr>

                <% }
                    DBComm.closeConnection();
                %>
            </table>
        </div>


        <div style="margin-top: 0; margin-left: 5%; margin-bottom: 5%; width: 500px; border: solid; text-align: center">
            <form style="text-align: center; align-content: center">
                <p><input type="submit" name="addInFirst" value="Вставить строку в первую таблицу" style="text-align: center; width: 300px;"></p>

            <table id="table">
            <tr>
                <th>Имя сотрудника</th>
                <th>Номер <br>менеджера</th>
            </tr>

            <tr>
                <td><input name="text11" maxlength="40" size="20" value="" style="left: 40px"></td>
                <td><input name="text12" maxlength="20" size="5" value="" style="left: 40px"></td>
            </tr>
            </table>
            </form>

            <%
            if(request!= null)
                if(request.getQueryString() != null) {
                    if (request.getParameter("addInFirst") != null) {
                        int manager_id = Integer.valueOf(request.getParameter("text12"));
                        String nameEmpl = request.getParameter("text11");

                        DBComm.openConnection();

                        DBComm.insertToFirstTable(manager_id, nameEmpl);

                        DBComm.closeConnection();

                        out.println("Строка была добавлена!<br>");

            %>
            <a href="index.jsp">Обновите страницу</a>
            <%
                    }
                }

        %>

        </div>


        <div style="margin: 5%; width: 500px; border: solid;">
            <form style="text-align: center; align-content: center">
                <p><input type="submit" name="addInSecond" value="Вставить строку во вторую таблицу" style="text-align: center; width: 300px;"></p>

                <table id="table2">
                    <tr>
                        <th>Фамилия менеджера</th>
                        <th>Имя менеджера</th>
                    </tr>

                    <tr>
                        <td><input name="text21" maxlength="40" size="20" value="" style="left: 40px"></td>
                        <td><input name="text22" maxlength="20" size="15" value="" style="left: 40px"></td>
                    </tr>
                </table>
            </form>

            <%
                if(request!= null)
                    if(request.getQueryString() != null) {
                        if (request.getParameter("addInSecond") != null) {
                            String surname = request.getParameter("text21");
                            String name = request.getParameter("text22");

                            DBComm.openConnection();

                            DBComm.insertToSecondTable(surname, name);

                            DBComm.closeConnection();

                            out.println("Строка была добавлена!<br>");

            %>
            <a href="index.jsp">Обновите страницу</a>
            <%
                        }
                    }

            %>

        </div>

        <div style="margin: 5%; width: 500px; border: solid;">
            <form style="text-align: center; align-content: center">
                <p><input type="submit" name="deleteFromFirst" value="Удалить строку из первой таблицы" style="text-align: center; width: 300px;">
                </p>

                    <label>Введите номер сотрудника:
                            <input name="delete1" maxlength="10" size="10" value="" style="left: 40px">
                    </label>
            </form>

            <%
                if(request!= null)
                    if(request.getQueryString() != null) {
                        if (request.getParameter("deleteFromFirst") != null) {
                            int idToDelete = Integer.valueOf(request.getParameter("delete1"));

                            DBComm.openConnection();

                            DBComm.deleteFromFirstTable(idToDelete);

                            DBComm.closeConnection();

                            out.println("Строка №" + idToDelete + " была удалена!<br>");

            %>
            <a href="index.jsp">Обновите страницу</a>
            <%
                        }
                    }

            %>
        </div>




        <div style="margin: 5%; width: 500px; border: solid;">
            <form style="text-align: center; align-content: center">
                <p> <input type="submit" name="deleteFromSecond" value="Удалить строку из второй таблицы" style="text-align: center; width: 300px;">
                </p>

                <label>Введите номер менеджера:
                    <input name="delete2" maxlength="10" size="10" value="" style="left: 40px">
                </label>
            </form>

            <%
                if(request!= null)
                    if(request.getQueryString() != null) {
                        if (request.getParameter("deleteFromSecond") != null) {
                            int idToDelete = Integer.valueOf(request.getParameter("delete2"));

                            DBComm.openConnection();

                            DBComm.deleteFromSecondTable(idToDelete);

                            DBComm.closeConnection();

                            out.println("Строка №" + idToDelete + " была удалена!<br>");

            %>
            <a href="index.jsp">Обновите страницу</a>
            <%
                        }
                    }

            %>

        </div>


        <div  style="margin: 5%; width: 500px; float: left; border: solid">
            <form style="text-align: center">
                <p><input type="submit" name="selectAll" value="Выбрать все" style="text-align: center; width: 300px;"></p>
            </form>

            <table style="width: 20%; align-items: center">
                <tr>
                    <th>Номер</th>
                    <th>Имя</th>
                    <th>Номер<br>менеджера</th>
                    <th>Фамилия менеджера</th>
                    <th>Имя менеджера</th>
                </tr>

                <%  if(request!= null)
                    if(request.getQueryString() != null) {
                        if (request.getParameter("selectAll") != null) {
                            DBComm.openConnection();

                            ResultSet resultSet = DBComm.selectAll(0);

                            while(resultSet.next()){
                %>
                <tr><td><%out.println(resultSet.getString("Id"));%></td>
                    <td><%out.println(resultSet.getString("Name"));%></td>
                    <td><%out.println(resultSet.getString("Manager_id"));%></td>
                    <td><%out.println(resultSet.getString("Manager_first_name"));%></td>
                    <td><%out.println(resultSet.getString("Manager_name"));%></td>
                </tr>

                <% }
                    DBComm.closeConnection();
                %>
            </table>
            <%
                            out.println("<br><br><br><br><br><br>");

                        }
                    }%>

        </div>
    </div>
</div>

</body>
</html>

