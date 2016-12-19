drop database chequedeposit06oct15;
create database chequedeposit06oct15;
use chequedeposit06Oct15;

#-------------------------------------------------------------------------------------------
#---------------------------------Functional translation-------------------------------------
#-------------------------------------------------------------------------------------------
drop table cheques;

create table cheques(
cheque_id int not null auto_increment,
primary key(cheque_id)
);

create table clients(
client_id int not null auto_increment,
primary key(client_id)
);

drop table deposits;
create table deposits(
deposit_id int not null auto_increment,
deposit_cheque int not null,
deposit_client int not null,
deposit_status int not null,
primary key(deposit_id),
foreign key(deposit_cheque) references cheques(cheque_id),
foreign key(deposit_client) references clients(client_id),
foreign key(deposit_status) references depositstatus(depositstatus_id)
);

create table deposits(
deposit_id int not null auto_increment,
deposit_cheque int not null,
deposit_client int not null,
deposit_status varchar(255) not null,
primary key(deposit_id),
foreign key(deposit_cheque) references cheques(cheque_id),
foreign key(deposit_client) references clients(client_id),
foreign key(deposit_status) references depositstatus(status_title)
);



drop table depositstatus;
create table depositstatus(
depositstatus_id int not null auto_increment,
status_title varchar(255) not null,
primary key(depositstatus_id)
);

create table depositstatus(
status_title varchar(255) not null primary key);
#-------------------------------------------------------------------------------------------
#---------------------------------SecureUML translation-------------------------------------
#-------------------------------------------------------------------------------------------

# Translate enum sets to tables
drop table secureuml_users;

create table secureuml_users(
user_id int not null auto_increment,
user_name varchar(255) not null,
primary key(user_id) );

create table secureuml_users(
user_name varchar(255) not null,
primary key(user_name) );


drop table secureuml_roles;
create table secureuml_roles(
role_id int not null auto_increment,
role_title varchar(255) not null,
primary key(role_id) );

create table secureuml_roles(
role_title varchar(255) not null,
primary key(role_title) );


drop table secureuml_operations;

create table secureuml_operations(
operation_id int not null auto_increment,
operation_label varchar(255) not null,
primary key(operation_id) );

create table secureuml_operations(
operation_title varchar(255) not null,
primary key(operation_title) );

# Translate variables in form Var : Var1 <-> Var2 to tables with two foreign keys of Var1 and Var2
drop table secureuml_permissions;

create table secureuml_permissions(

permission_id int not null auto_increment,
permission_role int not null,
permission_operation int not null,
primary key(permission_id),
foreign key(permission_role) references secureuml_roles(role_id),
foreign key(permission_operation) references secureuml_operations(operation_id));

create table secureuml_permissions(
permission_role varchar(255) not null,
permission_operation varchar(255) not null,
primary key(permission_role, permission_operation),
foreign key(permission_role) references secureuml_roles(role_title),
foreign key(permission_operation) references secureuml_operations(operation_title));


drop table secureuml_permittedusersroles;

create table secureuml_permittedusersroles(
userrole_id int not null auto_increment,
userrole_role int not null,
userrole_user int not null,
primary key(userrole_id),
foreign key(userrole_role) references secureuml_roles(role_id),
foreign key(userrole_user) references secureuml_users(user_id));

create table secureuml_ua(
ua_user varchar(255) not null,
ua_role varchar(255) not null,
primary key(ua_user, ua_role),
foreign key(ua_role) references secureuml_roles(role_title),
foreign key(ua_user) references secureuml_users(user_name));



drop table secureuml_session;
create table secureuml_session(
session_user int not null primary key,
session_role int not null
);

create table secureuml_session(
session_user  varchar(255) not null primary key,
session_role  varchar(255) not null,
foreign key(session_role) references secureuml_roles(role_title),
foreign key(session_user) references secureuml_users(user_name)
);
#-------------------------------------------------------------------------------------------
#---------------------------------AD translation-------------------------------------
#-------------------------------------------------------------------------------------------
drop table ad_actionshistory;

create table ad_actionshistory(
actionhistory_id int not null auto_increment,
actionhistory_operation varchar(255) not null,
actionhistory_cheque int,
actionhistory_client int,
actionhistory_deposit int,
actionhistory_user varchar(255),
actionhistory_time int not null,
primary key(actionhistory_id),
foreign key(actionhistory_operation) references secureuml_operations(operation_title),
foreign key(actionhistory_cheque) references cheques(cheque_id),
foreign key(actionhistory_client) references clients(client_id),
foreign key(actionhistory_deposit) references deposits(deposit_id),
foreign key(actionhistory_user) references secureuml_session(session_user));