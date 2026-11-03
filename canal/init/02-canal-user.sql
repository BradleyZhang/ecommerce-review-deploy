-- canal 复制账号（仅在 MySQL 数据卷首次初始化时执行）
CREATE USER IF NOT EXISTS 'canal'@'%' IDENTIFIED WITH mysql_native_password BY 'canal';
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
FLUSH PRIVILEGES;
