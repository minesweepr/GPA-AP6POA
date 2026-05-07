package servlets;

import conectores.NotasConector;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/SalvarNotasServlet")
public class SalvarNotasServlet extends HttpServlet {

    private Double parseNota(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Double.valueOf(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int idSemestre =
                Integer.parseInt(request.getParameter("semestreId"));

        String[] ids = request.getParameterValues("idAlunoMateria");

        NotasConector notasDao = new NotasConector();

        for (String idStr : ids) {

            int idAlunoMateria = Integer.parseInt(idStr);

            Double av1 = parseNota(request.getParameter("av1_" + idAlunoMateria));
            Double av2 = parseNota(request.getParameter("av2_" + idAlunoMateria));
            Double avf = parseNota(request.getParameter("avf_" + idAlunoMateria));

            notasDao.atualizarNotas(
                    idAlunoMateria,
                    av1,
                    av2,
                    avf
            );
        }

        response.sendRedirect("notas.jsp?semestreId=" + idSemestre);
    }
}