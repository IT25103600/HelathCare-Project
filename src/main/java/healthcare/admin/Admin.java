package healthcare.admin;

public class Admin {

    private String adminId;
    private String name;
    private String email;
    private String password;

    
    public Admin(String adminId, String name, String email, String password) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    
    public String getAdminId() { return adminId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() {
        return "Administrator";
    }

    // Format: adminId,name,email,password
    public String toFileString() {                 // Converts object to text format
        return adminId + "," + name + "," + email + "," + password;
    }

    public static Admin fromFileString(String line) {  // Converts text to object
        if (line == null || line.trim().startsWith("#")) return null;     // Skips:empty lines,comment lines (#)  
        String[] parts = line.split(",");       //Ensures correct data format
        if (parts.length < 4) return null;
        return new Admin(parts[0], parts[1], parts[2], parts[3]);
    }
}
