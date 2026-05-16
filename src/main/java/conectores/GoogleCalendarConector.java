package conectores;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.googleapis.auth.oauth2.GoogleRefreshTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;

import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;

import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;

import java.io.InputStream;
import java.io.InputStreamReader;

import model.Trabalho;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GoogleCalendarConector {

    private Calendar getService(
            String accessToken,
            String refreshToken,
            HttpSession session
    ) throws Exception {

        try {

            AccessToken token =
                    new AccessToken(accessToken, new Date(System.currentTimeMillis() + 3600_000));

            GoogleCredentials credentials =
                    GoogleCredentials.create(token);
            credentials.refreshIfExpired();

            return new Calendar.Builder(
                GoogleNetHttpTransport.newTrustedTransport(),
                GsonFactory.getDefaultInstance(),
                new HttpCredentialsAdapter(credentials))
                .setApplicationName("GPA")
                .build();

        } catch (Exception e) {

            String novoToken = renovarAccessToken(refreshToken);

            if (novoToken == null) {
                throw e;
            }

            session.setAttribute("googleAccessToken", novoToken);
            AccessToken token =
                    new AccessToken(novoToken, new Date(System.currentTimeMillis() + 3600_000));

            GoogleCredentials credentials = GoogleCredentials.create(token);

            return new Calendar.Builder(
                GoogleNetHttpTransport.newTrustedTransport(),
                GsonFactory.getDefaultInstance(),
                new HttpCredentialsAdapter(credentials))
                .setApplicationName("GPA")
                .build();
        }
    }

    public String criarEvento(String accessToken, String refreshToken, HttpSession session, Trabalho trabalho) {

        try {

            Calendar service =  getService(accessToken, refreshToken, session);

            LocalDate dataPrevista = trabalho.getDataEntregaPrevista();
            LocalDateTime inicio = LocalDateTime.now();
            LocalDateTime fim = dataPrevista.atTime(23, 59);

            Date startDate = Date.from(inicio.atZone(ZoneId.systemDefault()).toInstant());

            Date endDate = Date.from(fim.atZone(ZoneId.systemDefault()).toInstant());

            Event event = new Event();
            event.setSummary(trabalho.getTitulo());

            EventDateTime start = new EventDateTime()
                    .setDateTime(new com.google.api.client.util.DateTime(startDate));

            EventDateTime end = new EventDateTime()
                    .setDateTime(new com.google.api.client.util.DateTime(endDate));

            event.setStart(start);
            event.setEnd(end);

            Event createdEvent = service.events()
                    .insert("primary", event)
                    .execute();

            System.out.println("Evento criado no Google Calendar com sucesso!");

            return createdEvent.getId();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void atualizarEvento(String accessToken, String refreshToken, HttpSession session, Trabalho trabalho) {

        try {

            if (trabalho.getIdGoogleCalendar() == null) {
                return;
            }

            Calendar service =  getService(accessToken, refreshToken, session);

            Event event = service.events().get("primary", trabalho.getIdGoogleCalendar()).execute();

            event.setSummary(trabalho.getTitulo());

            LocalDateTime inicio = trabalho.getDataEntregaPrevista().atTime(22, 0);

            LocalDateTime fim = trabalho.getDataEntregaPrevista().atTime(23, 0);

            event.setStart(
                    new EventDateTime().setDateTime(new com.google.api.client.util.DateTime(
                                    Date.from(inicio.atZone(ZoneId.systemDefault()).toInstant()))));

            event.setEnd(
                    new EventDateTime().setDateTime(
                            new com.google.api.client.util.DateTime(
                                    Date.from(fim.atZone(ZoneId.systemDefault()).toInstant()))));

            service.events().update("primary", trabalho.getIdGoogleCalendar(), event).execute();

            System.out.println("Evento atualizado!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirEvento(String accessToken, String refreshToken, HttpSession session, Trabalho trabalho) {

        try {

            if (trabalho.getIdGoogleCalendar() == null) {
                return;
            }

            Calendar service =  getService(accessToken, refreshToken, session);

            service.events().delete("primary", trabalho.getIdGoogleCalendar()).execute();

            System.out.println("Evento excluído!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Event> listarEventos(String accessToken, String refreshToken, HttpSession session) {

        try {

            Calendar service =  getService(accessToken, refreshToken, session);

            com.google.api.services.calendar.model.Events
                    response = service.events()
                            .list("primary")
                            .setTimeMin(new com.google.api.client.util.DateTime(System.currentTimeMillis()))
                            .setMaxResults(250)
                            .setSingleEvents(true)
                            .setOrderBy("startTime")
                            .execute();

            return response.getItems();

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public String renovarAccessToken(
            String refreshToken
    ) {

        try {

            InputStream in =
                    getClass().getClassLoader()
                            .getResourceAsStream(
                                    "credentials.json"
                            );

            GoogleClientSecrets clientSecrets =
                    GoogleClientSecrets.load(
                            GsonFactory.getDefaultInstance(),
                            new InputStreamReader(in)
                    );

            GoogleTokenResponse tokenResponse =
                    new GoogleRefreshTokenRequest(
                            GoogleNetHttpTransport
                                    .newTrustedTransport(),
                            GsonFactory
                                    .getDefaultInstance(),
                            refreshToken,
                            clientSecrets
                                    .getDetails()
                                    .getClientId(),
                            clientSecrets
                                    .getDetails()
                                    .getClientSecret()
                    ).execute();

            return tokenResponse.getAccessToken();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}