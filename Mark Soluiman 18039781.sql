--Part B
--Creating tables
create table roads(
road_id varchar2(10) PRIMARY key,road_name varchar2(30) , road_desc varchar2(50),road_categ varchar2(15) not null, road_length number(3),start_id varchar2(10),
end_id varchar2(10),constraint start_id_fk FOREIGN key (start_id) REFERENCES startlocation (start_id),CONSTRAINT end_id_fk FOREIGN key (end_id)REFERENCES
endlocation (end_id)
);
alter table roads
add(subroad_id varchar2(10));

alter table roads modify(road_length number(4,2));


create table startlocation(

start_id varchar2(10) primary key,start_name varchar2(30), start_longitude number (4,2),start_latitude number(4,2),start_desc varchar2(50)
);

alter table startlocation modify(start_longitude varchar2(10));
alter table startlocation modify(start_latitude varchar2(10));


create table endlocation(
end_id varchar2(10) primary key, end_name varchar2(30), end_longitude number(4,2),end_latitude number (4,2), end_desc varchar2(50)
);

alter table endlocation modify(end_longitude varchar2(10));
alter table endlocation modify(end_latitude varchar2(10));



create table project(
project_code varchar2(10) PRIMARY key, project_name varchar2(15), projcet_desc varchar2(50), project_start date, project_end date
);

alter table project modify( project_name varchar2(20));

create table project_road(
project_code varchar2(10), road_id varchar2(10),CONSTRAINT project_code_road_id_pk PRIMARY key(project_code,road_id),CONSTRAINT project_code_fk
FOREIGN key (project_code)references project(project_code), CONSTRAINT road_id_fk FOREIGN key (road_id)references roads(road_id)
);

create table role(
role_id varchar2(10) PRIMARY key, role_name varchar2(20), role_desc varchar2(30)
);

alter table role modify(role_desc varchar2(50));

create table project_role(
role_id varchar2(10), project_code varchar2(10), CONSTRAINT role_id_project_code_pk PRIMARY key (role_id,project_code),CONSTRAINT role_id_fk FOREIGN key
(role_id) references role(role_id),CONSTRAINT project_role_project_code_fk FOREIGN key (project_code)references project (project_code)
);

create table arc_employees(
employee_id varchar2(10) primary key, first_name varchar2(10) not null, last_name varchar2(10) not null, hire_date date not null, birth_date date Not null,   gender 
char(1) not null,postal_address varchar2(50), phone_number varchar2(30),email varchar2(50)
);

create table employees_roles(
employee_id varchar2(10), role_id varchar2(10), assigning_start date, assigning_end date, changes varchar2(50),CONSTRAINT employee_id_role_id_pk PRIMARY key
(employee_id,role_id),CONSTRAINT employee_id_fk FOREIGN key (employee_id)references arc_employees(employee_id),CONSTRAINT employees_role_id_fk FOREIGN
key (role_id)references role(role_id)
);


create table company(
company_id varchar2(10) primary key, company_name varchar2(20), company_address varchar2(50)not null ,company_phone varchar2(15), company_email
varchar2(30) not null
);

alter table company modify(company_name varchar2(25) not null);
alter table company modify(company_email varchar2(35));





create table contract (
contract_id varchar2(10) primary key, project_code varchar2(10),company_id varchar2(10), contract_name varchar2(20), contract_desc varchar2(50), contract_est_cost
number (6,2), contract_act_cost number(6,2), contract_start date, contract_end date, CONSTRAINT contract_project_code_fk FOREIGN key (project_code)
references project (project_code),CONSTRAINT company_id_fk FOREIGN key (company_id) references company (company_id)
);

alter table contract modify (contract_name varchar2 (50));

create table contract_manager(
employee_id varchar2(10),contract_id varchar2(10), manager_start date,manager_end date,CONSTRAINT manager_employee_fk foreign key (employee_id) references
arc_employees (employee_id),CONSTRAINT manager_contract_id_fk FOREIGN key (contract_id) references contract (contract_id) 
);

alter table contract_manager
modify(constraint employee_id_contract_id_pk PRIMARY key (employee_id,contract_id) );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Making some values unique:

alter table roads modify(constraint road_name_uk unique (road_name));

alter table startlocation modify(constraint startlocation_name_uk unique(start_name));

alter table endlocation modify(constraint endlocation_name_uk unique (end_name));

alter table project modify(constraint project_name_uk unique (project_name));

alter table role modify(constraint role_name_uk unique (role_name));

alter table arc_employees modify(constraint phone_number_uk unique(phone_number));

alter table arc_employees modify(constraint email_uk unique(email));

alter table company modify (constraint company_name_uk unique(company_name));

alter table company modify (constraint company_address_uk unique(company_address));

alter table company modify (constraint company_phone_uk unique(company_phone));

alter table company modify (constraint company_email_uk unique(company_email));

