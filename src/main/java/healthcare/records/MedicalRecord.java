package healthcare.records;

// this is the base class for all medical records.
// i made it abstract because a record is always either a Prescription or a DiagnosisReport.
// they both share these basic details.
public abstract class MedicalRecord {

    // unique id for the record (like R001)
    private String recordId;
    
    // patient and doctor IDs
    private String patientId;
    private String doctorId;
    
    // details of the visit
    private String diagnosis;
    private String prescription;
    private String visitDate;
    
    // this tells us if its a Prescription or DiagnosisReport
    private String recordType;

    // constructor to set all details at once when creating a new record
    public MedicalRecord(String recordId, String patientId, String doctorId,
                         String diagnosis, String prescription, String visitDate, String recordType) {
        this.recordId = recordId;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.diagnosis = diagnosis;
        this.prescription = prescription;
        this.visitDate = visitDate;
        this.recordType = recordType;
    }

    // getters to read the values
    public String getRecordId()      { return recordId; }
    public String getPatientId()     { return patientId; }
    public String getDoctorId()      { return doctorId; }
    public String getDiagnosis()     { return diagnosis; }
    public String getPrescription()  { return prescription; }
    public String getVisitDate()     { return visitDate; }
    public String getRecordType()    { return recordType; }

    // setters to update the values if needed
    public void setRecordId(String recordId)         { this.recordId = recordId; }
    public void setPatientId(String patientId)       { this.patientId = patientId; }
    public void setDoctorId(String doctorId)         { this.doctorId = doctorId; }
    public void setDiagnosis(String diagnosis)       { this.diagnosis = diagnosis; }
    public void setPrescription(String prescription) { this.prescription = prescription; }
    public void setVisitDate(String visitDate)       { this.visitDate = visitDate; }
    public void setRecordType(String recordType)     { this.recordType = recordType; }

    // child classes will decide if they need special permission
    public abstract boolean requiresSpecialAuthorization();

    // converts the record into a single comma-separated line for saving in the text file
    public String toFileString() {
        return recordId + "," + patientId + "," + doctorId + "," +
                diagnosis + "," + prescription + "," + visitDate + "," + recordType;
    }

    // reads a line from the text file and recreates the record object
    public static MedicalRecord fromFileString(String line) {
        // skip empty or comment lines
        if (line == null || line.trim().startsWith("#")) return null;

        String[] parts = line.split(",");

        // if there are less than 7 parts, assume it's a basic prescription
        if (parts.length < 7) {
            if (parts.length == 6) {
                return new Prescription(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
            }
            return null;
        }

        // check the last part to see which type to create
        String type = parts[6].trim();
        if ("DiagnosisReport".equalsIgnoreCase(type)) {
            return new DiagnosisReport(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        } else {
            return new Prescription(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        }
    }
}

// Minor logic optimization 328
