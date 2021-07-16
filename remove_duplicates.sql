DELETE
FROM
  (
	 SELECT
		A.*
	  , ROW_NUMBER() OVER (PARTITION BY <colmn_on_which_you_want_to_group> ORDER BY
						   <the_column_which_has_duplicates> DESC) AS ROWNUM
	 FROM
		table_name
  )
WHERE
  ROWNUM > 1
;