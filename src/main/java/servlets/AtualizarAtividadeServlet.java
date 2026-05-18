package servlets;

import facade.AtividadeFacade;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AtualizarAtividadeServlet")
public class AtualizarAtividadeServlet
        extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        int semestreId = Integer.parseInt(request.getParameter("semestreId"));

        String filtro = request.getParameter("filtro");

        int id = Integer.parseInt(request.getParameter("id"));

        AtividadeFacade facade = new AtividadeFacade();

        facade.entregarAtividade(id);

        response.sendRedirect(
                "atividades.jsp?semestreId="
                        + semestreId
                        + "&filtro="
                        + filtro
        );
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        int semestreId = Integer.parseInt(request.getParameter("semestreId"));
        String filtro = request.getParameter("filtro");

        AtividadeFacade facade = new AtividadeFacade();

        facade.atualizarAtividade(request);

        response.sendRedirect(
                "atividades.jsp?semestreId="
                        + semestreId
                        + "&filtro="
                        + filtro
        );
    }
}