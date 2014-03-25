package cs3200_hw4;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class Actor {
    Integer id;
    String firstName;
    String lastName;
    Date dateOfBirth;

    public Actor() {}
    public Actor(Integer id, String firstName, String lastName, Date dateOfBirth) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfBirth = dateOfBirth;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return this.id;
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

    public void setDateOfBirth(String dateOfBirth) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            this.dateOfBirth = format.parse(dateOfBirth);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Date getDateOfBirth() {
        return this.dateOfBirth;
    }
}
