package servlets;

import facade.AtividadeFacade;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AtividadeServlet")
public class AtividadeServlet
        extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String filtro = "atribuida";
        int semestreId = Integer.parseInt(request.getParameter("semestreId"));

        String filtroParam = request.getParameter("filtro");

        if (filtroParam != null) {
            filtro = filtroParam;
        }

        AtividadeFacade facade = new AtividadeFacade();

        facade.criarAtividade(request);

        response.sendRedirect(
                "atividades.jsp?semestreId="
                        + semestreId
                        + "&filtro="
                        + filtro
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String filtro = request.getParameter("filtro");

        int semestreId = Integer.parseInt(request.getParameter("semestreId"));

        AtividadeFacade facade = new AtividadeFacade();

        facade.excluirAtividade(request);

        response.sendRedirect(
                "atividades.jsp?semestreId="
                        + semestreId
                        + "&filtro="
                        + filtro
        );
    }
}