insert into Client
value (default,'client_1',0);

insert into Client
value (default, 'client_2',100);

insert into cheque
value(default,10);

insert into cheque
value(default,100);

insert into deposit_asso
value(1,2);
insert into deposit_asso
value(2,2);

insert into deposit_state
values ("ready"),("deposited"),("validated"),("validatedByDir"),("canceled"),("verified"),("saved");

update deposit_asso set state="deposited" where cheque_id=1;
update deposit_asso set state="validated" where cheque_id=2;

insert into c_operations
value('op_deposit');
insert into c_operations
value('op_validate');
insert into c_operations
value('op_validate_dir');
insert into c_operations
value('op_cancel');
insert into c_operations
value('op_verify');
insert into c_operations
value('op_save');

insert into c_roles
value('TellerRole');
insert into c_roles
value('CounsellorRole');
insert into c_roles
value('DirectorRole');

insert into c_permissions
value('TellerRole','op_validate');
insert into c_permissions
value('TellerRole','op_deposit');
insert into c_permissions
value('TellerRole','op_cancel');
insert into c_permissions
value('TellerRole','op_save');
insert into c_permissions
value('CounsellorRole','op_deposit');
insert into c_permissions
value('CounsellorRole','op_verify');
insert into c_permissions
value('CounsellorRole','op_save');
insert into c_permissions
value('DirectorRole','op_validate_dir');
insert into c_permissions
value('DirectorRole','op_cancel');

update permissions
set role=3
where id_perm=5 and title_perm='DirectorPerm';

update permissions
set role=2
where id_perm=6 and title_perm='CounsellorPerm';

insert into c_users
values ('Bob',''), ('Paul',''),('Martin',''),('Jack','');

insert into user_role
value(default,'Bob','DirectorRole');
insert into user_role
value(default,'Paul','TellerRole');
insert into user_role
value(default,'Martin','CounsellorRole');
insert into user_role
value(default,'Jack','TellerRole');
insert into user_role
value(default,'Jack','CounsellorRole');

insert into actions_history
value(1,'op_deposit',3,NOW());
insert into actions_history
value(1,'op_validate',5,NOW());

delete from deposit_state where state_title='canceled'