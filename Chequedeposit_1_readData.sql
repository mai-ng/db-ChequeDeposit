
select current_user;

select * from c_permissions;
#truncate custom_permissions;
select * from c_roles;

select * from client;

select * from cheque;

select * from deposit_asso;
select * from deposit_state;

select * from c_users;
select * from user_role;

SELECT role FROM user_role WHERE user='Jack';

#truncate custom_users;

select * from c_operations;

select * from actions_history;

#display user name whose role is TellerRole
select name_user,title_role from users,roles
where title_role='TellerRole' and user_role=id_role;

#display user name whose role is TellerRole, anh their permission
select title_role,title_op from roles,operations,permissions
where title_role='TellerRole' 
and role = id_role and operations=id_op;

#select all title_role can execute op_deposit
select title_role, title_op from roles,operations,permissions
where title_op='op_deposit' and role=id_role and operations=id_op;

#find user whose role is 'DirectorRole'
select name_user from custom_users
inner join custom_roles
 on custom_users.role_id = custom_roles.id_role 
where custom_roles.title_role='DirectorRole';

#find users who have right to 'op_validate_dir': expected 'bob'
select name_user from custom_users, secure_operations
inner join custom_permissions
on secure_operations.id_op = custom_permissions.op_id
inner join custom_roles
on custom_permissions.role_id = custom_roles.id_role
where secure_operations.title_op='op_validate_dir'
and custom_users.role_id = custom_roles.id_role;

#find roles can execute operations
select title_role, title_op from custom_roles,secure_operations
join custom_permissions
on secure_operations.id_op=custom_permissions.op_id
where custom_roles.id_role=custom_permissions.role_id
#group by title_role
order by title_role;

#find all usrs can perform 'op_validate_dir'
select user_name from c_users
join c_roles on user_role=role_title
join c_permissions on role_title=c_role
join c_operations on op_title=c_op
where op_title='op_validate_dir';

#find all op that 'Paul' can perform with his role as 'TellerRole'
select op_title from c_operations
join c_permissions on op_title=c_op
join c_roles on c_role=role_title
join c_users on role_title=user_role
where user_name='Paul' and user_role='TellerRole';

#find the user who performed op_deposit of the deposit_id = 1
select user from user_role
join actions_history on userrole_id=user_role_id
join deposit_asso on cheque_id=deposit_id
where c_op='op_deposit' and deposit_id=1;