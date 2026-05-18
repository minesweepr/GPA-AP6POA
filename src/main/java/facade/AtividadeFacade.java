package facade;

import conectores.GoogleCalendarConector;
import conectores.TrabalhoConector;
import model.Trabalho;
import state.AtribuidoState;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;

public class AtividadeFacade {
    public void criarAtividade(HttpServletRequest request) {
        try {
            Trabalho t = new Trabalho();

            t.setIdAlunoMateria(Integer.parseInt(request.getParameter("idAlunoMateria")));
            t.setTitulo(request.getParameter("titulo"));
            t.setDataEntregaPrevista(LocalDate.parse(request.getParameter("dataPrazo")));
            t.setEstado(new AtribuidoState());

            TrabalhoConector dao = new TrabalhoConector();
            GoogleCalendarConector google = new GoogleCalendarConector();

            HttpSession session = request.getSession();
            String accessToken = (String) session.getAttribute("googleAccessToken");
            String refreshToken = (String) session.getAttribute("googleRefreshToken");

            boolean googleAutenticado =
                    accessToken != null
                            && !accessToken.isBlank()
                            && refreshToken != null
                            && !refreshToken.isBlank();

            String eventId = null;

            if (googleAutenticado) {
                try {
                    eventId = google.criarEvento(
                            accessToken,
                            refreshToken,
                            session,
                            t);

                } catch (Exception e) {
                    System.out.println("Falha ao criar evento no Google Calendar");
                    e.printStackTrace();
                }
            }

            t.setIdGoogleCalendar(eventId);
            dao.inserir(t);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirAtividade(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            TrabalhoConector dao = new TrabalhoConector();
            Trabalho trabalho = dao.buscarPorId(id);

            HttpSession session = request.getSession();
            String accessToken = (String) session.getAttribute("googleAccessToken");
            String refreshToken = (String) session.getAttribute("googleRefreshToken");

            boolean googleAutenticado =
                    accessToken != null
                            && !accessToken.isBlank()
                            && refreshToken != null
                            && !refreshToken.isBlank();

            if (googleAutenticado
                    && trabalho.getIdGoogleCalendar() != null
                    && !trabalho.getIdGoogleCalendar().isBlank()) {

                try {
                    GoogleCalendarConector google = new GoogleCalendarConector();
                    google.excluirEvento(
                            accessToken,
                            refreshToken,
                            session,
                            trabalho
                    );
                } catch (Exception e) {
                    System.out.println("Falha ao excluir evento Google");
                    e.printStackTrace();
                }
            }
            dao.excluir(id);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void atualizarAtividade(HttpServletRequest request) {

        try {
            Trabalho t = new Trabalho();
            t.setIdTrabalho(Integer.parseInt(request.getParameter("id")));
            t.setIdAlunoMateria(Integer.parseInt(request.getParameter("idAlunoMateria")));
            t.setTitulo(request.getParameter("titulo"));
            t.setDataEntregaPrevista(LocalDate.parse(request.getParameter("dataPrazo")));
            t.setEstado(new AtribuidoState());

            TrabalhoConector dao = new TrabalhoConector();

            Trabalho trabalhoBanco = dao.buscarPorId(t.getIdTrabalho());

            t.setIdGoogleCalendar(trabalhoBanco.getIdGoogleCalendar());

            HttpSession session = request.getSession();
            String accessToken = (String) session.getAttribute("googleAccessToken");
            String refreshToken = (String) session.getAttribute("googleRefreshToken");

            boolean googleAutenticado =
                    accessToken != null
                            && !accessToken.isBlank()
                            && refreshToken != null
                            && !refreshToken.isBlank();

            dao.atualizar(t);

            if (googleAutenticado) {
                GoogleCalendarConector google = new GoogleCalendarConector();
                try {
                    if (t.getIdGoogleCalendar() == null || t.getIdGoogleCalendar().isBlank()) {

                        String eventId = google.criarEvento(
                                        accessToken,
                                        refreshToken,
                                        session,
                                        t);


                        System.out.println("EVENT ID: " + eventId);
                        System.out.println("ID TRABALHO: " + t.getIdTrabalho());

                        t.setIdGoogleCalendar(eventId);
                        dao.atualizarIdGoogleCalendar(t.getIdTrabalho(), eventId);
                    } else {
                        google.atualizarEvento(
                                accessToken,
                                refreshToken,
                                session,
                                t);
                    }

                } catch (Exception e) {
                    System.out.println("Falha ao sincronizar Google Calendar");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void entregarAtividade(int id) {
        TrabalhoConector dao = new TrabalhoConector();
        dao.entregar(id);
    }
}