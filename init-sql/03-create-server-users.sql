-- 创建服务器间通信用户
-- 删除默认的 s1 用户（如果存在）
DELETE FROM `login` WHERE `userid` = 's1';

-- 创建 char 服务器用户
INSERT INTO `login` (`account_id`, `userid`, `user_pass`, `sex`, `email`, `group_id`, `state`, `unban_time`, `expiration_time`, `logincount`, `lastlogin`, `last_ip`, `birthdate`, `character_slots`, `pincode`, `pincode_change`, `vip_time`, `old_group`) 
VALUES 
(1, 'rathena_char', 'rathena_char_pass', 'S', 'char-server@rathena.local', 99, 0, 0, 0, 0, NULL, '', '0000-00-00', 0, '', 0, 0, 0);

-- 创建 map 服务器用户
INSERT INTO `login` (`account_id`, `userid`, `user_pass`, `sex`, `email`, `group_id`, `state`, `unban_time`, `expiration_time`, `logincount`, `lastlogin`, `last_ip`, `birthdate`, `character_slots`, `pincode`, `pincode_change`, `vip_time`, `old_group`) 
VALUES 
(2, 'rathena_map', 'rathena_map_pass', 'S', 'map-server@rathena.local', 99, 0, 0, 0, 0, NULL, '', '0000-00-00', 0, '', 0, 0, 0); 