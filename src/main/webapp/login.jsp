<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPA - Gestão de Produtividade Acadêmica</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estiloGeral.css">
    <link rel="stylesheet" href="css/estiloLogin.css">
</head>

<body>

<main class="auth-container">
    <form action="LoginServlet" method="post">

        <section class="auth-header">
            <h2>
                <i class="fa-solid fa-graduation-cap"></i> - GPA
            </h2>
            <h2>
                Gestão de <br>
                Produtividade <br>
                Acadêmica
            </h2>
        </section>

        <section class="auth-body">
            <label for="email">E-mail</label>
            <input type="text" autocomplete="off" id="email" name="emailAluno" placeholder="seuemail@gmail.com" required>

            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senhaAluno" placeholder="senhaexemplo" required>

            <input type="submit" value="ENTRAR">

            <%
                String erro = (String) request.getAttribute("erroLogin");
                if(erro != null){
            %>
            <p><%= erro %></p>
            <% } %>

            <section class="auth-footer">
                Não possuí conta? <a href="cadastro.jsp">cadastre-se</a>
            </section>
        </section>

    </form>



</main>
<footer>
    <span> © <%= java.time.Year.now().getValue() %> GPA — Desenvolvido por Isabela de Oliveira Athayde e Gabriela da Costa Castro. Todos os direitos reservados.</span>
</footer>
</body>
</html>