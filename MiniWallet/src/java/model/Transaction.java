/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 * Transaction model
 *
 * @author dat20
 */
public class Transaction {

    private int id;
    private int senderID;
    private int receiverID;
    private String type;
    private double amount;
    private String message;
    private Timestamp time;

    public Transaction() {
    }

    public Transaction(int id, String type, double amount, String message) {
        this.id = id;
        this.type = type;
        this.amount = amount;
        this.message = message;
    }

    public Transaction(int id, String type, double amount, String message, Timestamp time) {
        this.id = id;
        this.type = type;
        this.amount = amount;
        this.message = message;
        this.time = time;
    }

    public Transaction(int id, int senderID, int receiverID, String type, double amount, String message, Timestamp time) {
        this.id = id;
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.type = type;
        this.amount = amount;
        this.message = message;
        this.time = time;
    }

    public int getSenderID() {
        return senderID;
    }

    public void setSenderID(int senderID) {
        this.senderID = senderID;
    }

    public int getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "Transaction{" + "id=" + id + ", type=" + type + ", amount=" + amount + ", message=" + message + '}';
    }

}
