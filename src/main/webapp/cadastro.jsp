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
    <form action="CadastroServlet" autocomplete="off" method="post">

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
            <label for="nome">Nome</label>
            <input type="text" id="nome" autocomplete="off" name="nomeAluno" placeholder="Digite seu nome..." required>

            <label for="escolaridade">Escolaridade</label>
            <select id="escolaridade" name="escolaridade" class="select-custom" required>
                <option value="" disabled selected>Selecione</option>
                <option value="fundamental">Ensino Fundamental</option>
                <option value="medio">Ensino Médio</option>
                <option value="superior">Ensino Superior</option>
            </select>

            <label for="email">E-mail</label>
            <input type="text" id="email" autocomplete="off" name="emailAluno" placeholder="seuemail@gmail.com" required>

            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senhaAluno" placeholder="senhaexemplo" required>

            <input type="submit" value="CADASTRAR">

            <%
                String erro = (String) request.getAttribute("erroCadastro");
                if(erro != null){
            %>
            <p><%= erro %></p>
            <% } %>

            <section class="auth-footer">
                Possuí conta? <a href="login.jsp">Faça Login</a>
            </section>
        </section>

    </form>
</main>

<footer>
    <span> © <%= java.time.Year.now().getValue() %> GPA — Desenvolvido por Isabela de Oliveira Athayde e Gabriela da Costa Castro. Todos os direitos reservados.</span>
</footer>

</body>
</html>