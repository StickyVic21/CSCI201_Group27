package uscninja;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

@WebServlet("/group27/Login") // probably will have to change 
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		boolean isAuthenticated = authenticate(username, password);

		JsonObject jsonResponse = new JsonObject();
		jsonResponse.addProperty("authenticated", isAuthenticated);

		// Set the content type to JSON
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Write the JSON response
		response.getWriter().write(jsonResponse.toString());
	}

	private boolean authenticate(String username, String password) {
		String url = "jdbc:mysql://localhost:3306/UserTable";
		String dbUsername = "root";
		String dbPassword = "BingBongDingDong123!"; // replace w/ your own

		Connection conn = null;
		PreparedStatement st = null;
		ResultSet resultSet = null;

		try {
			conn = DriverManager.getConnection(url, dbUsername, dbPassword);
			String sql = "SELECT userID FROM Users WHERE username = ? AND password = ?";
			st = conn.prepareStatement(sql);
			st.setString(1, username);
			st.setString(2, password);

			resultSet = st.executeQuery();
			return resultSet.next();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (st != null)
					st.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
