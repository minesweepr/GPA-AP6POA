package servlets;

import conectores.NotasConector;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/NotasServlet")
public class NotasServlet extends HttpServlet {

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

        if(ids != null) {
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
        }

        response.sendRedirect("notas.jsp?semestreId=" + idSemestre);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idAlunoMateriaParam = request.getParameter("idAlunoMateria");
        String semestreIdParam = request.getParameter("semestreId");

        if(idAlunoMateriaParam == null || semestreIdParam == null){
            response.sendRedirect("notas.jsp");
            return;
        }
        int idAlunoMateria = Integer.parseInt(idAlunoMateriaParam);
        int semestreId = Integer.parseInt(semestreIdParam);

        NotasConector notasDao = new NotasConector();
        notasDao.excluirNotas(semestreId, idAlunoMateria);

        response.sendRedirect("notas.jsp?semestreId=" + semestreId);
    }
}