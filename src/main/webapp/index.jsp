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
    AlunoConector alunoDao=new AlunoConector();

    // listagem e selecao de semestre
    List<Semestre> listaSemestres=semestreDao.listarPorAluno(idLogado);
    if(listaSemestres==null) listaSemestres=new ArrayList<>();

    String paramSemestre=request.getParameter("semestreId");
    int semestreAtivoId=0;

    if(paramSemestre!=null) semestreAtivoId=Integer.parseInt(paramSemestre);
    else if(!listaSemestres.isEmpty()) semestreAtivoId=listaSemestres.get(0).getIdSemestre();

    //info geral para os cards de desempenho
    double crAluno=alunoDao.crDinamico(idLogado);

    double desempenhoAlunoSemestre=0.0;
    for(Semestre s : listaSemestres){
        if(s.getIdSemestre()==semestreAtivoId){
            desempenhoAlunoSemestre=s.getDesempenho();
            break;
        }
    }

    String StatusAtualTexto, StatusAtualClasse;
    if(desempenhoAlunoSemestre>=7){
        StatusAtualTexto="Bom";
        StatusAtualClasse="success";
    }else if(desempenhoAlunoSemestre>=5){
        StatusAtualTexto="Médio";
        StatusAtualClasse="warning";
    }else if(desempenhoAlunoSemestre==0.0){
        StatusAtualTexto="N/A";
        StatusAtualClasse=" ";
    }else{
        StatusAtualTexto="Ruim";
        StatusAtualClasse="danger";
    }

    //tabela
    List<Integer> idsMateriasSemestre=materiaDao.listarMateriaPorSemestre(idLogado, semestreAtivoId);
    if(idsMateriasSemestre==null) idsMateriasSemestre=new ArrayList<>();

    List<Materia> todasMateriasIndex=materiaDao.listarTodas(idLogado);
    if(todasMateriasIndex==null) todasMateriasIndex=new ArrayList<>();
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
    <link rel="stylesheet" href="css/estiloModal.css">
    <link rel="stylesheet" href="css/estiloIndex.css">
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
    <%@ include file="WEB-INF/includes/listarSemestres.jsp" %>

    <section>
        <h2>Cálculos</h2>
        <div class="stats-grid">
            <div class="white-card">
                <h3>Coeficiente de Rendimento</h3>
                <div class="value" id="coeficiente-de-rendimento"><%= crAluno %></div>
            </div>
            <div class="white-card">
                <h3>Desempenho Semestral</h3>
                <div class="value" id="desempenho-atual-aluno"><%= desempenhoAlunoSemestre %></div>
            </div>
            <div class="white-card">
                <h3>Desempenho Atual</h3>
                <div class="value <%= StatusAtualClasse %> " id="status-desempenho-atual-aluno"><%= StatusAtualTexto %></div>
            </div>
        </div>
    </section>

    <section>
        <h2>Médias por Disciplina</h2>
        <div class="tabela-container">
            <table class="tabela-notas">
                <thead>
                    <tr>
                        <th colspan="4">Médias</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <%
                            int col=0;
                            for(Integer idMat : idsMateriasSemestre){
                                Materia matInfo=null;
                                for(Materia m:todasMateriasIndex){
                                    if(m.getIdMateria()==idMat){matInfo=m;break;}
                                }

                                if(matInfo!=null){
                                    double notaMF=materiaDao.buscarMediaMateria(idMat, semestreAtivoId);
                                    if(col>0 && col%4==0){out.print("</tr><tr>");}
                                    String mfExibicao=(notaMF>0)?String.format("%.1f", notaMF):"N/A";
                        %>
                        <td><span class="tabela-sigla"><%= matInfo.getSigla() %></span>
                        <span class="pontos"> .......... </span>
                        <span class="tabela-nota"><%= mfExibicao %></span></td>
                        <%
                                    col++;
                                }
                            }

                            while(col>0 && col%4!=0){out.print("<td></td>");col++;}
                            if(idsMateriasSemestre.isEmpty()){out.print("<td colspan='4' style='text-align:center;'>Nenhuma matéria vinculada.</td>");}
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</main>

<%@ include file="WEB-INF/includes/modalSemestre.jsp" %>
<script src="js/scriptSemestre.js"></script>
</body>
</html>