package servlets;

import conectores.TrabalhoConector;
import model.Trabalho;
import state.AtribuidoState;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/AtividadeServlet")
public class AtividadeServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {
        String filtro = "atribuida";
        int semestreId = 0;

        try {

            semestreId = Integer.parseInt(request.getParameter("semestreId"));
            filtro = request.getParameter("filtro");


            Trabalho t = new Trabalho();

            t.setIdAlunoMateria(
                    Integer.parseInt(
                            request.getParameter(
                                    "idAlunoMateria"
                            )
                    )
            );

            t.setTitulo(
                    request.getParameter(
                            "titulo"
                    )
            );

            t.setDataEntregaPrevista(
                    LocalDate.parse(
                            request.getParameter(
                                    "dataPrazo"
                            )
                    )
            );

            t.setEstado(new AtribuidoState());

            TrabalhoConector dao =
                    new TrabalhoConector();

            dao.inserir(t);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("atividades.jsp?semestreId=" + semestreId + "&filtro=" + filtro);
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {
        String filtro = "atribuida";
        int semestreId = 0;

        try {

            semestreId = Integer.parseInt(request.getParameter("semestreId"));
            filtro = request.getParameter("filtro");
            int id = Integer.parseInt(request.getParameter("id"));

            TrabalhoConector dao =
                    new TrabalhoConector();

            dao.excluir(id);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("atividades.jsp?semestreId=" + semestreId + "&filtro=" + filtro);
    }
}