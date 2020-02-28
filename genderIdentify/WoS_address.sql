/*
CREATE TABLE measuring_dynamics_address_names(
id TEXT PRIMARY KEY NOT NULL,
addr_no_raw TEXT,
seq_no TEXT,
role TEXT,
reprint	TEXT, 
lang_id TEXT,
first_name TEXT,
last_name TEXT,
full_name TEXT,
year TEXT
);

INSERT INTO measuring_dynamics_address_names(id, addr_no_raw, seq_no, role, reprint, 
											 lang_id, first_name, last_name, full_name, year)
(SELECT DISTINCT on (a.id) a.id, a.addr_no_raw, a.seq_no, a.role, a.reprint, 
					 	a.lang_id, a.first_name, a.last_name, a.full_name, b.year
from
dblink('dbname=core_data user=yan30 password=ins_type_mixed_tobacco', 'select id::text, addr_no_raw::text, seq_no::text, role::text, reprint::text, lang_id::text, first_name::text, last_name::text, full_name::text from wos_core.wos_address_names') 
 		as a (id text, addr_no_raw text, seq_no text, role text, reprint text, lang_id text, first_name text, last_name text, full_name text),
dblink('dbname=core_data user=yan30 password=ins_type_mixed_tobacco', 'select id::text, pubyear::text from wos_core.wos_summary') 
 		as b (id text, year text)
where a.id = b.id AND b.year::integer >= 2008)


CREATE TABLE measuring_dynamics_addresses(
id TEXT PRIMARY KEY NOT NULL,
addr_no_raw TEXT,
full_address TEXT, 
country TEXT, 
country_lang_id TEXT,
year TEXT)
*/

INSERT INTO measuring_dynamics_addresses(id, addr_no_raw, full_address, country, country_lang_id, year)
(SELECT DISTINCT on (a.id) a.id, a.addr_no, a.full_address, a.country, a.country_lang_id, b.year
from
dblink('dbname=core_data user=yan30 password=ins_type_mixed_tobacco', 'select id::text, addr_no::text, full_address::text, country::text, country_lang_id::text from wos_core.wos_addresses') 
 		as a (id text, addr_no text, full_address text, country text, country_lang_id text),
dblink('dbname=core_data user=yan30 password=ins_type_mixed_tobacco', 'select id::text, pubyear::text from wos_core.wos_summary') 
 		as b (id text, year text)
where a.id = b.id AND b.year::integer >= 2008)
