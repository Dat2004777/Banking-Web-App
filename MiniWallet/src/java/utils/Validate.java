/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import dal.UserDAO;
import java.util.ArrayList;
import model.User;

/**
 * Validate input
 *
 * @author dat20
 */
public class Validate {

    /**
     * Check input amount by user valid or not
     *
     * @param inputAmount input by user
     * @return true if valid - false if invalid
     */
    public boolean checkValidInputAmount(double inputAmount) {
        boolean isValid = false;

        if (inputAmount >= 2000) {
            isValid = true;
        }

        return isValid;
    }

    /**
     * Check receiver account number existed or not
     *
     * @param receiverAccountNumber input by user
     * @return true if valid - false if invalid
     */
    public boolean checkExistedReceiverAccountNumber(String receiverAccountNumber) {
        boolean isValid = false;
        UserDAO userDAO = new UserDAO();
        ArrayList<User> userList = userDAO.getAllUser();
        User receiverUser = null;

        for (User user : userList) {
            if (user.getAccountNumber().equalsIgnoreCase(receiverAccountNumber)) {
                receiverUser = user;
            }
        }

        if (receiverUser != null) {
            isValid = true;
        }

        return isValid;
    }

    /**
     * Check user send to them self or not
     *
     * @param senderAccountNumber input by user
     * @param receiverAccountNumber input by user
     * @return true if valid - false if invalid
     */
    public boolean checkValidAccountNumberUser(String senderAccountNumber, String receiverAccountNumber) {
        return senderAccountNumber.equals(receiverAccountNumber);
    }

    public boolean checkValidUserBalance(double inputAmount, User user) {
        boolean isValid = false;

        double userBalance = user.getBalance();

        if (inputAmount <= userBalance) {
            isValid = true;
        }

        return isValid;
    }
}
