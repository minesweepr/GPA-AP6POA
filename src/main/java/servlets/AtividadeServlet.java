package servlets;

import conectores.TrabalhoConector;
import model.Trabalho;
import state.PendenteState;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/AtividadeServlet")
public class AtividadeServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        try{

            Trabalho t =
                    new Trabalho();

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


            t.setEstado(
                    new PendenteState()
            );

            TrabalhoConector dao =
                    new TrabalhoConector();

            dao.inserir(t);

        }catch(Exception e){
            e.printStackTrace();
        }


        response.sendRedirect("atividades.jsp");
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );

        TrabalhoConector dao =
                new TrabalhoConector();

        dao.excluir(id);

        response.sendRedirect(
                "atividades.jsp"
        );
    }
}