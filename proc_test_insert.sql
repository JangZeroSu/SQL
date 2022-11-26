create or replace procedure proc_test_insert
(
    p_university 	in  varchar2,
    p_name       	in  varchar2,
	p_age        	in  number,
	p_code 			out integer,
	p_msg  			out varchar2
)
is

row_num integer:=0;

begin
	p_code := 0;
	p_msg  := 'ok';
	
	insert into tb1 (university, name, age)
	values (p_university, p_name, p_age);

	commit;

exception when others then
    rollback;
    p_code := sqlcode;
	p_msg  := sqlerrm;
end;
/ show err;

