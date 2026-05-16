<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.*" %>
<%@ page import="conectores.*" %>
<%@ page import="com.google.api.services.calendar.model.Event" %>

<%
    // dados login
    if(session.getAttribute("alunoAtivo")==null){
        response.sendRedirect("login.jsp");
        return;
    }
    Aluno alunoSessao=(Aluno) session.getAttribute("alunoAtivo");
    int idLogado=alunoSessao.getId();
    String nomeExibicao=alunoSessao.getNome();

     String googleToken = (String) session.getAttribute("googleAccessToken");

     String refreshToken = (String) session.getAttribute("googleRefreshToken");

     boolean googleAutenticado =
            googleToken != null && !googleToken.isEmpty()
            && refreshToken != null && !refreshToken.isEmpty();

     List<Event> eventosGoogle = new ArrayList<>();

     if (googleAutenticado) {
         GoogleCalendarConector googleConector = new GoogleCalendarConector();
         eventosGoogle = googleConector.listarEventos(
                 googleToken,
                 refreshToken,
                 session
         );
     }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPA - Gestão de Produtividade Acadêmica</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.css" rel="stylesheet">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/estiloGeral.css?v=1">
    <link rel="stylesheet" href="css/estiloModal.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/estiloCalendario.css?v=1">
</head>
<body>

<aside>
    <i id="logo" class="fa-solid fa-graduation-cap"></i>
    <nav>
        <ul>
            <li class="link_animation" onclick="window.location.href='index.jsp'"><i class="fa-solid fa-house"></i> Desempenho</li>
            <li class="link_animation" onclick="window.location.href='notas.jsp'"><i class="fa-regular fa-copy"></i> Notas</li>
            <li class="link_animation" onclick="window.location.href='atividades.jsp?filtro=atribuida'"><i class="fa-solid fa-list"></i> Atividades</li>
            <li class="active" onclick="window.location.href='calendario.jsp'"><i class="fa-regular fa-calendar"></i> Calendário</li>
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
    <section id="calendar-header">
    <h2>Calendário</h2>
    <% if(googleToken == null){ %>

           <a class="google-btn" href="<%= request.getContextPath() %>/GoogleOAuthServlet">
               <i class="fa-brands fa-google"></i>
               Conectar Google Calendar
           </a>

       <% } else { %>

           <a class="google-btn">
               <i class="fa-brands fa-google"></i>
               <i class="fa-solid fa-check"></i>
           </a>

       <% } %>
       </section>

       <section>
           <% if (!googleAutenticado) { %>

           <div class="aviso">
               <p>Você não está conectado ao Google Calendar.</p>
               <p>Os eventos não serão exibidos.</p>
           </div>

           <% } %>
           <div id="calendar"></div>
       </section>

</main>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js"></script>
<script type="text/javascript">
window.eventos = [
<%
for(int i = 0; i < eventosGoogle.size(); i++) {

    Event evento = eventosGoogle.get(i);

    String titulo = evento.getSummary() != null ? evento.getSummary() : "Sem título";

    String dataInicio = (evento.getStart().getDateTime() != null)
        ? evento.getStart().getDateTime().toStringRfc3339()
        : evento.getStart().getDate().toString();

    String dataFim = (evento.getEnd().getDateTime() != null)
        ? evento.getEnd().getDateTime().toStringRfc3339()
        : evento.getEnd().getDate().toString();
%>
{
    id: "<%= i %>",
    title: "<%= titulo.replace("\"","\\\"").replace("\n"," ") %>",
    start: "<%= dataInicio %>",
    end: "<%= dataFim %>",
    url: "<%= evento.getHtmlLink() %>"
}
<%= (i < eventosGoogle.size()-1) ? "," : "" %>
<% } %>
];
</script>
<script src="js/scriptCalendario.js"></script>

</body>
</html>