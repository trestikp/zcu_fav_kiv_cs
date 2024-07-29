create table if not exists `user` (
    `id` binary(16) default (uuid_to_bin(uuid())) not null,
    `name` varchar(128),
    `email_address` varchar(256),
    `role` varchar(2) default 'R',
    `username` varchar(128) not null,
    `password` binary(60) not null,
    `github` boolean default false,

    primary key (`id`),
    constraint `UC_email` unique (`email_address`),
    constraint `UC_username` unique (`username`, `github`)
);

create table if not exists `stand` (
    `id` binary(16) default (uuid_to_bin(uuid())) not null,
    `name` varchar(128),
    `latitude` decimal(8, 5),
    `longitude` decimal(8, 5),

    primary key (`id`)
);

create table if not exists `bike` (
    `id` binary(16) default (uuid_to_bin(uuid())) not null,
    `latitude` decimal(8, 5),
    `longitude` decimal(8, 5),
    `last_service_timestamp` datetime,
    `stand_id` binary(16),

    primary key (`id`),
    foreign key (`stand_id`) references `stand` (`id`)
);

create table if not exists `ride` (
    `id` binary(16) default (uuid_to_bin(uuid())) not null,
    `state` varchar(2),
    `user_id` binary(16),
    `bike_id` binary(16),
    `start_stand_id` binary(16),
    `end_stand_id` binary(16),
    `start_timestamp` datetime,
    `end_timestamp` datetime,

    primary key (`id`),
    foreign key (`user_id`) references `user` (`id`),
    foreign key (`bike_id`) references `bike` (`id`),
    foreign key (`start_stand_id`) references `stand` (`id`),
    foreign key (`end_stand_id`) references `stand` (`id`)
);
