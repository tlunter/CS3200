package cs3200_hw4;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class User {
    String username;
    String password;
    String firstName;
    String lastName;
    String email;
    Date dateOfBirth;
    
    public User() {}
    public User(String username, String password, String firstName, String lastName, String email, Date dateOfBirth) {
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.dateOfBirth = dateOfBirth;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return this.username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return this.password;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFirstName() {
        return this.firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return this.email;
    }

    public void setDateOfBirth(String dateOfBirth) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            this.dateOfBirth = formatter.parse(dateOfBirth);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Date getDateOfBirth() {
        return this.dateOfBirth;
    }
}
