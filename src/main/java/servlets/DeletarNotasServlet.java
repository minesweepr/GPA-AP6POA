package servlets;

import conectores.NotasConector;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeletarNotasServlet")
public class DeletarNotasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        int idAlunoMateria = Integer.parseInt(request.getParameter("idAlunoMateria"));
        int semestreId = Integer.parseInt(request.getParameter("semestreId"));

        NotasConector notasDao = new NotasConector();

        notasDao.excluirNotas(semestreId, idAlunoMateria);

        response.sendRedirect("notas.jsp?semestreId=" + semestreId);
    }
}