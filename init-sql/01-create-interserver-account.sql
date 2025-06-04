-- 创建服务器间通信账户
-- 用于Login, Char, Map服务器之间的通信

USE rathena;

-- 插入服务器间通信账户 (性别'S'表示服务器账户)
INSERT IGNORE INTO `login` (`account_id`, `userid`, `user_pass`, `sex`, `email`, `group_id`, `state`, `unban_time`, `expiration_time`, `logincount`, `lastlogin`, `last_ip`, `birthdate`, `character_slots`, `pincode`, `pincode_change`, `vip_time`, `old_group`)
VALUES 
(1, 's1', 'p1', 'S', 'server@localhost', 99, 0, 0, 0, 0, NULL, '', '0000-00-00', 0, '', 0, 0, 0);

-- 确保服务器账户有正确的权限
UPDATE `login` SET `group_id` = 99 WHERE `userid` = 's1'; 