alter table contract modify(constraint contract_name_uk unique(contract_name));








------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Adding values to tables

--Roads

insert into roads values('1', 'Abbey Road',null ,'Sub Road', 1.5, 'S-5', 'E-2',null);
insert into roads values('2', 'Adelaid Road',null ,'Main Road', 3.7, 'S-5', 'E-1',1);
insert into roads values('3', 'Mission Place','More than 5 Kilometers'  ,'Main Road', 7.8, 'S-1', 'E-1',2);
insert into roads values('4', 'High Way 18','more than 25 Kilometers' ,'Motor Way', 28.5, 'S-2', 'E-4',3);
insert into roads values('5', 'Bow Lane',null ,'Unseald Road', 2, 'S-3', 'E-3',null);


select * from roads;



--Start Location

insert into startlocation values('1','Glenfield','34E ','32S',null);

update startlocation set start_id='S-1';

insert into startlocation values('S-2','Albany','30E','34.5S',null);

insert into startlocation values('S-3','South Auckland','6E','15.5S',null);

insert into startlocation values('S-4','Takapuna','30.5E','1.7S',null);

insert into startlocation values('S-5','North Cote','110E','50S','Has 2 roads');

select * from startlocation;
commit;

--End Location

insert into endlocation values('E-1','Bay view','120E','20.5S','Has 2 roads');

insert into endlocation values('E-2','Albany','30E','34,5S',null);

insert into endlocation values('E-3','Eden Terrace','130.5E','27.5S',null);

insert into endlocation values('E-4','Hill Crest','136.5E','70S',null);

insert into endlocation values('E-5','Clover Park','10.5E','10S',null);



select * from endlocation;

--Project

insert into project values('P-1','Sub Road fix','Rebilding Abby Road after Earthquake','1-1-2000','1-3-2001');
insert into project values('P-2','Road build','Making a new road','10-1-2002','10-3-2003');
insert into project values('P-3','Long Road build','Making a long road','1-1-2004','1-7-2005');
insert into project values('P-4','High way fix','Maintaining the high way','1-7-2000','1-1-2001');
insert into project values('P-5','Small road build','Making a new small sub road','1-5-2005','20-12-2005');

select * from project;

commit;

--Project Road

insert into project_road values('P-1','1');
insert into project_road values('P-2','2');
insert into project_road values('P-3','3');
insert into project_road values('P-4','4');
insert into project_road values('P-5','5');

select * from project_road;

commit;


insert into role values('R-1','Manager','The Manager of the Project');
insert into role values('R-2','Supervisor ','The supervisor of the Project');
insert into role values('R-3','Accountant','Manages the expenses of the project');
insert into role values('R-4','labour-cheif','Suprvise over the workers');
insert into role values('R-5','labour',null);

select * from role;
commit;

--Project Role

insert into project_role values('R-1','P-1');
insert into project_role values('R-1','P-2');
insert into project_role values('R-1','P-3');
insert into project_role values('R-1','P-4');
insert into project_role values('R-1','P-5');
insert into project_role values('R-2','P-3');
insert into project_role values('R-3','P-2');
insert into project_role values('R-4','P-5');
insert into project_role values('R-5','P-5');

select* from project_role;
commit;




--Employees

insert into arc_employees values('EM-1','Mark','Johnson','20-06-2011','18-07-1990','M','1 Alexandra Road, Auckland',null,'Mark.J@mail.com');
insert into arc_employees values('EM-2','Max','Winter','20-06-2011','20-01-1987','M','20 	Morden Lane, Auckland',null,'Max.W@mail.com');
insert into arc_employees values('EM-3','Jessica','Heart','20-07-2015','02-11-1995','F','39 Ball Court, Auckland','0-154-7532','Jessica.H@mail.com');
insert into arc_employees values('EM-4','Mandy','Brown','12-07-2021','30-01-1995','F','100 Charlotte Street, Auckland','0-585-5998','Mandy.B@mail.com');
insert into arc_employees values('EM-5','Mary','Scoot','09-09-1998','07-02-1975','F','56 	Standard Place, Auckland','0-154-6632',null);
insert into arc_employees values('EM-6','Mary','Halter','10-10-2011','19-09-1991','F','100 Standard Drive, Auckland',null,'Mary.H@mail.com');


select * from arc_employees;
commit;




--Employees Roles

insert into employees_roles values('EM-1','R-1','30-03-2019',null ,null);
insert into employees_roles values('EM-2','R-2','30-03-2019',null ,null);
insert into employees_roles values('EM-4','R-1','30-03-2017','01-04-2019' ,null);
insert into employees_roles values('EM-5','R-5','30-03-2020','15-04-2020' ,'got sick');
insert into employees_roles values('EM-3','R-5','30-06-2021',null ,null);

select * from employees_roles;


commit;

--Contract Company

