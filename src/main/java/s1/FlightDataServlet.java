package s1;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FlightDataServlet")
public class FlightDataServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        
        // Get API data
        String apiEndpoint = "https://partner.imwallet.in/web_services/statudentFilter.jsp";
        URL url = new URL(apiEndpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        Scanner scanner = new Scanner(url.openStream());
        StringBuilder apiResponse = new StringBuilder();
        while (scanner.hasNext()) {
            apiResponse.append(scanner.nextLine());
        }
        scanner.close();
        conn.disconnect();

        // Parse API response and return as JSON
        PrintWriter out = response.getWriter();
        out.println(apiResponse.toString());
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
