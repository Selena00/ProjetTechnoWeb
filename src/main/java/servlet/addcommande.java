/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAO;
import model.DataSourceFactory;

/**
 *
 * @author cbonnevi
 */
@WebServlet(name = "addcommande", urlPatterns = {"/addcommande"})
public class addcommande extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException, ParseException {

		DAO dao = new DAO(DataSourceFactory.getDataSource());
                String ordernum = request.getParameter("ordernum");
                String idcustomer = request.getParameter("idcustomer");
                String idproduct = request.getParameter("idproduct");
                String quantity = request.getParameter("quantity");
                String shippingcost = request.getParameter("shippingcost");
                String sdate = request.getParameter("salesdate");
                DateFormat format = new SimpleDateFormat("yyyy-MM-d", Locale.ENGLISH);
                Date salesdate = format.parse(sdate);
                String shipdate = request.getParameter("shippingdate");
                Date shippingdate = format.parse(shipdate);
                String company = request.getParameter("company");
		String message;
		try {
			dao.ajoutCommande(Integer.parseInt(ordernum), Integer.parseInt(idcustomer), Integer.parseInt(idproduct), Integer.parseInt(quantity), Integer.parseInt(shippingcost), salesdate, shippingdate, company);
			message = String.format("Commande %s ajoutée", ordernum);
		} catch (NumberFormatException | SQLException ex) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			message = ex.getMessage();
		}
		
		Properties resultat = new Properties();
		resultat.put("message", message);

		try (PrintWriter out = response.getWriter()) {
			// On spécifie que la servlet va générer du JSON
			response.setContentType("application/json;charset=UTF-8");
			// Générer du JSON
			Gson gson = new Gson();
			out.println(gson.toJson(resultat));
		}
	}
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
