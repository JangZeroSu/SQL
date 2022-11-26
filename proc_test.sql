create or replace procedure proc_workorder_control 
(
    p_in in varchar2,

    p_code          out number,
    p_msg           out varchar2
)
is
 row_cnt integer;
 v_woid  varchar2(100);
 
    v_gubun         in  varchar2,
    v_woid 		    in  varchar2,
    v_wcid 		    in  varchar2,
    v_pmid 		    in  varchar2,
    v_wostat 		in  varchar2,
    v_wostarttime   in  varchar2,
    v_woendtime     in  varchar2,
    v_woplanqty     in  number,
    v_woprodqty     in  number,
    v_mbno          in  varchar2,
    v_wcnowtem      in  number,
    v_wcnowhum      in  number,  
	
begin
  p_code := 0;
  p_msg  := 'ok';
  
  v_gubun       ：= wsf_common_param('p_woid 		');      
  v_woid 		：= wsf_common_param('p_wcid 		'); 
  v_wcid 		：= wsf_common_param('p_pmid 		'); 
  v_pmid 		：= wsf_common_param('p_wostat 	   '); 
  v_wostat 	    ：= wsf_common_param('p_wostarttime');
  v_wostarttime ：= wsf_common_param('p_woendtime  ');
  v_woendtime   ：= wsf_common_param('p_woplanqty  ');
  v_woplanqty   ：= wsf_common_param('p_woprodqty  ');
  v_woprodqty   ：= wsf_common_param('p_mbno       ');
  v_mbno        ：= wsf_common_param('p_wcnowtem   ');

  select woid, wcid, pmid, wostat...
  from   workorder
  where  woid like v_woid||'%'
  and    (
            (v_pmid is null) or
			(v_pmid is not null and pmid = 'PME01')
	      )
		  
  
  if p_gubn = 'C' then
	begin 
		select max(woid) into v_woid
		from   workorder;
    exception 
     when others then
       	 v_woid := 'wo00001';
    end;
	
    	
	insert into workorder
	values
	(
	 'wo'||trim(to_char(workorder_seq.nextval,'00000')),
	 p_wcid,
	 p_pmid,
	 p_wostat     , 	
	 p_wostarttime,
     p_woendtime  ,
     p_woplanqty  ,
     p_woprodqty  ,
     p_mbno       ,
     p_wcnowtem   ,
     p_wcnowhum   
	);
  elsif p_gubun = 'U' then
  
  elsif p_gubun = 'D' then
  
  end if;
  commit;
  
exception when others then
	rollback;
	p_code := sqlcode;
	p_msg  := sqlerrm;
	
end;