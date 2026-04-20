use ss5;
CREATE TABLE Orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NULL COMMENT 'Khóa ngoại liên kết bảng Users. Cho phép NULL đối với đơn ảo do hệ thống tự sinh.',
    total_amount DECIMAL(15, 2) NOT NULL COMMENT 'Tổng giá trị thanh toán của đơn hàng.',
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING' COMMENT 'Trạng thái: PENDING, SUCCESS, CANCELLED, ...',
    note TEXT NULL COMMENT 'Ghi chú của khách hàng hoặc admin (VD: "giao gấp", "hàng dễ vỡ").',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời gian tạo đơn',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời gian cập nhật cuối'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

select order_id,user_id,total_amount,status,note,
case 
    when total_amount > 4000000 then 'Nguy hiểm'
    else 'Bình thường'
end as alert_level
from Orders
where (total_amount between 2000000 and 5000000) and (status <> 'CANCELLED') and ((note like '%gấp%') or (user_id is Null))
order by total_amount desc
limit 20 
offset 40;
--  Khi nhập số trang âm thì ta cho nó auto set lại bằng 1 để tránh lỗi code khi trang âm 
-- Phải thêm các dấu ngoặc trong phần where để tránh sai điều kiện giữa and và or