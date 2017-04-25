\c airline

delete from airport;
delete from plane_type;
delete from airplane;
delete from flight;
delete from employee;
delete from can_land;
delete from flight_leg;
delete from leg_instance;
delete from fare;
delete from reservation;
delete from passenger;


create table airport(
		airport_code varchar(10) primary key,
		name varchar(20) not NULL,
		city varchar(20),
		state varchar(20),
		country varchar(20) not NULL
		);		
insert into airport values ('ABC001', 'AIIR HJHBD', 'Mumbai', 'Maharashtra', 'India');
insert into airport values ('XYZ002', 'X YYYY ZZZ', 'ycity', 'xstate', 'zcountry');
insert into airport values ('ASD003', 'aaa sss dddd', 'asterisk', '', 'Alphabet');
insert into airport values ('HTW001', 'Heathrow', 'London', '', 'England');
insert into airport values ('KIA001', 'Kempegowda International', 'Bangalore', 'Karn', 'India');


create table plane_type(
		company varchar(20),
		airplane_type varchar(20) primary key,
		max_seats int,
		fuel_type varchar(10)
		);
insert into plane_type values ('Boeing', 'spassenger', '300', 'Jet A-1');
insert into plane_type values ('Airbus', 'lpassenger', '800', 'Jet A-1');
insert into plane_type values ('Airbus', '2seater', '2', 'Jet A-1');
insert into plane_type values ('Boeing', 'fjet', '50', 'Jet A');
insert into plane_type values ('Airbus', 'ljet', '25', 'Jet A');


create table airplane(
		airplane_id varchar(20) primary key,
		total_seats int,
		airplane_type varchar(20), 
		foreign key(airplane_type) references plane_type on delete cascade
		);

insert into airplane values ('P1', '275', 'spassenger');/*reserving some seats*/
insert into airplane values ('P2', '275', 'spassenger');
insert into airplane values ('P3', '675', 'lpassenger');
insert into airplane values ('J1', '30', 'fjet');
insert into airplane values ('J2', '25', 'ljet');



create table flight(
		flight_number varchar(20) primary key, 
		working_day varchar(20)
		);

insert into flight values ('00FLFJQW01', 'Monday');
insert into flight values ('00FLSJXY03', 'Saturday');
insert into flight values ('00FLLPQW08', 'Friday');
insert into flight values ('00FLSPQW11', 'Sunday');
insert into flight values ('00FLSJQW02', 'Tuesday');



create table employee(
		e_id varchar(20),
		name varchar(40),
		sex varchar(10),
		dob date,
		flight_id varchar(20),
		foreign key(flight_id) references flight(flight_number) on delete cascade,
		primary key(e_id,flight_id)
		);
insert into employee values ('287900CX', 'Aot', 'M', '1987-02-28', '00FLSJXY03');
insert into employee values ('887141AP', 'Bot', 'F', '1992-01-31', '00FLLPQW08');
insert into employee values ('613129FR', 'Cot', 'M', '1995-06-14', '00FLLPQW08');
insert into employee values ('314116FA', 'Dot', 'F', '1983-12-11', '00FLSJXY03');
insert into employee values ('831245AH', 'Eot', 'F', '1987-02-17', '00FLFJQW01');



create table can_land(
		airport_code varchar(10) , 
		airplane_type varchar(20) , 
		foreign key(airport_code) references airport on delete cascade , 
		foreign key(airplane_type) references plane_type on delete cascade ,
		primary key(airport_code , airplane_type)
		);
insert into can_land values ('ABC001', '2seater');
insert into can_land values ('XYZ002', 'fjet');
insert into can_land values ('ASD003', 'ljet');
insert into can_land values ('HTW001', 'lpassenger');
insert into can_land values ('KIA001', 'lpassenger');


create table flight_leg(
		flight_number varchar(20) ,
		leg_no varchar(5) not NULL unique ,
		departure_airport_code varchar(10) ,
		scheduled_departure_time varchar(20) , 
		arrival_airport_code varchar(10) , 
		scheduled_arrival_time varchar(20) ,
		foreign key(arrival_airport_code) references airport(airport_code) on delete cascade ,
		foreign key(departure_airport_code) references airport(airport_code) on delete cascade, 
		foreign key(flight_number) references flight(flight_number) on delete cascade, 
		primary key(flight_number,leg_no,departure_airport_code,arrival_airport_code)
		);
