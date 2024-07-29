-- script used to populate the database with some "test" data (also "production" data as far as this project goes)
-- using constant randomly pre-generated UUIDs to manually create valid relations

-- stands - can only be directly inserted - no exposed API for creation
INSERT INTO `stand` (`id`, `name`, `latitude`, `longitude`) VALUES
(UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9'), 'Fakulta aplikovaných věd ZČU', 49.726810, 13.352828),
(UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495'), 'Plaza', 49.748874, 13.369169),
(UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8'), 'Zoologická a botanická zahrada Plzeň', 49.757670, 13.360088),
(UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e'), 'Lidl Studentská Plzeň', 49.773507, 13.348804),
(UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9'), 'Severka', 49.776147, 13.3677467),
(UUID_TO_BIN('7fd3ed6c-af56-4044-9f61-19f941ebfc56'), 'Fakultní nemocnice Lochotín', 49.764076, 13.379227),
(UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51'), 'Obchodní centrum Rokycanská', 49.745767, 13.435595),
(UUID_TO_BIN('3ae4fc4e-ca80-457a-9867-8e01dbf3591f'), 'Olympia', 49.700584, 13.427190),
(UUID_TO_BIN('758c7c22-5e05-4b1b-ba49-fadc141cad3a'), 'Hlavní vlakové nádraží', 49.743037, 13.387317),
(UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6'), 'Školy Vejprnická', 49.742232, 13.333626);

-- test users to verify basic functionality, password for both user is "test123" hashed using bcrypt
insert into `user` (`id`, `name`, `email_address`, `role`, `username`, `password`) values
(UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), 'Test Regular', 'test@test.cz', 'R', 'test', '$2a$10$LeDNUrffZA55ILR/MBEIqu3rDtd41J3J.T4TmjMR62uI8E5lw28Cu'),
(UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), 'Test Serviceman', 'test2@test.cz', 'S', 'test2', '$2a$10$LeDNUrffZA55ILR/MBEIqu3rDtd41J3J.T4TmjMR62uI8E5lw28Cu');

-- bikes - each stands has 5 bikes at the beginning, location is intialized as 0 for simpler copying, because the bikes have the same location as the stand
insert into `bike` (`id`, `latitude`, `longitude`, `last_service_timestamp`, `stand_id`) values
-- stand 1 (FAV)
(UUID_TO_BIN('f87f00dc-0c9d-438d-9bb2-dbe30d48473f'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('bd36bd25-bdb7-4cd6-807f-470ed1ae596b'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('1952c6fa-e1cd-4af2-bab2-b67262789464'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('159eaf00-69ff-4a4f-9daf-f03eea38365e'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('d0459d09-f63f-425e-a6fc-9d419a5db28d'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('48b290d6-3d12-431b-8203-4f5a11476f39'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('5c656925-fd5e-42f6-89c4-dc7996e2ded2'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
(UUID_TO_BIN('79eea88b-a39b-4e42-bce2-a7fcd67c37ca'), 00.000000, 00.000000, now(), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9')),
-- stand 2 (Plaza)
(UUID_TO_BIN('0e4773c6-01f2-45df-8475-cce53b3226e6'), 00.000000, 00.000000, now(), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495')),
(UUID_TO_BIN('9479f35d-2b49-4851-aa0d-3727ab5d3c7b'), 00.000000, 00.000000, now(), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495')),
-- stand 3 (Zoo)
(UUID_TO_BIN('9a6ab101-b9f9-4020-a6bf-b89f881eaabf'), 00.000000, 00.000000, now(), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8')),
(UUID_TO_BIN('5c2166b9-b046-437d-bce7-318a809708c1'), 00.000000, 00.000000, now(), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8')),
(UUID_TO_BIN('c37c257c-7875-4884-ace7-4a5984ec9a32'), 00.000000, 00.000000, now(), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8')),
(UUID_TO_BIN('2d9b0c1f-a29c-4606-9eee-b7bb8637d4e0'), 00.000000, 00.000000, now(), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8')),
(UUID_TO_BIN('c68b179b-74ff-4cfc-84ab-be6b9e6ea475'), 00.000000, 00.000000, now(), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8')),
-- stand 4 (Lidl)
(UUID_TO_BIN('25f7952c-892e-48c4-9f44-22f815596424'), 00.000000, 00.000000, now(), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e')),
(UUID_TO_BIN('8d1ce425-a827-44df-ad9b-bc7b35e1e87d'), 00.000000, 00.000000, now(), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e')),
(UUID_TO_BIN('21ff7fc5-d6f8-42c6-b362-5a18cf052250'), 00.000000, 00.000000, now(), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e')),
-- stand 5 (Severka)
(UUID_TO_BIN('80d41f32-e2e2-46f9-802f-6c4c47287c22'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('9ebafbe1-e5b6-4103-a536-7ec9d9d95e2a'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('3edd1f01-b25a-4adf-8b66-7afdd50c9db1'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('13393b14-a424-4d1a-92fb-a12f72cceb21'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('bd5dc579-7573-4e6f-9b83-9dadc5432cdb'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('0506a2ca-2052-413d-bf6f-637f793a23f5'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
(UUID_TO_BIN('8617e9e1-1113-4a61-bcd4-d9f47d22f89d'), 00.000000, 00.000000, now(), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9')),
-- stand 6 (FN Lochotín)
(UUID_TO_BIN('a2182581-55a1-4083-85d5-587f345c5e3b'), 00.000000, 00.000000, now(), UUID_TO_BIN('7fd3ed6c-af56-4044-9f61-19f941ebfc56')),
(UUID_TO_BIN('9f1521ab-bbbc-45f5-9ca3-f2d0c53ff9d8'), 00.000000, 00.000000, now(), UUID_TO_BIN('7fd3ed6c-af56-4044-9f61-19f941ebfc56')),
-- stand 7 (OC Rokycanská)
(UUID_TO_BIN('ab5c4094-a154-4ce0-8c6c-d1f20890a5fb'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('df0a90de-8df6-4e91-8b62-35542cb8d770'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('63914b80-3db9-4960-b4ac-148ef21969ea'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('904ca07c-3cbd-43d8-bd96-56a6d054c0f5'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('60fd4cd9-716e-454c-94a3-0c2a90783c19'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('13228a6d-eced-4585-bb42-6f5a67c02250'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('b656d935-c251-4f5e-8f76-c919ae25f9b5'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('85845203-24a6-40c5-af0b-fc7989f12810'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('e6542563-58d3-4fc3-ad6e-ba887ebb442e'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('d46a9ac0-cddc-43a5-8a1c-8f995772629c'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
(UUID_TO_BIN('b893a357-e264-4003-a0fb-bba297719ff0'), 00.000000, 00.000000, now(), UUID_TO_BIN('ef894e4d-0494-4311-8033-5f6458cbba51')),
-- stand 8 (Olympia)
(UUID_TO_BIN('7ccb2682-3325-481a-aaa5-cc85ce1f3ec2'), 00.000000, 00.000000, now(), UUID_TO_BIN('3ae4fc4e-ca80-457a-9867-8e01dbf3591f')),
(UUID_TO_BIN('36eb945b-08a3-4924-a9d4-901e5203b9ee'), 00.000000, 00.000000, now(), UUID_TO_BIN('3ae4fc4e-ca80-457a-9867-8e01dbf3591f')),
-- stand 9 (Hlavní nádraží)
-- intentionally 0 to test empty stands
-- stand 10 (Školy Vejprnická)
(UUID_TO_BIN('8b04a205-d028-416f-9c5b-07320f0b3223'), 00.000000, 00.000000, '2020-01-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')), -- due for service
(UUID_TO_BIN('205e0061-77d8-400a-8e1e-cd9208025985'), 00.000000, 00.000000, '2021-01-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')), -- due for service
(UUID_TO_BIN('b4eaee92-dadc-4a77-9b16-939f1e965e9e'), 00.000000, 00.000000, '2022-01-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')), -- due for service
(UUID_TO_BIN('aa612641-f996-4d97-a772-18f552399efa'), 00.000000, 00.000000, '2023-01-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')), -- due for service
(UUID_TO_BIN('73fe59a3-b780-44e4-9b36-377a20959c5b'), 00.000000, 00.000000, '2024-01-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')),
(UUID_TO_BIN('7facd468-fb55-4cc4-b011-d9fe2f0bfb9e'), 00.000000, 00.000000, '2023-12-30 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')),
(UUID_TO_BIN('dbb7a023-2ed3-405d-ad3e-37d3f605632f'), 00.000000, 00.000000, '2023-12-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')),
(UUID_TO_BIN('bbc1dbe5-1bcb-4068-85ed-9f5307d05b8a'), 00.000000, 00.000000, '2023-11-15 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')),
(UUID_TO_BIN('0d52286d-5cc4-47b8-9267-86722814a02e'), 00.000000, 00.000000, '2023-11-01 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6')), -- due for service
(UUID_TO_BIN('df09caa2-47a8-4793-938b-2e7d6997b55b'), 00.000000, 00.000000, '2023-11-09 00:00:00', UUID_TO_BIN('20b351df-5e7b-414c-864d-6931dbbb00c6'));

-- ride - give test user a few rides finished to test API/ frontend
insert into `ride` (`id`, `state`, `user_id`, `bike_id`, `start_stand_id`, `end_stand_id`, `start_timestamp`, `end_timestamp`) values
-- regular users rides
(UUID_TO_BIN('0c10baef-51f4-4536-b399-39555c33edec'), 'C', UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), UUID_TO_BIN('f87f00dc-0c9d-438d-9bb2-dbe30d48473f'), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9'), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495'), '2020-01-01 00:00:00', '2020-01-01 00:10:00'),
(UUID_TO_BIN('fa15aadc-18a3-47f0-85e0-459415c0e4e0'), 'C', UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), UUID_TO_BIN('48b290d6-3d12-431b-8203-4f5a11476f39'), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495'), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8'), '2020-01-01 01:00:00', '2020-01-01 01:15:00'),
(UUID_TO_BIN('a6a9a2a1-a598-45c4-a5e2-71cfe5355ee0'), 'C', UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), UUID_TO_BIN('9a6ab101-b9f9-4020-a6bf-b89f881eaabf'), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8'), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e'), '2020-01-01 01:30:00', '2020-01-01 01:50:00'),
(UUID_TO_BIN('9098ff17-c2ae-4077-bb80-bf18f0e99b67'), 'C', UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), UUID_TO_BIN('25f7952c-892e-48c4-9f44-22f815596424'), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e'), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9'), '2020-01-01 06:30:00', '2020-01-01 07:47:00'),
(UUID_TO_BIN('7a540826-cc16-416d-8e4d-6ef3b9ebe116'), 'C', UUID_TO_BIN('1f765210-ea29-4924-b64f-d11a2805272b'), UUID_TO_BIN('3edd1f01-b25a-4adf-8b66-7afdd50c9db1'), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9'), UUID_TO_BIN('7fd3ed6c-af56-4044-9f61-19f941ebfc56'), '2020-01-01 08:23:00', '2020-01-01 08:39:00'),
-- servicmans rides (same as regular users due to laziness)
(UUID_TO_BIN('e8bfc004-eb9a-4ba8-9eae-e4fd2e0504b0'), 'C', UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), UUID_TO_BIN('f87f00dc-0c9d-438d-9bb2-dbe30d48473f'), UUID_TO_BIN('6f8c9667-3fe1-40a3-8749-a1724668f8f9'), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495'), '2020-01-01 00:00:00', '2020-01-01 00:10:00'),
(UUID_TO_BIN('c4cf1563-054b-49be-a23a-85f3c4aaaaba'), 'C', UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), UUID_TO_BIN('48b290d6-3d12-431b-8203-4f5a11476f39'), UUID_TO_BIN('ae606033-9e96-4f38-b836-dbebd09a0495'), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8'), '2020-01-01 01:00:00', '2020-01-01 01:15:00'),
(UUID_TO_BIN('cfca4f42-0cee-4594-b97e-12babaf00d56'), 'C', UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), UUID_TO_BIN('9a6ab101-b9f9-4020-a6bf-b89f881eaabf'), UUID_TO_BIN('41d89659-bddb-4cce-832b-b552cac301f8'), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e'), '2020-01-01 01:30:00', '2020-01-01 01:50:00'),
(UUID_TO_BIN('4ca1f1e8-cf7a-439a-afea-e645d369adb6'), 'C', UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), UUID_TO_BIN('25f7952c-892e-48c4-9f44-22f815596424'), UUID_TO_BIN('8d8b59d7-876d-41a2-bb20-52b18ee8f02e'), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9'), '2020-01-01 06:30:00', '2020-01-01 07:47:00'),
(UUID_TO_BIN('16444312-2465-418c-b32a-233cead0db72'), 'C', UUID_TO_BIN('43545b4f-dc5b-4e14-aa74-46c9350fdcdc'), UUID_TO_BIN('3edd1f01-b25a-4adf-8b66-7afdd50c9db1'), UUID_TO_BIN('adb63509-4d18-4d11-99a3-d5891f2506c9'), UUID_TO_BIN('7fd3ed6c-af56-4044-9f61-19f941ebfc56'), '2020-01-01 08:23:00', '2020-01-01 08:39:00');
