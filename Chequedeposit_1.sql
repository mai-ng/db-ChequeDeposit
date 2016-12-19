drop database chequedeposit;
create database ChequeDeposit;
use chequedeposit;

create table client(
id_client int not null auto_increment,
name varchar(255),
amount int not null,
primary key(id_client)
);

create table cheque(
id_cheque int not null auto_increment,
value_cheque int not null,
primary key(id_cheque)
);

#one_one relation between Deposit and Cheque tables.
#take primary key of Cheque table to be the primary key of Deposit table.
drop table Deposit;

create table Deposit_Asso(
cheque_id int not null,
client_id int not null,
primary key(cheque_id),
foreign key(cheque_id) references cheque(id_cheque),
foreign key(client_id) references client(id_client)
);

create table Deposit_State(
state_title varchar(255) not null,
primary key(state_title)
);

alter table deposit_asso
#add column state varchar(255);
add foreign key(state) references deposit_state(state_title);
#RBAC_MODEL
drop table c_roles;

CREATE table c_roles(
role_title varchar(255) not null,
primary key(role_title)
);

drop table c_operations;

create table c_operations(
op_title varchar(255) not null,
primary key(op_title)
);

drop table c_users;

create table c_users(
user_name varchar(255) not null,
user_pws varchar(255),
primary key(user_name)
);

create table user_role(
userrole_id int not null auto_increment,
user varchar(255) not null,
role varchar(255) not null,
primary key(userrole_id),
foreign key(user) references c_users(user_name),
foreign key(role) references c_roles(role_title)
);

drop table c_permissions;

create table c_permissions(
c_role varchar(255) not null,
c_op varchar(255) not null,
primary key(c_role,c_op),
foreign key(c_role) references c_roles(role_title),
foreign key(c_op) references c_operations(op_title)
);

#AD_MODEL
drop table actions_history;
create table acchequechequetions_history(
deposit_id int not null,
c_op varchar(255) not null,
user_role_id int  not null,
executed_time datetime not null,
primary key(deposit_id,c_op),
foreign key(deposit_id) references deposit_asso(cheque_id),
foreign key(user_role_id) references user_role(userrole_id),
foreign key(c_op) references c_operations(op_title)
);
