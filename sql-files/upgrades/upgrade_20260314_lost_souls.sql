ALTER TABLE `char`
	ADD COLUMN `soul_deadline` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `delete_date`,
	ADD COLUMN `is_lost` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `soul_deadline`,
	ADD KEY `is_lost` (`is_lost`);

CREATE TABLE IF NOT EXISTS `lost_souls` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `char_id` INT(11) UNSIGNED NOT NULL,
  `account_id` INT(11) UNSIGNED NOT NULL,
  `char_name` VARCHAR(30) NOT NULL DEFAULT '',
  `char_num` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `lost_at` INT(11) UNSIGNED NOT NULL,
  `delete_after` INT(11) UNSIGNED NOT NULL,
  `restored_at` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `restored_by` VARCHAR(30) NOT NULL DEFAULT '',
  `restored_source` VARCHAR(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `char_id` (`char_id`),
  KEY `account_id` (`account_id`),
  KEY `delete_after` (`delete_after`)
) ENGINE=MyISAM;

-- Optional periodic purge:
-- DELETE c FROM `char` c JOIN `lost_souls` ls ON ls.char_id = c.char_id
-- WHERE c.is_lost = 1 AND ls.restored_at = 0 AND ls.delete_after <= UNIX_TIMESTAMP();