insert into flight_leg values ('00FLFJQW01', '3', 'ABC001', '12:00:00 am', 'HTW001', '03:15:00 pm');
insert into flight_leg values ('00FLLPQW08', '4', 'XYZ002', '07:00:00 pm', 'XYZ002', '10:30:00 pm');
insert into flight_leg values ('00FLSJQW02', '5', 'ASD003', '04:00:00 pm', 'HTW001', '02:00:00 am');
insert into flight_leg values ('00FLFJQW01', '2', 'KIA001', '03:00:00 am', 'ASD003', '05:00:00 am');
insert into flight_leg values ('00FLSJQW02', '1', 'KIA001', '04:30:00 pm', 'ABC001', '05:30:00 pm');



create table leg_instance(
		flight_number varchar(15) not NULL , 
		leg_no varchar(5) not NULL , 
		ldate date not NULL unique, 
		no_of_available_seats int,  
		airplane_id varchar(20) ,
		departure_time varchar(20) , 
		departure_airport_code varchar(10) , 
		arrival_airport_code varchar(10)  , 
		arrival_time varchar(20) ,
		foreign key(airplane_id) references airplane(airplane_id) on delete cascade ,
		foreign key(leg_no) references flight_leg(leg_no) on delete cascade,
		foreign key(flight_number) references flight(flight_number) on delete cascade,
		foreign key(arrival_airport_code) references airport(airport_code) on delete cascade ,
		foreign key(departure_airport_code) references airport(airport_code) on delete cascade, 
		primary key(flight_number,leg_no,ldate,airplane_id,departure_airport_code,arrival_airport_code)
		);

insert into leg_instance values ('A', 'M', '8', '0', '8', '50');
insert into leg_instance values ('A', 'M', '8', '0', '8', '50');
insert into leg_instance values ('A', 'M', '8', '0', '8', '50');
insert into leg_instance values ('A', 'M', '8', '0', '8', '50');
insert into leg_instance values ('A', 'M', '8', '0', '8', '50');




create table fare(
		flight_number varchar(20) , 
		fare_code varchar(15) not NULL, 
		amount numeric(9,2) check(amount>0),
		foreign key(flight_number) references flight(flight_number) on delete cascade,
		primary key(flight_number,fare_code)
		);
insert into fare values ('00FLFJQW01', 'FLFabc002', '5000.00');
insert into fare values ('00FLSJXY03', 'FLFjhy003', '12000.00');
insert into fare values ('00FLSJQW02', 'FLFwag001', '87000.00');
insert into fare values ('00FLLPQW08', 'FLFdxd006', '31000.00');
insert into fare values ('00FLSJQW02', 'FLFdrt001', '8000.00');




create table reservation(
		p_id int ,
		seat_number varchar(10) ,
		flight_number varchar(20) ,
		leg_no varchar(5) not NULL,
		departure_airport_code varchar(10) ,
		arrival_airport_code varchar(10) , 
		ldate date not NULL ,
		foreign key(leg_no) references flight_leg(leg_no) on delete cascade,
		foreign key(ldate) references leg_instance(ldate) on delete cascade,
		foreign key(arrival_airport_code) references airport(airport_code) on delete cascade ,
		foreign key(departure_airport_code) references airport(airport_code) on delete cascade, 
		foreign key(flight_number) references flight(flight_number) on delete cascade, 
		primary key(p_id,seat_number,ldate,flight_number,leg_no,
			departure_airport_code,arrival_airport_code)
		);
insert into reservation values ('0011231298','A', 'M', '8', '0', '8', '50');
insert into reservation values ('0013456211','A', 'M', '8', '0', '8', '50');
insert into reservation values ('0023937830','A', 'M', '8', '0', '8', '50');
insert into reservation values ('0012211981','A', 'M', '8', '0', '8', '50');
insert into reservation values ('0047621120','A', 'M', '8', '0', '8', '50');



create table passenger(
		p_id int ,
		age int;
		sex char;
		seat_number varchar(10) ,
		p_name varchar(40) , 
		mobile varchar(20)  ,
		email varchar(30) ,
		primary key(p_id , seat_number)
		);
insert into passenger values ('0011231298','12','M', '19B', 'abc', '919234156708', 'abc@gmail.com');
insert into passenger values ('0013456211','56','F', '1A', 'aQc', '729234156708', 'aQc@gmail.com');
insert into passenger values ('0023937830','60','M', '6C', 'xstc', '811237156708', 'xstc@gmail.com');
insert into passenger values ('0012211981','4','F', '34D', 'xyq', '949234156708', 'xyq@gmail.com');
insert into passenger values ('0047621120','52','F' '12A', 'xyz', '939982535608', 'xyz@gmail.com');
select p.p_id,p.p_name from passenger as p ,reservation as r where p.age>50 and p.p_id=r.p_id and p.sex='F'; 