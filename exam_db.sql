/*
													II, THIẾT KẾ CSDL
*/
-- 1. Thiết kế CSDL về quản lý đặt máy bay
create database exam_db;
use exam_db;
create table flight(
	flight_id varchar(10) primary key,
    airline_name varchar(100),
    departure_airport varchar(100),
    arrival_airport varchar(100),
    departure_time datetime,
    arrival_time datetime,
    ticket_price int
);
create table passenger(
	passenger_id varchar(10) primary key,
    passenger_full_name varchar(150) not null,
    passenger_email varchar(255) unique not null,
    passenget_phone char(15) unique not null,
    passenger_bod date
);
create table booking(
	booking_id int primary key auto_increment,
    passenger_id varchar(16) not null,
    flight_id varchar(16) not null,
    foreign key (passenger_id) references passenger(passenger_id),
	foreign key (flight_id) references flight(flight_id),
    booking_date date,
    booking_status enum('Comfirmed', 'Cancelled', 'Pending')
);
create table payment(
	payment_id int primary key auto_increment,
    booking_id int not null,
    foreign key(booking_id) references booking(booking_id),
	payment_method enum('Credit Card', 'Bank Transfer', 'Cash'),
    payment_amount decimal(10,2),
    payment_date date,
    payment_status enum('Success', 'Failed', 'Pending') 
);

-- 2. Thêm cột passenger_gender có kiểu dữ liệu enum với các giá trị 'Nam', 'Nữ', 'Khác' trong bảng passenger
alter table passenger
add passenger_gender enum('Nam', 'Nữ', 'Khác');

-- 3. Thêm cột ticket_quantity trong bảng Booking có kiểu dữ liệu là integer,có rằng buộc NOT NULL và có giá trị mặc định 1. Cột này thể hiện số lượng vé mà hành khách đặt
alter table booking
add ticket_quantity int not null default(1);

-- 4. Thêm ràng buộc cho cột payment_amount trong bảng payment có giá trị lớn hơn 0 và có kiểu dữ liệu decimal(10,2)
alter table payment
modify payment_amount decimal(10,2) not null,
add constraint payment_amount check(payment_amount > 0);

