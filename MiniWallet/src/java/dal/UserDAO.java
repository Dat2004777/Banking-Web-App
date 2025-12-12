/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Query User in database
 *
 * @author dat20
 */
public class UserDAO extends DBContext {

    /**
     * check username and password to login
     *
     * @param username input by user
     * @param password input by user
     * @return User has true username and password
     */
    public User login(String username, String password) {
        try {
            String sql = "SELECT u.id, u.username, u.full_name, u.account_number, u.balance\n"
                    + "FROM Users u WHERE username = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("account_number"),
                        rs.getDouble("balance"));

                return user;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     * Get all user in database
     *
     * @return a list user
     */
    public ArrayList<User> getAllUser() {
        try {
            String sql = "SELECT u.id, u.username, u.full_name, u.account_number, u.balance FROM Users u";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            ArrayList<User> userList = new ArrayList<>();

            while (rs.next()) {
                User user = new User(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("account_number"),
                        rs.getDouble("balance"));

                userList.add(user);
            }

            return userList;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     * Get user in database by account number
     *
     * @param accountNumber input by user
     * @return user if existed - null if not exist
     */
    public User getUserByAccountNumber(String accountNumber) {
        try {
            String sql = "SELECT u.id, u.username, u.full_name, u.account_number, u.balance FROM Users u WHERE account_number = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, accountNumber);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("account_number"),
                        rs.getDouble("balance"));

                return user;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get user by id in database
     *
     * @param id input by user
     * @return user if existed - null if not exists
     */
    public User getUserByID(int id) {
        try {
            String sql = "SELECT u.id, u.username, u.full_name, u.account_number, u.balance\n"
                    + "FROM Users u WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("account_number"),
                        rs.getDouble("balance"));

                return user;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

}
