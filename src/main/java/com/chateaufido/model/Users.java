/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.model;

/**
 *
 * @author a1990
 */
public class Users {
    private String Fullname;
    private String Address;
    private String Email;
    private String Password;

    public Users(String Fullname, String Address, String Email, String Password) {
        this.Fullname = Fullname;
        this.Address = Address;
        this.Email = Email;
        this.Password = Password;
    }

    public Users() {
    }

    public String getFullname() {
        return Fullname;
    }

    public void setFullname(String Fullname) {
        this.Fullname = Fullname;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }
    
    
}
