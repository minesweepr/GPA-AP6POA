package servlets;

import conectores.TrabalhoConector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/MudarStateEntregueServlet")
public class MudarStateEntregueServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        int semestreId = 0;

        String filtro = "atribuida";

        try {

            semestreId = Integer.parseInt(request.getParameter("semestreId"));
            filtro = request.getParameter("filtro");
            int id = Integer.parseInt(request.getParameter("id"));

            TrabalhoConector dao = new TrabalhoConector();

            dao.entregar(id);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("atividades.jsp?semestreId=" + semestreId + "&filtro=" + filtro);
    }
}