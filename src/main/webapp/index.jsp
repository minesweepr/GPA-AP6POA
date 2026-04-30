<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPA - Gestão de Produtividade Acadêmica</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estiloGeral.css">
</head>
<body>

<aside>
    <i id="logo" class="fa-solid fa-graduation-cap"></i>
    <nav>
        <ul>
            <li class="link_animation"><i class="fa-solid fa-house"></i> Desempenho</li>
            <li class="active"><i class="fa-regular fa-copy"></i> Notas</li>
            <li class="link_animation"><i class="fa-solid fa-list"></i> Atividades</li>
            <li class="link_animation"><i class="fa-regular fa-calendar"></i> Calendário</li>
        </ul>
    </nav>

    <section>
        <ul>
            <li id="nome-usuario-logado"><i class="fa-regular fa-user"></i> Olá, NOME!</li>
            <li id="sair"><i class="fa-solid fa-right-from-bracket"></i> Sair</li>
        </ul>
    </section>
</aside>

<main>
    <section id="semestre-tabs">
        <ul>
            <li class="tab active"><div><span class="num">1</span> 2026.1</div><i class="fa-solid fa-ellipsis-vertical"></i></li>
            <li class="tab"><div><span class="num">2</span> 2025.2</div><i class="fa-solid fa-ellipsis-vertical"></i></li>
        </ul>
    </section>

    <section>
        <h2>teste h2</h2>
        <h3>teste h3</h3>
        <p>teste p</p>
    </section>

    <section>
        <!--usar essa classe pra tudo com fundo branco e sombra-->
        <div class="white-card"><p>teste card</p></div>
    </section>
</main>

</body>
</html>