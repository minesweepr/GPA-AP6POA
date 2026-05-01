<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="conectores.*" %>

<%
    // dados login
    if(session.getAttribute("alunoAtivo")==null){
        response.sendRedirect("login.jsp");
        return;
    }
    Aluno alunoSessao=(Aluno) session.getAttribute("alunoAtivo");
    int idLogado=alunoSessao.getId();
    String nomeExibicao=alunoSessao.getNome();

    // instanciando os conectores (DAOs) da pasta 'conectores'
    MateriaConector materiaDao=new MateriaConector();
    SemestreConector semestreDao=new SemestreConector();
    // listagem e selecao de semestre
    List<Semestre> listaSemestres=semestreDao.listarPorAluno(idLogado);
    if(listaSemestres==null) listaSemestres=new ArrayList<>();

    String paramSemestre=request.getParameter("semestreId");
    int semestreAtivoId=0;

    if(paramSemestre!=null) semestreAtivoId=Integer.parseInt(paramSemestre);
    else if(!listaSemestres.isEmpty()) semestreAtivoId=listaSemestres.get(0).getIdSemestre();
%>
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
            <li class="active" onclick="window.location.href='index.jsp'"><i class="fa-solid fa-house"></i> Desempenho</li>
            <li class="link_animation" onclick="window.location.href='notas.jsp'"><i class="fa-regular fa-copy"></i> Notas</li>
            <li class="link_animation" onclick="window.location.href='atividades.jsp'"><i class="fa-solid fa-list"></i> Atividades</li>
            <li class="link_animation" onclick="window.location.href='calendario.jsp'"><i class="fa-regular fa-calendar"></i> Calendário</li>
        </ul>
    </nav>

    <section>
        <ul>
            <li id="nome-usuario-logado"><i class="fa-regular fa-user"></i> Olá, <%= nomeExibicao %>!</li>
            <li id="sair" onclick="window.location.href='LogoutServlet'"><i class="fa-solid fa-right-from-bracket"></i> Sair</li>
        </ul>
    </section>
</aside>

<main>
    <section id="semestre-tabs">
        <ul>
            <%
                int cont=1;
                for(Semestre s : listaSemestres){
                    String classeAtiva=(s.getIdSemestre()==semestreAtivoId)?"active" : "";
            %>
                <li class="tab <%= classeAtiva %>"
                    onclick="window.location.href='notas.jsp?semestreId=<%= s.getIdSemestre() %>'"
                    style="cursor: pointer;">
                    <div>
                        <span class="num"><%= cont %></span>
                        <%= s.getTitulo() %>
                    </div>
                    <i class="fa-solid fa-ellipsis-vertical"></i>
                </li>
            <%
                    cont++;
                }
            %>
        </ul>
    </section>

    <section>
        <h2>teste h2</h2>
        <h3>teste h3</h3>
        <p>teste p</p>
    </section>

    <section>
        <!--usar essa classe pra tudo com fundo branco e sombra-->
        <div class="white-card">
            <p>teste card</p>
            <button class="btn-basico secundario">exemplo botao 1</button>
            <button class="btn-basico">exemplo botao 2</button>
        </div>
    </section>
</main>

</body>
</html>