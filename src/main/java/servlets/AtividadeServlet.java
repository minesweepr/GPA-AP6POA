package servlets;

//import conectores.GoogleCalendarConector;
import conectores.GoogleCalendarConector;
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
            String filtroParam = request.getParameter("filtro");
            if (filtroParam != null) filtro = filtroParam;

            Trabalho t = new Trabalho();

            t.setIdAlunoMateria(Integer.parseInt(request.getParameter("idAlunoMateria")));
            t.setTitulo(request.getParameter("titulo"));
            t.setDataEntregaPrevista(LocalDate.parse(request.getParameter("dataPrazo")));
            t.setEstado(new AtribuidoState());

            GoogleCalendarConector google = new GoogleCalendarConector();
            TrabalhoConector dao = new TrabalhoConector();

            String eventId = null;

            String accessToken = (String) request.getSession().getAttribute("googleAccessToken");
            String refreshToken = (String) request.getSession().getAttribute("googleRefreshToken");

            System.out.println("ACCESS TOKEN: " + accessToken);
            System.out.println("REFRESH TOKEN: " + refreshToken);

            if (accessToken != null && !accessToken.isEmpty() && refreshToken != null && !refreshToken.isEmpty()) {

                System.out.println("Entrou no IF do Google");
                try {
                    eventId = google.criarEvento(accessToken, refreshToken, request.getSession(), t);
                    System.out.println("EVENT ID: " + eventId);
                } catch (Exception e) {
                    System.out.println("Falha ao criar evento no Google Calendar");
                    e.printStackTrace();
                }
            } else {
                System.out.println("TOKEN NULO OU VAZIO");
            }

            t.setIdGoogleCalendar(eventId);

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

            GoogleCalendarConector google = new GoogleCalendarConector();
            TrabalhoConector dao = new TrabalhoConector();

            String accessToken = (String) request.getSession().getAttribute("googleAccessToken");
            String refreshToken = (String) request.getSession().getAttribute("googleRefreshToken");

            Trabalho trabalho = dao.buscarPorId(id);
            google.excluirEvento(
                    accessToken,
                    refreshToken,
                    request.getSession(),
                    trabalho
            );

            dao.excluir(id);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("atividades.jsp?semestreId=" + semestreId + "&filtro=" + filtro);
    }
}