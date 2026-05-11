<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String paginaAtual=request.getServletPath().substring(1); %>

<section id="semestre-tabs">
    <ul>
        <li id="adc-semestre" class="tab" onclick="abrirModalSemestre('adicionar')" style="cursor: pointer;">
            <div>
                <span class="num"><i class="fa-solid fa-plus"></i></span>
            </div>
        </li>
        <%
            int cont=1;
            for(Semestre s : listaSemestres){
                String classeAtiva=(s.getIdSemestre()==semestreAtivoId)?"active" : "";
        %>
            <li class="tab <%= classeAtiva %>"
               onclick="window.location.href='<%= paginaAtual %>?semestreId=<%= s.getIdSemestre() %>'"
                style="cursor: pointer;">
                <div>
                    <span class="num"><%= cont %></span>
                    <%= s.getTitulo() %>
                </div>
                <i class="fa-solid fa-ellipsis-vertical"
                   onclick="event.stopPropagation(); mostrarMenuSemestre(event, 'menu-<%= s.getIdSemestre() %>')">
                </i>

                <div class="dropdown-semestre" id="menu-<%= s.getIdSemestre() %>">
                    <button type="button"
                        onclick="event.stopPropagation(); abrirModalSemestre('editar', '<%= s.getIdSemestre() %>', '<%= s.getTitulo() %>')">
                        <i class="fa-regular fa-pen-to-square"></i> Editar
                    </button>
                    <button type="button"
                        onclick="event.stopPropagation(); abrirModalExclusao('<%= s.getIdSemestre() %>', '<%= s.getTitulo() %>')">
                        <i class="fa-regular fa-trash-can"></i> Deletar
                    </button>
                </div>
            </li>
        <%
                cont++;
            }
        %>
    </ul>
</section>