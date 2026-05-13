<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
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

    TrabalhoConector trabalhoDao =
       new TrabalhoConector();

    List<Trabalho> trabalhos =
       trabalhoDao.listarPorSemestre(
           idLogado,
           semestreAtivoId
       );

    AlunoMateriaConector alunoMateriaDao =
            new AlunoMateriaConector();

    List<AlunoMateria> materiasSemestre =
            alunoMateriaDao.listarPorSemestre(
                    idLogado,
                    semestreAtivoId
            );

    String filtro =
            request.getParameter(
                    "filtro"
            );

    if(filtro == null){
        filtro = "atribuida";
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPA - Gestão de Produtividade Acadêmica</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estiloGeral.css">
    <link rel="stylesheet" href="css/estiloModal.css">
    <link rel="stylesheet" href="css/estiloAtividade.css">
</head>
<body>

<aside>
    <i id="logo" class="fa-solid fa-graduation-cap"></i>
    <nav>
        <ul>
            <li class="link_animation" onclick="window.location.href='index.jsp'"><i class="fa-solid fa-house"></i> Desempenho</li>
            <li class="active" onclick="window.location.href='notas.jsp'"><i class="fa-regular fa-copy"></i> Notas</li>
            <li class="link_animation" onclick="window.location.href='atividades.jsp?filtro=atribuida'"><i class="fa-solid fa-list"></i> Atividades</li>
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

   <%@ include file="WEB-INF/includes/listarSemestres.jsp" %>

   <%-- Seção De Prazo. MEXER SOMENTE NESSA SEÇÃO--%>
   <h2>Prazo de atividades</h2>
   <div class="courses-grid" id="container-lista-disciplinas">

   <%
   for(AlunoMateria am : materiasSemestre){

       Materia m = am.getMateria();
       boolean tem = false;
   %>

   <div class="course-card" id="card-disciplina-<%= m.getIdMateria() %>">

       <div class="course-header"
            onclick="alternarDetalhesCard('card-disciplina-<%= m.getIdMateria() %>')">

           <h4><%= m.getSigla() %></h4>
           <span style="font-size:12px;"><%= m.getNome() %></span>
       </div>

       <div class="course-summary" onclick="alternarDetalhesCard('card-disciplina-<%= m.getIdMateria() %>')">

           <div class="progress-bar-container">
               <div class="progress-bar"></div>
           </div>

           <i class="fas fa-chevron-down toggle-icon"></i>
       </div>

       <div class="course-details"
            id="detalhes-disciplina-<%= m.getIdMateria() %>">

           <div class="detalhes-acoes">

           <%
           for(Trabalho t : trabalhos){

               if(t.getIdAlunoMateria() == am.getIdAlunoMateria()){

                   tem = true;
           %>

               <div class="trabalho-item">

                   <div class="trabalho-info">
                       <p><%= t.getTitulo() %></p>
                       <span class="<%= t.getClasseCor() %>"></span>
                   </div>

                   <span class="trabalho-prazo">
                       <%= t.getDataEntregaPrevista() %>
                   </span>

               </div>

           <%
               }
           }

           if(!tem){
           %>

               <span style="font-size:13px;">
                   Nenhum trabalho cadastrado
               </span>

           <%
           }
           %>

           </div>
       </div>
   </div>

   <%
   }
   %>

   </div>

    <%-- Seção De listar os trabalhos--%>
    <%-- NAO MEXE NISSO QUE JA ESTA PRONTO SÓ NA SECAO ACIMA--%>
    <section class="atividades">

      <h2>Atividades
      <button class="addBtn" onclick="abrirModal()">
          <i class="fa-solid fa-plus" style="color: white;"></i>
      </button>
      </h2>
    
        <nav class="filtros">

            <button
                class="<%= filtro.equals("atribuida") ? "ativo" : "" %>"
                onclick="window.location.href='atividades.jsp?semestreId=<%= semestreAtivoId %>&filtro=atribuida'">
                Atribuído
            </button>

            <button
                class="<%= filtro.equals("pendente") ? "ativo" : "" %>"
                onclick="window.location.href='atividades.jsp?semestreId=<%= semestreAtivoId %>&filtro=pendente'">
                Pendente
            </button>

            <button
                class="<%= filtro.equals("entregue") ? "ativo" : "" %>"
                onclick="window.location.href='atividades.jsp?semestreId=<%= semestreAtivoId %>&filtro=entregue'">
                Entregue
            </button>

        </nav>

        <%-- Cada trabalho em si pelo filtro--%>
        <section class="lista-atividades">

            <%
            for(Trabalho t : trabalhos){

                if(
                    !t.getEstado()
                      .getNome()
                      .equalsIgnoreCase(
                              filtro
                      )
                ){
                    continue;
                }
            %>

            <section class="atividade <%= t.getClasseCor() %>">

                <div class="conteudo">

                    <i class="fa-solid fa-list-check"
                       style="color: rgb(255,255,255);">
                    </i>

                    <h3>
                        <%= t.getTitulo() %>
                    </h3>

                </div>

                <div class="acoes">

                    <span>
                        <%= t.getEstado()
                              .getNome()
                              .substring(0,1)
                              .toUpperCase()
                           +
                           t.getEstado()
                            .getNome()
                            .substring(1)
                        %>
                    </span>

                    <%
                    if(t.podeEntregar()){
                    %>

                    <button
                    aria-label="Entregar"
                    onclick="entregarAtividade(<%= t.getIdTrabalho() %>)">
                        <i class="fa-solid fa-circle-check"></i>
                    </button>

                    <%
                    }
                    %>

                    <%
                    if(t.podeExcluir()){
                    %>

                    <button
                    aria-label="Excluir"
                    onclick="excluirAtividade(<%= t.getIdTrabalho() %>)">
                        <i class="fa-regular fa-trash-can"></i>
                    </button>

                    <%
                    }
                    %>

                </div>

            </section>

            <%
            }
            %>
        </section>
    </section>
</main>

<%-- Abre o modal de inserir trabalho--%>
<div class="modal-overlay" id="modal-atividade-container">
    <section class="modal-content">
        <section id="modal-titulo" class="modal-header">
            Adicionar Atividade
        </section>
        <section class="modal-body">
            <form
                id="form-atividade"
                action="<%= request.getContextPath() %>/AtividadeServlet"
                method="POST"
            >
                <input type="hidden" name="semestreId" value="<%= semestreAtivoId %>">

                <section class="input-group">
                    <label for="atividade-materia">Matéria</label>

                    <select
                        id="atividade-materia"
                        name="idAlunoMateria"
                        required
                    >
                        <option value="">
                            Selecione uma matéria
                        </option>

                        <%
                        boolean temMateria = !materiasSemestre.isEmpty();
                        for(AlunoMateria am : materiasSemestre){
                        %>

                        <option value="<%= am.getIdAlunoMateria() %>">
                            <%= am.getMateria().getNome() %>
                        </option>

                        <%
                        }

                        if(!temMateria){
                        %>
                        <option disabled>
                            Nenhuma matéria no semestre
                        </option>
                        <%
                        }
                        %>

                    </select>
                </section>

                <section class="input-group">
                    <label for="atividade-nome">Nome</label>

                    <input
                        type="text"
                        id="atividade-nome"
                        name="titulo"
                        placeholder="Nome da atividade"
                        required
                    >
                </section>

                <section class="modal-actions">

                    <section class="input-group">
                        <label for="atividade-data">Prazo da atividade</label>

                        <section class="prazo-inputs">
                            <span>até</span>

                            <input
                                type="date"
                                id="atividade-data"
                                name="dataPrazo"
                                required
                            >

                        </section>
                    </section>
                </section>

                <section class="modal-actions">
                    <button type="button" class="btn-basico secundario" onclick="fecharModal()">CANCELAR</button>
                    <button type="submit" class="btn-basico">CONFIRMAR</button>
                </section>
            </form>
        </section>
    </section>
</div>


<script src="js/scriptAtividades.js"></script>
</body>
</html>