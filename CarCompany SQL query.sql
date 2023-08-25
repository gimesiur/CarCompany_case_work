select * from case_data_manipulated$

drop table if exists employee_rank
create table employee_rank (
guaranteed_price_provider nvarchar(50),
accepted numeric,
declined numeric
)

insert into employee_rank
select guaranteed_price_provider, 
count(case when guarantee_bid_status = 'Accepted' then 1 end) as accepted,
count(case when guarantee_bid_status = 'Declined' then 1 end) as declined
from case_data_manipulated$
group by guaranteed_price_provider

create view employee_rank_view as
select *, cast(accepted/(accepted+declined) as decimal(7,2)) as acc_ratio
from employee_rank
--order by 3
