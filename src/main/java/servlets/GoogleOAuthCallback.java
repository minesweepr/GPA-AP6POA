package servlets;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;

import com.google.api.client.http.javanet.NetHttpTransport;

import com.google.api.client.json.gson.GsonFactory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

@WebServlet("/GoogleOAuthCallback")
public class GoogleOAuthCallback extends HttpServlet {

    private String getRedirectUri(HttpServletRequest request) {
        return request.getScheme()
                + "://"
                + request.getServerName()
                + ":"
                + request.getServerPort()
                + request.getContextPath()
                + "/GoogleOAuthCallback";
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String code = request.getParameter("code");

        if (code == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            InputStream in = getServletContext()
                    .getResourceAsStream("/WEB-INF/classes/credentials.json");
            if (in == null) {
                throw new RuntimeException("credentials.json não encontrado");
            }

            GoogleClientSecrets clientSecrets =
                    GoogleClientSecrets.load(
                            GsonFactory.getDefaultInstance(),
                            new InputStreamReader(in));

            final NetHttpTransport transport = GoogleNetHttpTransport.newTrustedTransport();

            GoogleTokenResponse tokenResponse =
                    new GoogleAuthorizationCodeTokenRequest(
                            transport,
                            GsonFactory.getDefaultInstance(),
                            clientSecrets.getDetails().getClientId(),
                            clientSecrets.getDetails().getClientSecret(),
                            code,
                            getRedirectUri(request))
                            .execute();

            HttpSession session = request.getSession();
            session.setAttribute("googleAccessToken", tokenResponse.getAccessToken());

            String newRefreshToken = tokenResponse.getRefreshToken();
            if (newRefreshToken != null) {
                session.setAttribute("googleRefreshToken", newRefreshToken);
            }

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}