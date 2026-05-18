package servlets;

import conectores.GoogleCalendarConector;
import conectores.TrabalhoConector;
import model.Trabalho;
import state.AtribuidoState;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/AtualizarAtividadeServlet")
public class AtualizarAtividadeServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

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

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String filtro = "atribuida";
        int semestreId = 0;

        try {
            semestreId = Integer.parseInt(request.getParameter("semestreId"));

            String filtroParam = request.getParameter("filtro");

            if (filtroParam != null) {
                filtro = filtroParam;
            }

            Trabalho t = new Trabalho();

            t.setIdTrabalho(Integer.parseInt(request.getParameter("id")));
            t.setIdAlunoMateria(Integer.parseInt(request.getParameter("idAlunoMateria")));
            t.setTitulo(request.getParameter("titulo"));
            t.setDataEntregaPrevista(LocalDate.parse(request.getParameter("dataPrazo")));
            t.setEstado(new AtribuidoState());

            TrabalhoConector dao = new TrabalhoConector();

            Trabalho trabalhoBanco = dao.buscarPorId(t.getIdTrabalho());
            t.setIdGoogleCalendar(trabalhoBanco.getIdGoogleCalendar());

            GoogleCalendarConector google = new GoogleCalendarConector();

            String accessToken = (String) request.getSession().getAttribute("googleAccessToken");
            String refreshToken = (String) request.getSession().getAttribute("googleRefreshToken");

            boolean googleAutenticado =
                    accessToken != null
                            && !accessToken.isBlank()
                            && refreshToken != null
                            && !refreshToken.isBlank();

            dao.atualizar(t);

            if (googleAutenticado) {

                try {
                    // nunca foi sincronizado
                    if (t.getIdGoogleCalendar() == null
                            || t.getIdGoogleCalendar().isBlank()) {

                        String eventId = google.criarEvento(
                                accessToken,
                                refreshToken,
                                request.getSession(),
                                t
                        );
                        t.setIdGoogleCalendar(eventId);
                        dao.atualizarIdGoogleCalendar(t.getIdTrabalho(), eventId);

                    } else {
                        google.atualizarEvento(
                                accessToken,
                                refreshToken,
                                request.getSession(),
                                t
                        );
                    }

                } catch (Exception e) {
                    System.out.println("Falha ao sincronizar Google Calendar");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(
                "atividades.jsp?semestreId="
                        + semestreId
                        + "&filtro="
                        + filtro
        );
    }
}