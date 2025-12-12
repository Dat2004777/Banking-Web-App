/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Transaction;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Query transaction in database
 *
 * @author dat20
 */
public class TransactionDAO extends DBContext {

    /**
     * get all transaction of userID
     *
     * @param userID userID
     * @return a list of transaction
     */
    public ArrayList<Transaction> getAllUserTransaction(int userID) {
        try {
            String sql = "SELECT t.id, t.sender_id, t.receiver_id, t.type, t.amount, t.message, t.created_at FROM Transactions t\n"
                    + "WHERE t.sender_id = ? OR t.receiver_id = ? ORDER BY t.created_at DESC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, userID);
            ResultSet rs = ps.executeQuery();

            ArrayList<Transaction> transactionList = new ArrayList<>();

            while (rs.next()) {
                Transaction transaction = new Transaction(rs.getInt("id"),
                        rs.getInt("sender_id"),
                        rs.getInt("receiver_id"),
                        rs.getString("type"),
                        rs.getDouble("amount"),
                        rs.getString("message"),
                        rs.getTimestamp("created_at"));

                transactionList.add(transaction);
            }

            return transactionList;

        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     * Doing withdraw service
     *
     * @param userID userID
     * @param amount withdrawAmount
     * @return true if success - false if fail
     */
    public boolean withdraw(int userID, double amount) {
        boolean isDone = false;

        try {
            // set autocommit false
            connection.setAutoCommit(false);

            // xu li balance cua user
            String updateSql = "UPDATE Users SET balance = balance - ? WHERE id = ?";
            PreparedStatement psUpdate = connection.prepareStatement(updateSql);
            psUpdate.setDouble(1, amount);
            psUpdate.setInt(2, userID);

            int rowsAffected = psUpdate.executeUpdate();

            // Nếu không tìm thấy user hoặc không update được dòng nào -> Rollback ngay
            if (rowsAffected == 0) {
                connection.rollback();
                return false;
            }

            // ghi lai transaction
            String insertSql = "INSERT INTO Transactions (sender_id, receiver_id, amount, message, type) VALUES (?, NULL, ?, ?, 'WITHDRAW')";
            PreparedStatement psInsert = connection.prepareStatement(insertSql);
            psInsert.setInt(1, userID);
            psInsert.setDouble(2, amount);
            psInsert.setString(3, "Rút tiền mặt");
            psInsert.executeUpdate();

            // hoan thanh 
            connection.commit();
            isDone = true;
        } catch (SQLException ex) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
            isDone = false;
        } finally {
            // Nên bật lại AutoCommit cho các hàm khác dùng chung connection
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException ex) {
            }
        }

        return isDone;
    }

    /**
     * Doing deposit service
     *
     * @param userID userID
     * @param depositAmount depositAmount
     * @return true if success - false if fail
     */
    public boolean deposit(int userID, double depositAmount) {
        boolean isDone = false;

        try {
            //tat auto commit
            connection.setAutoCommit(false);

            // xu li balance cua user trong database
            String updateSql = "UPDATE Users SET balance = balance + ? WHERE id = ?";
            PreparedStatement psUpdate = connection.prepareStatement(updateSql);
            psUpdate.setDouble(1, depositAmount);
            psUpdate.setInt(2, userID);

            // neu fail thi rollback
            int rows = psUpdate.executeUpdate();
            if (rows == 0) {
                connection.rollback();
                return false;
            }

            // ghi lich su
            String insertSql = "INSERT INTO Transactions (sender_id, receiver_id, amount, message, type) VALUES (NULL, ?, ?, ?, 'DEPOSIT')";
            PreparedStatement psInsert = connection.prepareStatement(insertSql);
            psInsert.setInt(1, userID);
            psInsert.setDouble(2, depositAmount);
            psInsert.setString(3, "Nạp tiền vào ví");
            psInsert.executeUpdate();

            // hoan thanh
            connection.commit();
            isDone = true;

        } catch (SQLException ex) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException e) {
            }
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException ex) {
            }
        }

        return isDone;
    }

    /**
     * Doing transfer service
     *
     * @param senderID senderID
     * @param receiverID receiverID
     * @param transferAmount transferAmount
     * @param message message of transfer
     * @return true if success - false if fail
     */
    public boolean transfer(int senderID, int receiverID, double transferAmount, String message) {
        boolean isDone = false;

        try {
            // tat auto commit
            connection.setAutoCommit(false);

            // tru tien sender
            String updateSqlSender = "UPDATE Users SET balance = balance - ? WHERE id = ?";
            PreparedStatement psUpdateSender = connection.prepareStatement(updateSqlSender);
            psUpdateSender.setDouble(1, transferAmount);
            psUpdateSender.setInt(2, senderID);

            // check rollback sender if false
            int rowsSender = psUpdateSender.executeUpdate();
            if (rowsSender == 0) {
                connection.rollback();
                return false;
            }

            // cong tien receiver
            String updateSqlReceiver = "UPDATE Users SET balance = balance + ? WHERE id = ?";
            PreparedStatement psUpdateReceiver = connection.prepareStatement(updateSqlReceiver);
            psUpdateReceiver.setDouble(1, transferAmount);
            psUpdateReceiver.setInt(2, receiverID);

            //check rollback receiver
            int rowsReceiver = psUpdateReceiver.executeUpdate();
            if (rowsReceiver == 0) {
                connection.rollback();
                return false;
            }

            // ghi lich su
            String insertSql = "INSERT INTO Transactions (sender_id, receiver_id, amount, message, type) VALUES (?, ?, ?, ?, 'TRANSFER')";
            PreparedStatement psInsert = connection.prepareStatement(insertSql);
            psInsert.setInt(1, senderID);
            psInsert.setInt(2, receiverID);
            psInsert.setDouble(3, transferAmount);
            psInsert.setString(4, message);
            psInsert.executeUpdate();

            // hoan thanh
            connection.commit();
            isDone = true;
        } catch (SQLException ex) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
            isDone = false;
        } finally {
            // Nên bật lại AutoCommit cho các hàm khác dùng chung connection
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException ex) {
            }
        }

        return isDone;
    }

}
