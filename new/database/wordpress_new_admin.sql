INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'admin', '$P$Bxv6Y9tZ2Zz3', 'admin', 'admin@localhost', '', '2019-01-01 00:00:00', '', 0, 'admin');
INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'wp_capabilities', 'a:1:{s:13:"administrator";s:1:"1";}'),
(2, 1, 'wp_user_level', '10');