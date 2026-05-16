package servlets;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeRequestUrl;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;

import com.google.api.client.json.gson.GsonFactory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;


import java.util.Arrays;

@WebServlet("/GoogleOAuthServlet")
public class GoogleOAuthServlet extends HttpServlet {
    private String getRedirectUri(HttpServletRequest request) {
        return request.getScheme()
                + "://"
                + request.getServerName()
                + ":"
                + request.getServerPort()
                + request.getContextPath()
                + "/GoogleOAuthCallback";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        InputStream in = getServletContext()
                .getResourceAsStream("/WEB-INF/classes/credentials.json");

        if (in == null) {
            throw new RuntimeException("credentials.json não encontrado");
        }

        GoogleClientSecrets clientSecrets =
                GoogleClientSecrets.load(
                        GsonFactory.getDefaultInstance(),
                        new InputStreamReader(in));

        String url = new GoogleAuthorizationCodeRequestUrl(
                clientSecrets.getDetails().getClientId(),
                getRedirectUri(request),
                Arrays.asList("https://www.googleapis.com/auth/calendar.events"))
                .setAccessType("offline")
                .set("prompt", "consent")
                .build();

        response.sendRedirect(url);
    }
}