package healthcare.admin;

public class Admin {

    private String adminId;
    private String name;
    private String email;
    private String password;

    // Constructor
    public Admin(String adminId, String name, String email, String password) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // ---- Getters ----
    public String getAdminId() { return adminId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    // ---- Setters ----
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() {
        return "Administrator";
    }

    // Format: adminId,name,email,password
    public String toFileString() {
        return adminId + "," + name + "," + email + "," + password;
    }

    public static Admin fromFileString(String line) {
        if (line == null || line.trim().startsWith("#")) return null;
        String[] parts = line.split(",");
        if (parts.length < 4) return null;
        return new Admin(parts[0], parts[1], parts[2], parts[3]);
    }
}
