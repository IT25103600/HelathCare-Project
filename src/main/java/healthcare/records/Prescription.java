package healthcare.records;

// this class is for normal medical prescriptions.
// patients can usually see their own prescriptions without special access.
public class Prescription extends MedicalRecord {

    // pass all the details to the parent class, and hardcode the type as "Prescription"
    public Prescription(String recordId, String patientId, String doctorId,
                        String diagnosis, String prescription, String visitDate) {
        super(recordId, patientId, doctorId, diagnosis, prescription, visitDate, "Prescription");
    }

    // prescriptions are just normal records so they don't need special permission
    @Override
    public boolean requiresSpecialAuthorization() {
        return false; 
    }
}
