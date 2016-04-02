
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




<div style="padding-left: 20%">
    <%  boolean isConnOpen = false;

       /*
            if (request.getParameter("plusButton") != null) {
                out.println("Result: " + no1 + " + " + no2 + " = " + (no1 + no2));
            } else if (request.getParameter("minusButton") != null) {
                out.println("Result: " + no1 + " - " + no2 + " = " + (no1 - no2));
            } else if (request.getParameter("multButton") != null) {
                out.println("Result: " + no1 + " * " + no2 + " = " + (no1 * no2));
            } else if (request.getParameter("divideButton") != null) {
                out.println("Result: " + no1 + " / " + no2 + " = " + (no1 / no2));
            }
*/


    %>


    <div style="width: 70%; height: 50%;">
        <div  style="margin: 5%">
        <table style="margin-bottom: 5%; padding: 2%; float: left;">
            <% %>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>fname</th>
            </tr>
          <tr>
              <td>fsdgf</td>
              <td>wwdsfsdgf</td>
              <td>aawdew</td>
          </tr>
            <tr>
                <td>qqfsdfsdgf</td>
                <td>qqwwdsfsdgf</td>
                <td>qqaawdew</td>
            </tr>
        </table>

        <table style="float: right; padding: 2%">
            <% %>
            <tr>
                <th>man id</th>
                <th>man name</th>
                <th>man fname</th>
            </tr>
            <tr>
                <td>fsdgf</td>
                <td>wwdsfsdgf</td>
                <td>aawdew</td>
            </tr>
            <tr>
                <td>qqfsdfsdgf</td>
                <td>qqwwdsfsdgf</td>
                <td>qqaawdew</td>
            </tr>
        </table>
        </div>

        <div style="margin: 5%; width: 300px; margin-left: 30%; margin-top: 10%">
            <form name="form1" >
           <p></p><p><input type="submit" name="selectAll" value="Выбрать все" style="text-align: center; width: 300px;">
           </p><p> <input type="submit" name="addInFirst" value="Добавить запись в первую таблицу" style="text-align: center; width: 300px;">
            </p><p><input type="submit" name="addInSecond" value="Добавить запись во вторую таблицу" style="text-align: center; width: 300px;">
            </p><p><input type="submit" name="deleteFromFirst" value="Удалить строку из первой таблицы" style="text-align: center; width: 300px;">
           </p><p> <input type="submit" name="deleteFromSecond" value="Удалить строку из второй таблицы" style="text-align: center; width: 300px;">
        </p>
            </form>
        </div>

        <div>

            <table style="width: 20%">
                <%  if(request!= null)
                    if(request.getQueryString() != null) {
                    if (request.getParameter("selectAll") != null) {
                        if(!isConnOpen) {
                            DBComm.openConnection();
                            isConnOpen = true;
                        }

                        ResultSet resultSet = DBComm.selectAll();

                        while(resultSet.next()){
                %>
                <tr><td><%System.out.println(resultSet.getString("Id"));%></td>
                    <td><%System.out.println(resultSet.getString("Name"));%></td>
                    <td><%System.out.println(resultSet.getString("Manager_id"));%></td>
                    <td><%System.out.println(resultSet.getString("Manager_first_name"));%></td>
                    <td><%System.out.println(resultSet.getString("Manager_name"));%></td>
                </tr>

                <%}

                }
            }%>
                <tr>
                    <th>ex id</th>
                    <th>ex name</th>
                    <th>exfname</th>
                </tr>
                <tr>
                    <td>fsdgf</td>
                    <td>wwdsfsdgf</td>
                    <td>aawdew</td>
                </tr>
                <tr>
                    <td>qqfsdfsdgf</td>
                    <td>qqwwdsfsdgf</td>
                    <td>qqaawdew</td>
                </tr>
            </table>
        </div>

    </div>


 <%-- <form name="form1" >
    <p><strong>Введите числа:</strong></p>

    <%
      /*int no1 = 1, no2 = 1;
      if(request.getQueryString() != null){
        no1 = Integer.valueOf(request.getParameter("number1"));
        no2 = Integer.valueOf(request.getParameter("number2"));
      }*/
    %>

    <input name="number1" maxlength="10" size="5" value="<%=no1%>" style="left: 40px">

    <input name="number2" maxlength="10" size="5" value="<%=no2%>" style="left: 40px">

    <br>
    <br>

    <div style="padding-left: 20px; margin-bottom: -20px">
      <input type="submit" name="plusButton" value="+" style="text-align: center; width: 50px;">
      <input type="submit" name="minusButton" value="-" style="text-align: center; width: 50px;">
      <br>
      <br>

      <input type="submit" name="multButton" value="*" style="text-align: center; width: 50px;">
      <input type="submit" name="divideButton" value="/" style="text-align: center; width: 50px;">
    </div>
  </form>

  <br>

  <%

    /*if(request.getQueryString() != null) {
      if (request.getParameter("number1").equals("")) {
        no1 = 0;
      } else {
        no1 = Integer.valueOf(request.getParameter("number1"));
      }
      if (request.getParameter("number2").equals("")) {
        no2 = 0;
      } else {
        no2 = Integer.valueOf(request.getParameter("number2"));
      }
      if (request.getParameter("plusButton") != null) {
        out.println("Result: " + no1 + " + " + no2 + " = " + (no1 + no2));
      } else if (request.getParameter("minusButton") != null) {
        out.println("Result: " + no1 + " - " + no2 + " = " + (no1 - no2));
      } else if (request.getParameter("multButton") != null) {
        out.println("Result: " + no1 + " * " + no2 + " = " + (no1 * no2));
      } else if (request.getParameter("divideButton") != null) {
        out.println("Result: " + no1 + " / " + no2 + " = " + (no1 / no2));
      }

      //session.setAttribute("number1", no1);
      //session.setAttribute("number2", no2);
    }*/


  %>--%>
</div>

</body>
</html>

