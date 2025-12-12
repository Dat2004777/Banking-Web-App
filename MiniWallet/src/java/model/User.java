/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 * User model
 *
 * @author dat20
 */
public class User {

    private int id;
    private String username;
    private String fullName;
    private String accountNumber;
    private Double balance;

    public User() {
    }

    public User(int id, String username, String fullName, String accountNumber, Double balance) {
        this.id = id;
        this.username = username;
        this.fullName = fullName;
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", username=" + username + ", fullName=" + fullName + ", accountNumber=" + accountNumber + ", balance=" + balance + '}';
    }

}
