<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>GPA - Gestão de Produtividade Acadêmica</title>
</head>
<body>
    <form action="LoginServlet" method="post">
        <label>Email:</label>
        <input type="text" name="emailAluno" required> <br><br>

        <label>Senha:</label>
        <input type="password" name="senhaAluno" required> <br><br>

        <input type="submit" value="Entrar">
        <%
            String erro=(String) request.getAttribute("erroLogin");
            if(erro!=null){
        %>
            <p><%= erro %></p><% } %>
    </form>
</body>
</html>