/* 
											III, THAO TÁC VỚI DỮ LIỆU TRONG BẢNG
*/
-- 1. Thêm dữ liệu
insert into passenger 
values('P0001', 'Nguyen Anh Tuan', 'tuan.nguyen@example.com', '0901234567', '1995-05-15', 'Nam'),
('P0002', 'Tran Thi Mai', 'mai.tran@example.com', '0912345678', '1996-06-16', 'Nữ'),
('P0003', 'Le Minh Tuan', 'tuan.le@example.com', '0923456789', '1997-07-17', 'Nam'),
('P0004', 'Pham Hong Son', 'son.pham@example.com', '0934567890', '1998-08-18', 'Nam'),
('P0005', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0945678901', '1999-09-19', 'Nữ'),
('P0006', 'Vu Thi Bao', 'bao.vu@example.com', '0956789012', '2000-10-20', 'Nữ'),
('P0007', 'Doan Minh Hoang', 'hoang.doan@example.com', '0967890123', '2001-11-21', 'Nam'),
('P0008', 'Nguyen Thi Thanh', 'thanh.nguyen@example.com', '0978901234', '2002-12-22', 'Nữ'),
('P0009', 'Trinh Bao Vy', 'vy.trinh@example.com', '0989012345', '2003-01-23', 'Nữ'),
('P0010', 'Bui Hoang Nam', 'nam.bui@example.com', '0990123456', '2004-02-24', 'Nam');
insert into flight 
values('F001', 'VietJet Air', 'Tan Son Nhat', 'Nha Trang', '2025-03-01 08:00:00', '2025-03-01 10:00:00', 150.5),
('F002', 'Vietnam Airlines', 'Noi Bai', 'Hanoi', '2025-03-01 09:00:00', '2025-03-01 11:30:00', 200.0),
('F003', 'Bamboo Airways', 'Da Nang', 'Phu Quoc', '2025-03-01 10:00:00', '2025-03-01 12:00:00', 120.8),
('F004', 'Vietravel Airlines', 'Can Tho', 'Ho Chi Minh', '2025-03-01 11:00:00', '2025-03-01 12:30:00', 180.0);
insert into booking (booking_id, passenger_id, flight_id, booking_date, booking_status,ticket_quantity)
values (1, 'P0001', 'F001', '2025-02-20', 'Comfirmed', 1),
(2, 'P0002', 'F002', '2025-02-21', 'Cancelled', 2),
(3, 'P0003', 'F003', '2025-02-22', 'Pending', 1),
(4, 'P0004', 'F004', '2025-02-23', 'Comfirmed', 3),
(5, 'P0005', 'F001', '2025-02-24', 'Pending', 1),
(6, 'P0006', 'F002', '2025-02-25', 'Comfirmed', 2),
(7, 'P0007', 'F003', '2025-02-26', 'Cancelled', 1),
(8, 'P0008', 'F004', '2025-02-27', 'Pending', 4),
(9, 'P0009', 'F001', '2025-02-28', 'Comfirmed', 1),
(10, 'P0010', 'F002', '2025-02-28', 'Pending', 1),
(11, 'P0001', 'F003', '2025-03-01', 'Comfirmed', 3),
(12, 'P0002', 'F004', '2025-03-02', 'Cancelled', 1),
(13, 'P0003', 'F001', '2025-03-03', 'Pending', 2),
(14, 'P0004', 'F002', '2025-03-04', 'Comfirmed', 1),
(15, 'P0005', 'F003', '2025-03-05', 'Cancelled', 2),
(16, 'P0006', 'F004', '2025-03-06', 'Pending', 1),
(17, 'P0007', 'F001', '2025-03-07', 'Comfirmed', 3),
(18, 'P0008', 'F002', '2025-03-08', 'Cancelled', 2),
(19, 'P0009', 'F003', '2025-03-09', 'Pending', 1),
(20, 'P0010', 'F004', '2025-03-10', 'Comfirmed', 1);
insert into payment
values (1, 1, 'Credit Card', 150.5, '2025-02-20', 'Success'),
(2, 2, 'Bank Transfer', 200.0, '2025-02-21', 'Failed'),
(3, 3, 'Cash', 120.8, '2025-02-22', 'Pending'),
(4, 4, 'Credit Card', 180.0, '2025-02-23', 'Success'),
(5, 5, 'Bank Transfer', 150.5, '2025-02-24', 'Pending'),
(6, 6, 'Cash', 200.0, '2025-02-25', 'Success'),
(7, 7, 'Credit Card', 120.8, '2025-02-26', 'Failed'),
(8, 8, 'Bank Transfer', 180.0, '2025-02-27', 'Pending'),
(9, 9, 'Cash', 150.5, '2025-02-28', 'Success'),
(10, 10, 'Credit Card', 200.0, '2025-03-01', 'Pending');

-- 2. Viết câu UPDATE
	-- Cập nhật trạng thái Success nếu số tiền thanh toán payment_amount >0 và phương thức thanh toán credit card
    set SQL_SAFE_UPDATES = 0;
    update payment
    set payment_status = 'Success'
    where payment_amount > 0 and payment_method = 'Credit Card' and payment_date < current_date();
    -- Cập nhất trạng thái thanh 'Pending' nếu phương thức thanh toán là 'Bank Transfer' và số tiền thanh toán <100
    update payment
    set payment_status = 'Pending'
    where payment_method = 'Bank Transfer' and payment_amount < 100 and payment_date < current_date();
-- 3. Xoá các bản ghi trong payment nếu trạng thái thanh toán là 'Pending' và phương thức thanh toán là 'Cash'
delete from payment
where payment_status = 'Pending' and payment_method = 'Cash';


/*
									IV, TRUY VẤN DỮ LIỆU
*/
-- 1. Lấy thông tin 5 khách hàng 
	select passenger_id, passenger_full_name, passenger_bod, passenger_gender
    from passenger
    order by passenger_full_name ASC
    limit 5;
-- 2. Lấy thông tin các chuyến bay
	select flight_id, airline_name, departure_airport,arrival_airport
    from flight
    order by ticket_price DESC;
-- 3. Lấy thông tin khách hàng
	FROM pasenger p
	JOIN booking b ON p.passenger_id = b.passenger_id
	JOIN flight f ON b.flight_id = f.flight_id
	WHERE  b.booking_status = 'Comfirmed';
-- 4
SELECT b.booking_id, p.passenger_id, f.flight_id
FROM booking b
JOIN pasenger p ON b.passenger_id = p.passenger_id
JOIN flight f ON b.flight_id = f.flight_id
WHERE b.booking_status = 'Pending'

    