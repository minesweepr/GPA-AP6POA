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

    // todas as materias
    List<Materia> todasMaterias=materiaDao.listarTodas();
    if(todasMaterias==null) todasMaterias=new ArrayList<>();

    // materia por semestre
    List<Integer> idsSelecionados=materiaDao.listarMateriaPorSemestre(idLogado, semestreAtivoId);
    if(idsSelecionados==null) idsSelecionados=new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPA - Gestão de Produtividade Acadêmica</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estiloGeral.css">
    <link rel="stylesheet" href="css/estiloTabela.css">
    <link rel="stylesheet" href="css/estiloNotas.css">
    <link rel="stylesheet" href="css/estiloModal.css">
</head>
<body>

<aside>
    <i id="logo" class="fa-solid fa-graduation-cap"></i>
    <nav>
        <ul>
            <li class="link_animation" onclick="window.location.href='index.jsp'"><i class="fa-solid fa-house"></i> Desempenho</li>
            <li class="active" onclick="window.location.href='notas.jsp'"><i class="fa-regular fa-copy"></i> Notas</li>
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
        <div class="titulo">
            <h2>Matérias disponíveis</h2>
            <button id="adicionar" class="btn-basico" onclick="abrirModal('adicionar')"><i class="fa-solid fa-plus"></i></button>
        </div>

        <div class="barra-busca-filtro">
            <div class="input-busca-container">
                <input type="text" id="input-busca-materia" placeholder="Pesquisar matéria...">
                <i class="fas fa-search" style="color: #aaa; cursor: pointer;"></i>
            </div>
            <button class="btn-filtro" onclick="toggleMenuFiltro()">
                Filtrar por ... <i class="fas fa-filter"></i>
            </button>

            <div class="dropdown-filtro" id="menu-opcoes-filtro">
                <label><input type="checkbox" class="check-periodo" value="1">Crédito (crescente)</label>
                <label><input type="checkbox" class="check-periodo" value="2">Crédito (decrescente)</label>
                <label><input type="checkbox" class="check-periodo" value="3">Alfabética (A-Z)</label>
                <label><input type="checkbox" class="check-periodo" value="4">Alfabética (Z-A)</label>
            </div>
        </div>

        <div class="lista-materias" id="container-materias-disponiveis">
        <%
            for(Materia m : todasMaterias){
                // verifica se ja ta na lista
                boolean jaSelecionada=idsSelecionados.contains(m.getIdMateria());

                String styleAdicional=jaSelecionada?"style='background-color: #808080;'" : "";
                String textoBotao=jaSelecionada?"Editar" : "Selecionar";
                String eventoClick=jaSelecionada?String.format("abrirModal('editar', '%d', '%s', '%s', '%d')",
                                                 m.getIdMateria(), m.getNome(), m.getSigla(), m.getCreditos())
                                                 :String.format("window.location.href='VincularMateriaServlet?idMateria=%d&idSemestre=%d'",
                                                 m.getIdMateria(), semestreAtivoId);
        %>
            <div class="linha-materia">
                <span class="col-icone"><i class="fa-solid fa-book"></i></span>
                <span class="col-nome"><strong><%= m.getNome() %></strong></span>
                <div>
                    <span class="col-sigla"><%= m.getSigla() %></span>
                    <span class="col-creditos"><%= m.getCreditos() %> Créditos</span>
                </div>
                <button class="btn-basico selecionar"<%= styleAdicional %> onclick="<%= eventoClick %>"> <%= textoBotao %> </button>
            </div>
        <% } %>
        </div>
    </section>

    <section>
        <form id="form-notas" action="SalvarNotasServlet" method="POST">
            <h2>Notas</h2>
            <div class="tabela-container">
                <table class="tabela-notas">
                    <thead>
                        <tr>
                            <th>Disciplinas</th>
                            <th>AV1</th>
                            <th>AV2</th>
                            <th>AVF</th>
                            <th>MF</th>
                            <th class="info-last">Excluir</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Nome todo da disciplina</td>
                            <td>input</td>
                            <td>input</td>
                            <td>input</td>
                            <td>automatico</td>
                            <td class="info-last"><button id="deletar" class="btn-basico vermelho"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                        <tr>
                            <td>Nome todo da disciplina</td>
                            <td>10,0</td>
                            <td>10,0</td>
                            <td>-</td>
                            <td>10,0</td>
                            <td class="info-last"><button id="deletar" class="btn-basico vermelho"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                        <tr>
                            <td>Nome todo da disciplina</td>
                            <td>3,2</td>
                            <td>6,3</td>
                            <td>7,2</td>
                            <td>6,0</td>
                            <td class="info-last"><button id="deletar" class="btn-basico vermelho"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="botoes-acoes">
                <button id="descartar" class="btn-basico secundario">Descartar mudanças</button>
                <button id="salvar" class="btn-basico">Salvar Notas</button>
            </div>
        </form>
    </section>
</main>


<div class="modal-overlay" id="modal-materia-container">
    <div class="modal-content">
        <div id="modal-titulo" class="modal-header">Adicionar Matéria</div>
        <div class="modal-body">
            <form id="form-materia" action="<%= request.getContextPath() %>/MateriaServlet" method="POST">
                <input type="hidden" id="materia-id" name="idMateria">
                <input type="hidden" name="semestreId" value="<%= semestreAtivoId %>">

                <div class="input-group">
                    <label>Matéria</label>
                    <input type="text" id="materia-nome" name="nome" placeholder="Nome Completo da Matéria" required>
                </div>
                <div class="modal-actions">
                    <div class="input-group">
                        <label>Sigla</label>
                        <input type="text" id="materia-sigla" name="sigla" placeholder="Abreviação" required>
                    </div>
                    <div class="input-group">
                        <label>Créditos</label>
                        <input type="number" id="materia-creditos" name="creditos" placeholder="Peso da Matéria" required>
                    </div>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-basico secundario" onclick="fecharModal()">CANCELAR</button>
                    <button type="submit" class="btn-basico">CONFIRMAR</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="js/scriptNotas.js"></script>
</body>
</html>