insert into company values('C-1','Majesty Contractors','120 Main road, Auckland','123-4567','Majesty.C@companymail.com');
insert into company values('C-2','Radical Contractors','20 Queen road, Auckland','123-2286','Queen.C@companymail.com');
insert into company values('C-3','High Quality Contractors','39 Hazelnut Lane, Auckland',null,'High_Quality.C@companymail.com');
insert into company values('C-4','Friends Contractors','55 Bolton Road, Auckland',null,'Friends.C@companymail.com');
insert into company values('C-5','International Contractors','55 Silver Avenue, Auckland','123-0161','International.C@companymail.com');


select * from company;

commit;

--Contract

insert into contract values('CT-1','P-1','C-1','Majesty Contractors Contract',null,123.24,123,'10-10-2012',null);
insert into contract values('CT-2','P-2','C-2','Radical Contractors Contract','very low cost',10.5,11,'10-10-2017','1-3-2018');
insert into contract values('CT-3','P-3','C-3','High Quality Contractors Contract','Very high cost',700,700,'1-7-2013','1-5-2015');
insert into contract values('CT-4','P-4','C-4','Friends Contractors Contract',null,200,205,'25-04-2021',null);
insert into contract values('CT-5','P-5','C-5','International Contractors Contract','no start date or cost',null,null,null,null);

commit;
select* from contract;

--Contract Manager

insert into contract_manager values('EM-1','CT-1','10-10-2015','15-11-2016');
insert into contract_manager values('EM-2','CT-2','16-04-2017','12-06-2019');
insert into contract_manager values('EM-3','CT-3','10-03-2021',null);
insert into contract_manager values('EM-4','CT-4','10-10-2014','05-01-2015');
insert into contract_manager values('EM-5','CT-5','18-03-2022',null);

commit;

select * from contract_manager;









------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Part C:

--1
--Purpose: Fitching ID and and names of all the roads that don't have subroads

select road_id, road_name
from roads
where subroad_id is null;

--2

--Purpose: Fitching the end location and the start location IDs and names of each road with the road's name


select s.start_id as"Start location ID",e.end_id as "End location ID", s.start_name as "Start location name",e.end_name as"End location name", r.road_name
from startlocation s,endlocation e, roads r
where s.start_id=r.start_id
and e.end_id=r.end_id;

--3

--Purpose: Fitching each road's name and id that has subroad and its name and id

select r.road_name,r.road_id,s.road_name as "Subroad name",s.road_id as "Subroad ID"
from roads r, roads s
where r.subroad_id=s.road_id;

--4: Fitching employees names and ids that have  been into the role of contract manager

select e.first_name||' '|| e.last_name as"Employee's Name",e.employee_id
from contract_manager c, arc_employees e

where e.employee_id=c.employee_id;

--5 : showing the rounded to the closeset int number of actual cost of contracts in descinding order, showing the each of the contract's id, name and the project name that is
--associated with

select c.contract_id,contract_name,p.project_name,concat(round(c.contract_act_cost,0),' M$') as "Actual Cost"

from contract c,project p

where c.project_code=p.project_code
 and c.contract_act_cost is not null
 
 order by c.contract_act_cost desc;
 
 --6 : Showing the lengh of each road the to closeset int number in Kilometers, showing the roads names, category and the code of each project that is associated with 
 
 select r.road_id,r.road_name,r.road_categ as"Road Category",concat(round(r.road_length,0),' Km'),p.project_code
 from roads r, project_road pr, project p
 
 where r.road_id=pr.road_id 
 and p.project_code=pr.project_code;


--7: Showing the hire date of the employees in the format of :MM-DD-YYYY in ascending order alongside with their Full names and emails:

select e.first_name||' '|| e.last_name as" Full name" ,nvl(e.email,'No email found'), to_char(e.hire_date,'MM DD YYYY') as" Hire date"
from arc_employees e

order by e.hire_date;

--8 Showing each project code and name with its contract's manager full name and id:

select p.project_code,p.project_name,e.employee_id,e.first_name||' '||e.last_name as "Manager Full Name"

from project p, contract c, contract_manager m, arc_employees e

where e.employee_id=m.employee_id
and c.contract_id=m.contract_id
and c.project_code=p.project_code;

--9 Showing each project's code and name and each contractor company's name and email that is responsible for that projcet.

select p.project_code,p.project_name,c.company_name,c.company_email

from company c, project p, contract ct

where p.project_code=ct.project_code
and ct.company_id=c.company_id;

--10 Showing each project's name that worked on a road that is Main Road Category and where each of these roads start and end location. This is also showing the road name

select p.project_name, r.road_name,s.start_id,e.end_id, s.start_name as"Start location Name",e.end_name as"End location Name"

from project p, project_road pr,roads r, startlocation s,endlocation e

where p.project_code=pr.project_code
and r.road_id=pr.road_id
and r.start_id=s.start_id
and r.end_id=e.end_id
and r.road_categ='Main Road';






 
 




























































































