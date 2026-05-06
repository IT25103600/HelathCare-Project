package healthcare.records;

import healthcare.records.MedicalRecord;
import healthcare.admin.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

// this servlet manages all the pages starting with /record/
@WebServlet("/record/*")
public class MedicalRecordControllerServlet extends HttpServlet {

    // i'm using fileHandler to save and load records from our text file
    private FileHandler fileHandler;

    // this runs once when the servlet starts
    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
    }

    // handles standard page loads
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // check what action the user wants to do from the url
        String action = request.getPathInfo();
        if (action == null) action = "/list"; // default is just showing the list

        try {
            switch (action) {

                case "/new":
                    // just show the new record form
                    request.getRequestDispatcher("/record-register.jsp").forward(request, response);
                    break;

                case "/edit":
                    // find the record by its id so we can pre-fill the edit form
                    String id = request.getParameter("id");

                    request.setAttribute("record",
                            fileHandler.getAllMedicalRecords().stream()
                                    .filter(r -> r.getRecordId().equals(id))
                                    .findFirst()
                                    .orElse(null)
                    );

                    request.getRequestDispatcher("/record-update.jsp").forward(request, response);
                    break;

                case "/delete":
                    // delete the record and refresh the page
                    fileHandler.deleteMedicalRecord(request.getParameter("id"));
                    response.sendRedirect(request.getContextPath() + "/record/list");
                    break;

                case "/search":
                    // filter the records by searching for a specific word
                    String keyword = request.getParameter("keyword");

                    List<MedicalRecord> listRecord = fileHandler.getAllMedicalRecords();

                    if (keyword != null && !keyword.trim().isEmpty()) {
                        listRecord = listRecord.stream()
                                .filter(r ->
                                        r.getPatientId().toLowerCase().contains(keyword.toLowerCase()) ||
                                                r.getDoctorId().toLowerCase().contains(keyword.toLowerCase())
                                )
                                .collect(Collectors.toList());
                    }

                    request.setAttribute("listRecord", listRecord);
                    request.setAttribute("keyword", keyword);
                    request.getRequestDispatcher("/record-dashboard.jsp").forward(request, response);
                    break;

                case "/list":
                default:
                    // load all records and show them on the dashboard
                    request.setAttribute("listRecord", fileHandler.getAllMedicalRecords());
                    request.getRequestDispatcher("/record-dashboard.jsp").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    // handles form submissions when the user clicks save or update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {

                case "/insert":
                    // automatically create a new ID like R001, R002 based on the count
                    String id = "R" + String.format("%03d", fileHandler.getAllMedicalRecords().size() + 1);

                    // check if they selected DiagnosisReport or Prescription from the dropdown
                    String type = request.getParameter("recordType");

                    MedicalRecord newRecord = "DiagnosisReport".equalsIgnoreCase(type) ?
                            new healthcare.records.DiagnosisReport(
                                    id,
                                    request.getParameter("patientId"),
                                    request.getParameter("doctorId"),
                                    request.getParameter("diagnosis"),
                                    request.getParameter("prescription"),
                                    request.getParameter("visitDate")
                            ) :
                            new healthcare.records.Prescription(
                                    id,
                                    request.getParameter("patientId"),
                                    request.getParameter("doctorId"),
                                    request.getParameter("diagnosis"),
                                    request.getParameter("prescription"),
                                    request.getParameter("visitDate")
                            );

                    // save it to the file and go back to the list
                    fileHandler.saveMedicalRecord(newRecord);
                    response.sendRedirect(request.getContextPath() + "/record/list");
                    break;

                case "/update":
                    // get the details from the edit form
                    String uId = request.getParameter("recordId");
                    String uType = request.getParameter("recordType");

                    // recreate the record with the updated details
                    MedicalRecord uRecord = "DiagnosisReport".equalsIgnoreCase(uType) ?
                            new healthcare.records.DiagnosisReport(
                                    uId,
                                    request.getParameter("patientId"),
                                    request.getParameter("doctorId"),
                                    request.getParameter("diagnosis"),
                                    request.getParameter("prescription"),
                                    request.getParameter("visitDate")
                            ) :
                            new healthcare.records.Prescription(
                                    uId,
                                    request.getParameter("patientId"),
                                    request.getParameter("doctorId"),
                                    request.getParameter("diagnosis"),
                                    request.getParameter("prescription"),
                                    request.getParameter("visitDate")
                            );

                    // update it in the file and go back to the list
                    fileHandler.updateMedicalRecord(uId, uRecord);
                    response.sendRedirect(request.getContextPath() + "/record/list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
