package healthcare.records;

// this class is for diagnosis reports.
// since diagnosis reports can have sensitive info, i separated it from normal prescriptions.
public class DiagnosisReport extends MedicalRecord {

    // pass all the details to the parent class, and hardcode the type as "DiagnosisReport"
    public DiagnosisReport(String recordId, String patientId, String doctorId,
                           String diagnosis, String prescription, String visitDate) {
        super(recordId, patientId, doctorId, diagnosis, prescription, visitDate, "DiagnosisReport");
    }

    // since this is a diagnosis report with sensitive data, it needs special permission
    @Override
    public boolean requiresSpecialAuthorization() {
        return true; 
    }
}
