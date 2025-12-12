-- 1. Bảng Users: Lưu thông tin và Số dư hiện tại
CREATE TABLE Users (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	[password] VARCHAR(100) NOT NULL,
	full_name NVARCHAR(100),
	account_number VARCHAR(20) UNIQUE, -- Số tài khoản (VD: 190012345)
	balance DECIMAL(18, 0) DEFAULT 0, -- Số dư (Quan trọng nhất)
	created_at DATETIME DEFAULT GETDATE()
)

-- 2. Bảng Transactions: Lưu lịch sử biến động
CREATE TABLE Transactions (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	sender_id INT, -- Người gửi (NULL nếu là nạp tiền tại quầy)
	receiver_id INT, -- Người nhận (NULL nếu là rút tiền)
	amount DECIMAL(18, 0) NOT NULL, -- Số tiền
	[message] NVARCHAR(255), -- Nội dung chuyển khoản
	[type] VARCHAR(20), -- 'DEPOSIT' (Nạp), 'WITHDRAW' (Rút), 'TRANSFER' (Chuyển)
	created_at DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (sender_id) REFERENCES Users(id),
    FOREIGN KEY (receiver_id) REFERENCES Users(id)
)

-- Thêm 2 user để test chuyển tiền
INSERT INTO Users (username, password, full_name, account_number, balance) 
VALUES ('nguyena', '123', N'Nguyễn Văn A', '10001', 5000000); -- Có 5 triệu

INSERT INTO Users (username, password, full_name, account_number, balance) 
VALUES ('tranb', '123', N'Trần Văn B', '10002', 1000000); -- Có 1 triệu