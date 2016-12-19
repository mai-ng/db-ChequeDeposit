
#provide permission/privileges to user whose name = 'root' and password='root'
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;


#---------------------------READ--------------------------------------
select * from depositstatus;
select * from cheques;
select * from clients;
select * from deposits;

select * from secureuml_users;
select * from secureuml_roles;
select * from secureuml_operations;
select * from secureuml_permissions;
select * from secureuml_session;

SELECT EXISTS(
         SELECT *
         FROM clients
         WHERE client_id = 3);

select deposit_status from deposits where deposit_cheque=1 and deposit_client=1;

select session_role from secureuml_session where session_user = 1;

#-----Check if the user whose 'user_id = 4' has a permission to execute 'permission_operation=1'
#-----with his connecting role (He must be connecting or must exists in 'secureuml_session' table)
 SELECT EXISTS( SELECT *  FROM secureuml_permissions 
 JOIN secureuml_session 
	ON secureuml_session.session_role = secureuml_permissions.permission_role
JOIN secureuml_users 
	ON secureuml_users.user_id = secureuml_session.session_user
 WHERE user_id = 4 AND permission_operation=1);
 
 
#----List all connecting users (user_id, user_name) 
#----who have the right to execute operation_label = 'Deposit__validate_Label'
select user_id, user_name, operation_label, operation_id from secureuml_users
join secureuml_session on
	user_id = session_user
join secureuml_permissions on
	session_role = permission_role 
join secureuml_operations
    on permission_operation = operation_id
where operation_label = 'Deposit__validate_Label';

#-----------List the deposit (deposit_id) from cheque_id and client_id as the inputs 
select deposit_id from deposits
join cheques on deposit_cheque = cheque_id 
join clients on deposit_client = client_id
where cheque_id = 1 and client_id =1;

#-----------List the last record from the table Deposits--------------
select max(deposit_id) from deposits;

insert into ad_actionshistory values();

SELECT session_role FROM secureuml_session WHERE session_user = 'Tom';




SELECT actionhistory_user FROM ad_actionshistory 
	WHERE actionhistory_operation="Deposit__validate_Label"   AND actionhistory_deposit = 3;
                
#----------------------delete records---------------------------------------

delete from depositstatus where depositstatus_id=4;



#---------------------------reset tables--------------------------------------
truncate  cheques;
truncate clients;
truncate deposits;
truncate depositstatus;

alter table depositstatus
alter status_title set default "created";
#---------------------------Insert records--------------------------------------
/*
insert into depositstatus(status_title)
values ('created'), ('validated'), ('saved');
*/
insert into cheques values (1), (11), (111);
insert into clients values (1), (10), (20);
insert into depositstatus values ("created"), ("validated"), ("saved");
insert into deposits(deposit_cheque, deposit_client, deposit_status) values (1,10,"created"), (11, 1, default);


#------------RBAC data---------------------------------------
insert into secureuml_users(user_name)
values ('Bob'), ('Tom'), ('Jack'), ('Martin');


insert into secureuml_roles(role_title)
values ('Director'), ('Teller'), ('Advisor');

insert into secureuml_operations(operation_title)
values ('Deposit__validate_Label'), ('Deposit__save_Label');

insert into secureuml_permissions(permission_role, permission_operation)
values ('Advisor','Deposit__save_Label'), ('Director','Deposit__save_Label'), 
('Teller','Deposit__validate_Label'), ('Director','Deposit__validate_Label');

insert into secureuml_ua(ua_user, ua_role)
values ('Tom','Director'), ('Bob', 'Advisor'), ('Jack', 'Advisor'), ('Martin','Teller');

insert into secureuml_session(session_user, session_role)
values ('Tom','Director'), ('Bob', 'Advisor');