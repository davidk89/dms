-- Adminer 4.8.1 PostgreSQL 12.15 dump
CREATE SCHEMA IF NOT EXISTS keycloak;
CREATE SCHEMA IF NOT EXISTS dms_departments;
SET search_path TO keycloak;

DROP TABLE IF EXISTS "admin_event_entity";
CREATE TABLE "keycloak"."admin_event_entity" (
    "id" character varying(36) NOT NULL,
    "admin_event_time" bigint,
    "realm_id" character varying(255),
    "operation_type" character varying(255),
    "auth_realm_id" character varying(255),
    "auth_client_id" character varying(255),
    "auth_user_id" character varying(255),
    "ip_address" character varying(255),
    "resource_path" character varying(2550),
    "representation" text,
    "error" character varying(255),
    "resource_type" character varying(64),
    CONSTRAINT "constraint_admin_event_entity" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_admin_event_time" ON "keycloak"."admin_event_entity" USING btree ("realm_id", "admin_event_time");


DROP TABLE IF EXISTS "associated_policy";
CREATE TABLE "keycloak"."associated_policy" (
    "policy_id" character varying(36) NOT NULL,
    "associated_policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrpap" PRIMARY KEY ("policy_id", "associated_policy_id")
) WITH (oids = false);

CREATE INDEX "idx_assoc_pol_assoc_pol_id" ON "keycloak"."associated_policy" USING btree ("associated_policy_id");

INSERT INTO "associated_policy" ("policy_id", "associated_policy_id") VALUES
('42bce6be-b35f-4cc5-b8d7-7f788c13d621',	'538fb3fe-b812-444d-ac4b-ef6919b90546');

DROP TABLE IF EXISTS "authentication_execution";
CREATE TABLE "keycloak"."authentication_execution" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "authenticator" character varying(36),
    "realm_id" character varying(36),
    "flow_id" character varying(36),
    "requirement" integer,
    "priority" integer,
    "authenticator_flow" boolean DEFAULT false NOT NULL,
    "auth_flow_id" character varying(36),
    "auth_config" character varying(36),
    CONSTRAINT "constraint_auth_exec_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_exec_flow" ON "keycloak"."authentication_execution" USING btree ("flow_id");

CREATE INDEX "idx_auth_exec_realm_flow" ON "keycloak"."authentication_execution" USING btree ("realm_id", "flow_id");

INSERT INTO "authentication_execution" ("id", "alias", "authenticator", "realm_id", "flow_id", "requirement", "priority", "authenticator_flow", "auth_flow_id", "auth_config") VALUES
('76928a04-c711-47bd-8ceb-40e2b0c2701e',	NULL,	'auth-cookie',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80786489-3b12-4d31-9a7a-88fb7adcdc8a',	2,	10,	'f',	NULL,	NULL),
('635202dd-3d96-4d9f-8c6e-6e96fda423ca',	NULL,	'auth-spnego',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80786489-3b12-4d31-9a7a-88fb7adcdc8a',	3,	20,	'f',	NULL,	NULL),
('a48a97b0-91f1-462f-b458-ceeadd2a9bc8',	NULL,	'identity-provider-redirector',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80786489-3b12-4d31-9a7a-88fb7adcdc8a',	2,	25,	'f',	NULL,	NULL),
('a41dda78-547d-4b2f-ae6e-37535d4223e4',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80786489-3b12-4d31-9a7a-88fb7adcdc8a',	2,	30,	't',	'58260af7-6a5c-4585-9486-6f138a8e223e',	NULL),
('780c3a4e-a8f8-424e-a34d-eba1ed35cd45',	NULL,	'auth-username-password-form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'58260af7-6a5c-4585-9486-6f138a8e223e',	0,	10,	'f',	NULL,	NULL),
('2be7aa7d-0668-49c2-8f61-1c54bd6dc934',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'58260af7-6a5c-4585-9486-6f138a8e223e',	1,	20,	't',	'9290c3e3-8f5b-4dfe-8728-79500182404b',	NULL),
('94e6b24e-6298-4ee9-b534-8542645caa68',	NULL,	'conditional-user-configured',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9290c3e3-8f5b-4dfe-8728-79500182404b',	0,	10,	'f',	NULL,	NULL),
('65e65297-b250-463c-8e92-d1edcd135c66',	NULL,	'auth-otp-form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9290c3e3-8f5b-4dfe-8728-79500182404b',	0,	20,	'f',	NULL,	NULL),
('de9913ce-113f-4ccf-acdd-d878ea27ac2b',	NULL,	'direct-grant-validate-username',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'81c2cd16-064f-4d87-8680-688c9aaac6af',	0,	10,	'f',	NULL,	NULL),
('25eac902-a58c-43e9-81e3-8876f081f2bd',	NULL,	'direct-grant-validate-password',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'81c2cd16-064f-4d87-8680-688c9aaac6af',	0,	20,	'f',	NULL,	NULL),
('25a9a7cb-cf5d-44b1-ac6e-a029b2d99879',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'81c2cd16-064f-4d87-8680-688c9aaac6af',	1,	30,	't',	'6d58ec22-4116-4a3d-ae8c-4681ab18405a',	NULL),
('a7f480dd-cec1-41ce-aaa3-fb293272e678',	NULL,	'conditional-user-configured',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'6d58ec22-4116-4a3d-ae8c-4681ab18405a',	0,	10,	'f',	NULL,	NULL),
('bc6feac8-5c43-43e7-9e36-e54720e3ec10',	NULL,	'direct-grant-validate-otp',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'6d58ec22-4116-4a3d-ae8c-4681ab18405a',	0,	20,	'f',	NULL,	NULL),
('31a732a2-3bad-47de-b328-6bfb534b8c01',	NULL,	'registration-page-form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ab39e9b2-b081-42c0-8dc2-da59862558a2',	0,	10,	't',	'9835d559-c4dc-47f2-8661-f9dcb96570bc',	NULL),
('957ea9ef-d405-44e4-941f-b2f20833500e',	NULL,	'registration-user-creation',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9835d559-c4dc-47f2-8661-f9dcb96570bc',	0,	20,	'f',	NULL,	NULL),
('87006164-62c1-4e23-bf85-f557570b375d',	NULL,	'registration-profile-action',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9835d559-c4dc-47f2-8661-f9dcb96570bc',	0,	40,	'f',	NULL,	NULL),
('80386d40-9faa-4ceb-bc1e-46da6bbf205d',	NULL,	'registration-password-action',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9835d559-c4dc-47f2-8661-f9dcb96570bc',	0,	50,	'f',	NULL,	NULL),
('9f79f3c1-d3c8-4cae-ba10-b5aae6b451d2',	NULL,	'registration-recaptcha-action',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'9835d559-c4dc-47f2-8661-f9dcb96570bc',	3,	60,	'f',	NULL,	NULL),
('59ed8697-7ad1-4ade-a21d-72c4c95fa534',	NULL,	'reset-credentials-choose-user',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f1c25adc-d3dd-4222-8543-af350b2825da',	0,	10,	'f',	NULL,	NULL),
('d534b33c-a9b7-4090-ac59-76a2ee500455',	NULL,	'reset-credential-email',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f1c25adc-d3dd-4222-8543-af350b2825da',	0,	20,	'f',	NULL,	NULL),
('b02f4429-c137-4e51-b09a-002d46bc1479',	NULL,	'reset-password',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f1c25adc-d3dd-4222-8543-af350b2825da',	0,	30,	'f',	NULL,	NULL),
('f6245395-3993-4500-be7f-19eba74c9b73',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f1c25adc-d3dd-4222-8543-af350b2825da',	1,	40,	't',	'8706f5c6-b1c5-47f4-8552-eea8f0c12f53',	NULL),
('674e3fbe-ade5-4a5d-bc95-ad4a76b4118d',	NULL,	'conditional-user-configured',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'8706f5c6-b1c5-47f4-8552-eea8f0c12f53',	0,	10,	'f',	NULL,	NULL),
('f0b4f9fd-07e3-4b7d-befc-3aeccf1a6a9a',	NULL,	'reset-otp',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'8706f5c6-b1c5-47f4-8552-eea8f0c12f53',	0,	20,	'f',	NULL,	NULL),
('d360a960-d663-4f4e-aaae-553689e2c025',	NULL,	'client-secret',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'0ef5166a-cb91-4072-b90b-b4e070a87563',	2,	10,	'f',	NULL,	NULL),
('50be03a8-aa95-4c95-9a4e-b58a5849b5ce',	NULL,	'client-jwt',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'0ef5166a-cb91-4072-b90b-b4e070a87563',	2,	20,	'f',	NULL,	NULL),
('5b3a7bf6-e865-4b33-bb03-c3a67e420fbc',	NULL,	'client-secret-jwt',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'0ef5166a-cb91-4072-b90b-b4e070a87563',	2,	30,	'f',	NULL,	NULL),
('7878cf0c-5c0f-4687-80a6-b2a5b1d3427c',	NULL,	'client-x509',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'0ef5166a-cb91-4072-b90b-b4e070a87563',	2,	40,	'f',	NULL,	NULL),
('78e1dc4f-13d2-4b83-9940-1f596f7fc8de',	NULL,	'idp-review-profile',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'8f39ad49-d360-40f6-966d-eeb49e24ef8a',	0,	10,	'f',	NULL,	'2ba2a41f-385c-47cf-91b2-ebd65f757d78'),
('27fada4f-6bef-42d2-9c8a-c909712b89d9',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'8f39ad49-d360-40f6-966d-eeb49e24ef8a',	0,	20,	't',	'def5b5c4-5c73-40f1-b7be-d978038522c6',	NULL),
('93434edf-66c7-42a4-97da-9b9aaec39145',	NULL,	'idp-create-user-if-unique',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'def5b5c4-5c73-40f1-b7be-d978038522c6',	2,	10,	'f',	NULL,	'9d4b4969-2e48-4938-aeec-7c68e211cc04'),
('43ba5fec-c786-4629-b3b5-f20beb492428',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'def5b5c4-5c73-40f1-b7be-d978038522c6',	2,	20,	't',	'610615a6-a329-417b-b346-cbb2fec40f1b',	NULL),
('a56d24d2-6a7b-4572-aafb-d0d98a3398a6',	NULL,	'idp-confirm-link',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'610615a6-a329-417b-b346-cbb2fec40f1b',	0,	10,	'f',	NULL,	NULL),
('630ec234-02db-463e-b787-d48b18e78aa7',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'610615a6-a329-417b-b346-cbb2fec40f1b',	0,	20,	't',	'6e309720-d991-4263-ab13-ec05f4f99c2a',	NULL),
('dfbd0db1-950a-4ca0-adf8-be2a8917a577',	NULL,	'idp-email-verification',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'6e309720-d991-4263-ab13-ec05f4f99c2a',	2,	10,	'f',	NULL,	NULL),
('86af75a7-ebe5-4fa9-8a15-f57f81d91175',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'6e309720-d991-4263-ab13-ec05f4f99c2a',	2,	20,	't',	'a349bb97-390c-48d8-9b24-3042388100e1',	NULL),
('2037f5d5-2ec8-4463-8ad4-88f39413e4a7',	NULL,	'idp-username-password-form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a349bb97-390c-48d8-9b24-3042388100e1',	0,	10,	'f',	NULL,	NULL),
('3ada5dcd-32f0-4d80-a184-77ec3db73133',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a349bb97-390c-48d8-9b24-3042388100e1',	1,	20,	't',	'a11956f9-1eaa-4479-873d-e31512a03fa4',	NULL),
('c2219ddc-3027-471a-9ee1-63c5a650300f',	NULL,	'conditional-user-configured',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a11956f9-1eaa-4479-873d-e31512a03fa4',	0,	10,	'f',	NULL,	NULL),
('c34b61d7-69cd-4b52-996a-77bf2486140b',	NULL,	'auth-otp-form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a11956f9-1eaa-4479-873d-e31512a03fa4',	0,	20,	'f',	NULL,	NULL),
('feeabb61-819a-42c4-8507-aadb937b1e42',	NULL,	'http-basic-authenticator',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'd6d28c95-af0e-4b18-a129-e65ca806d969',	0,	10,	'f',	NULL,	NULL),
('132bc8be-b9c0-4863-abdf-b1fde04d0115',	NULL,	'docker-http-basic-authenticator',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'af6f290f-e174-4d32-a101-ea9dce0e306d',	0,	10,	'f',	NULL,	NULL),
('60e50d0b-7f74-467e-b5d3-8c61045539aa',	NULL,	'no-cookie-redirect',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f6732220-9497-4441-a495-5ec1df5c7fa2',	0,	10,	'f',	NULL,	NULL),
('29207901-5248-4d95-90f8-7d63996baff0',	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f6732220-9497-4441-a495-5ec1df5c7fa2',	0,	20,	't',	'a8cad9f4-7e39-42eb-aa2c-d2aa53bddf0b',	NULL),
('734ef3bf-4c53-4206-bc35-441f805c198c',	NULL,	'basic-auth',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a8cad9f4-7e39-42eb-aa2c-d2aa53bddf0b',	0,	10,	'f',	NULL,	NULL),
('1c5253fb-9f10-4155-9122-6a4443aaac0a',	NULL,	'basic-auth-otp',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a8cad9f4-7e39-42eb-aa2c-d2aa53bddf0b',	3,	20,	'f',	NULL,	NULL),
('ab1cea57-a6e2-4955-b559-98d77011cee3',	NULL,	'auth-spnego',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'a8cad9f4-7e39-42eb-aa2c-d2aa53bddf0b',	3,	30,	'f',	NULL,	NULL),
('b19f12bf-52f3-43ea-bc97-b6e06d042e86',	NULL,	'auth-cookie',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'100423f7-fd72-45ba-859e-a99d43615e99',	2,	10,	'f',	NULL,	NULL),
('e2c80f0a-8d3e-483a-a94c-65f794a7151c',	NULL,	'auth-spnego',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'100423f7-fd72-45ba-859e-a99d43615e99',	3,	20,	'f',	NULL,	NULL),
('52e3ffd7-8404-4eb5-a5fe-4d04c55b74a1',	NULL,	'identity-provider-redirector',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'100423f7-fd72-45ba-859e-a99d43615e99',	2,	25,	'f',	NULL,	NULL),
('829f683d-d950-4962-8cd3-aad51e3155b0',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'100423f7-fd72-45ba-859e-a99d43615e99',	2,	30,	't',	'bac60d1c-700b-435e-8b3f-476d9c0f460c',	NULL),
('16ac3f9b-60f4-487b-9203-c9c6ce9f9f78',	NULL,	'auth-username-password-form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'bac60d1c-700b-435e-8b3f-476d9c0f460c',	0,	10,	'f',	NULL,	NULL),
('c62d21b6-0662-4b47-83eb-e3eb46f5dda8',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'bac60d1c-700b-435e-8b3f-476d9c0f460c',	1,	20,	't',	'3bcdf1ef-8ff6-4c0b-b731-1e5cf3aca970',	NULL),
('acfa7cf4-34eb-42b3-8ab3-a3be47a4a3c4',	NULL,	'conditional-user-configured',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'3bcdf1ef-8ff6-4c0b-b731-1e5cf3aca970',	0,	10,	'f',	NULL,	NULL),
('c24436e4-80f6-4acb-97dc-79592788df74',	NULL,	'auth-otp-form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'3bcdf1ef-8ff6-4c0b-b731-1e5cf3aca970',	0,	20,	'f',	NULL,	NULL),
('c5f89482-9ae4-44b7-a635-234d65769f86',	NULL,	'direct-grant-validate-username',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0ef8713a-6476-4e51-a5c8-a25a42e9963a',	0,	10,	'f',	NULL,	NULL),
('6120ad5e-111e-4c58-976f-2962527295d1',	NULL,	'direct-grant-validate-password',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0ef8713a-6476-4e51-a5c8-a25a42e9963a',	0,	20,	'f',	NULL,	NULL),
('727ca435-ca66-4420-b7a5-2553c34358fe',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0ef8713a-6476-4e51-a5c8-a25a42e9963a',	1,	30,	't',	'961cab95-57d8-42e5-95bb-044d021e5bab',	NULL),
('9d8e0ac9-079b-4022-806f-11fb572850f2',	NULL,	'conditional-user-configured',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'961cab95-57d8-42e5-95bb-044d021e5bab',	0,	10,	'f',	NULL,	NULL),
('3938c5d5-5d88-45c8-b3b6-e9c063e94a78',	NULL,	'direct-grant-validate-otp',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'961cab95-57d8-42e5-95bb-044d021e5bab',	0,	20,	'f',	NULL,	NULL),
('be9eee07-cc6c-40a4-951a-cd572072bda4',	NULL,	'registration-page-form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0737f2a5-3cf4-40f9-864f-fd60b32e5064',	0,	10,	't',	'f6137cbc-aa07-4860-adb4-8fa892849252',	NULL),
('4d0679eb-1fc7-48da-878d-698c7e699d55',	NULL,	'registration-user-creation',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f6137cbc-aa07-4860-adb4-8fa892849252',	0,	20,	'f',	NULL,	NULL),
('036cfd9e-acf3-4d0a-ba70-5b2824e2de82',	NULL,	'registration-profile-action',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f6137cbc-aa07-4860-adb4-8fa892849252',	0,	40,	'f',	NULL,	NULL),
('df734981-397d-4a26-9d89-d86029df439a',	NULL,	'registration-password-action',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f6137cbc-aa07-4860-adb4-8fa892849252',	0,	50,	'f',	NULL,	NULL),
('786d786b-35bf-449d-b2b8-63fd04d98e31',	NULL,	'registration-recaptcha-action',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f6137cbc-aa07-4860-adb4-8fa892849252',	3,	60,	'f',	NULL,	NULL),
('916cea56-a176-4b55-bb30-0b9d564ab867',	NULL,	'reset-credentials-choose-user',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	0,	10,	'f',	NULL,	NULL),
('94ebaaea-3a2e-4174-a21b-9a77484dd227',	NULL,	'reset-credential-email',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	0,	20,	'f',	NULL,	NULL),
('65181086-d758-4b33-b08e-33811132e427',	NULL,	'reset-password',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	0,	30,	'f',	NULL,	NULL),
('c2b6a725-4b78-48db-b6a8-c4147c7fb56a',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	1,	40,	't',	'4f888f77-7e82-40f2-9b9e-bb88d843c23b',	NULL),
('c2cd42a1-ee98-457c-9e0b-6277caa465f0',	NULL,	'conditional-user-configured',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'4f888f77-7e82-40f2-9b9e-bb88d843c23b',	0,	10,	'f',	NULL,	NULL),
('5be9184f-577c-4336-b61b-66bffb0a4253',	NULL,	'reset-otp',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'4f888f77-7e82-40f2-9b9e-bb88d843c23b',	0,	20,	'f',	NULL,	NULL),
('009aaa7d-8dd3-4824-8200-f1752bd2f5c4',	NULL,	'client-secret',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	2,	10,	'f',	NULL,	NULL),
('1a5e657a-731c-4f1e-b5aa-e336395557e1',	NULL,	'client-jwt',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	2,	20,	'f',	NULL,	NULL),
('397cef71-8254-4443-b617-c0dce01cefa7',	NULL,	'client-secret-jwt',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	2,	30,	'f',	NULL,	NULL),
('87be42a6-3b13-45d8-8f9f-85207c9c4abf',	NULL,	'client-x509',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	2,	40,	'f',	NULL,	NULL),
('98fd2837-f0e9-466a-829c-7632d8a1fac8',	NULL,	'idp-review-profile',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'e5d97416-91ce-48a6-ab21-664919ad6b59',	0,	10,	'f',	NULL,	'1cd17f5d-8b7a-41d4-a74a-40e18d514b7d'),
('0e4b992d-8ea0-4245-a2bd-5418877a4583',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'e5d97416-91ce-48a6-ab21-664919ad6b59',	0,	20,	't',	'4a64a70a-25d9-454d-9f3e-399a18b6aeee',	NULL),
('e92e6b86-3cbf-4c56-9e02-a515865a80f8',	NULL,	'idp-create-user-if-unique',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'4a64a70a-25d9-454d-9f3e-399a18b6aeee',	2,	10,	'f',	NULL,	'0f92c5f9-fbbe-49d4-80f5-99568c1e0e95'),
('14bc8b73-c479-4852-826f-22b85f9fd2f4',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'4a64a70a-25d9-454d-9f3e-399a18b6aeee',	2,	20,	't',	'5dc49ef4-81de-4320-ba6b-009ec881984c',	NULL),
('f254d92f-08c1-446c-bad1-3bd6077489bd',	NULL,	'idp-confirm-link',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5dc49ef4-81de-4320-ba6b-009ec881984c',	0,	10,	'f',	NULL,	NULL),
('07e14a3f-8400-4191-816d-4ad0bd5439f8',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5dc49ef4-81de-4320-ba6b-009ec881984c',	0,	20,	't',	'b5d6f8b1-0f14-453d-9711-79356eec73a5',	NULL),
('c51ef464-382b-4566-9543-17732eba386b',	NULL,	'idp-email-verification',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'b5d6f8b1-0f14-453d-9711-79356eec73a5',	2,	10,	'f',	NULL,	NULL),
('91170186-a77e-4b84-b1db-a947444186cb',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'b5d6f8b1-0f14-453d-9711-79356eec73a5',	2,	20,	't',	'a54ad2dc-5775-40e5-9653-ab0d778573d1',	NULL),
('cab4c939-bad3-4749-b94d-e20ab2fe1825',	NULL,	'idp-username-password-form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a54ad2dc-5775-40e5-9653-ab0d778573d1',	0,	10,	'f',	NULL,	NULL),
('5cf7147a-ce30-4dd7-aa6a-35c690089dbb',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'a54ad2dc-5775-40e5-9653-ab0d778573d1',	1,	20,	't',	'1f001a8e-6724-4c6e-9146-5bd9199fed0c',	NULL),
('e32e2e88-f065-4914-aa03-6990934035aa',	NULL,	'conditional-user-configured',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'1f001a8e-6724-4c6e-9146-5bd9199fed0c',	0,	10,	'f',	NULL,	NULL),
('3bb10977-fa16-4313-898a-42bd7888a201',	NULL,	'auth-otp-form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'1f001a8e-6724-4c6e-9146-5bd9199fed0c',	0,	20,	'f',	NULL,	NULL),
('29ecd24c-8c41-42d5-850e-12be8996ec0a',	NULL,	'http-basic-authenticator',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'133fc081-f949-478f-a0ee-f8886f0b1f1f',	0,	10,	'f',	NULL,	NULL),
('f7b2b8af-39a8-44c1-9b39-c5966c5f6d88',	NULL,	'docker-http-basic-authenticator',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'fb0a420f-e73a-4ea1-8e86-1cc9a61c35ce',	0,	10,	'f',	NULL,	NULL),
('3338c32f-5074-4015-aff5-1b6dbc3a504c',	NULL,	'no-cookie-redirect',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'3036b048-cb35-4f04-a8fa-e8d936321b26',	0,	10,	'f',	NULL,	NULL),
('d1a63aaa-6fb7-4c76-8dad-93b441f03f2f',	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'3036b048-cb35-4f04-a8fa-e8d936321b26',	0,	20,	't',	'addd2db2-d7b8-4ed2-a2f7-3dbbcce8b42e',	NULL),
('8ec1e334-a938-4865-b854-d43e55b3b05d',	NULL,	'basic-auth',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'addd2db2-d7b8-4ed2-a2f7-3dbbcce8b42e',	0,	10,	'f',	NULL,	NULL),
('1aaa8cdd-eae1-42ae-ab7d-ba0297fb9679',	NULL,	'basic-auth-otp',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'addd2db2-d7b8-4ed2-a2f7-3dbbcce8b42e',	3,	20,	'f',	NULL,	NULL),
('c0f93be1-7f57-4e83-a9eb-be8e757e14d7',	NULL,	'auth-spnego',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'addd2db2-d7b8-4ed2-a2f7-3dbbcce8b42e',	3,	30,	'f',	NULL,	NULL);

DROP TABLE IF EXISTS "authentication_flow";
CREATE TABLE "keycloak"."authentication_flow" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "description" character varying(255),
    "realm_id" character varying(36),
    "provider_id" character varying(36) DEFAULT 'basic-flow' NOT NULL,
    "top_level" boolean DEFAULT false NOT NULL,
    "built_in" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_auth_flow_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_flow_realm" ON "keycloak"."authentication_flow" USING btree ("realm_id");

INSERT INTO "authentication_flow" ("id", "alias", "description", "realm_id", "provider_id", "top_level", "built_in") VALUES
('80786489-3b12-4d31-9a7a-88fb7adcdc8a',	'browser',	'browser based authentication',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('58260af7-6a5c-4585-9486-6f138a8e223e',	'forms',	'Username, password, otp and other auth forms.',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('9290c3e3-8f5b-4dfe-8728-79500182404b',	'Browser - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('81c2cd16-064f-4d87-8680-688c9aaac6af',	'direct grant',	'OpenID Connect Resource Owner Grant',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('6d58ec22-4116-4a3d-ae8c-4681ab18405a',	'Direct Grant - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('ab39e9b2-b081-42c0-8dc2-da59862558a2',	'registration',	'registration flow',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('9835d559-c4dc-47f2-8661-f9dcb96570bc',	'registration form',	'registration form',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'form-flow',	'f',	't'),
('f1c25adc-d3dd-4222-8543-af350b2825da',	'reset credentials',	'Reset credentials for a user if they forgot their password or something',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('8706f5c6-b1c5-47f4-8552-eea8f0c12f53',	'Reset - Conditional OTP',	'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('0ef5166a-cb91-4072-b90b-b4e070a87563',	'clients',	'Base authentication for clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'client-flow',	't',	't'),
('8f39ad49-d360-40f6-966d-eeb49e24ef8a',	'first broker login',	'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('def5b5c4-5c73-40f1-b7be-d978038522c6',	'User creation or linking',	'Flow for the existing/non-existing user alternatives',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('610615a6-a329-417b-b346-cbb2fec40f1b',	'Handle Existing Account',	'Handle what to do if there is existing account with same email/username like authenticated identity provider',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('6e309720-d991-4263-ab13-ec05f4f99c2a',	'Account verification options',	'Method with which to verity the existing account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('a349bb97-390c-48d8-9b24-3042388100e1',	'Verify Existing Account by Re-authentication',	'Reauthentication of existing account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('a11956f9-1eaa-4479-873d-e31512a03fa4',	'First broker login - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('d6d28c95-af0e-4b18-a129-e65ca806d969',	'saml ecp',	'SAML ECP Profile Authentication Flow',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('af6f290f-e174-4d32-a101-ea9dce0e306d',	'docker auth',	'Used by Docker clients to authenticate against the IDP',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('f6732220-9497-4441-a495-5ec1df5c7fa2',	'http challenge',	'An authentication flow based on challenge-response HTTP Authentication Schemes',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	't',	't'),
('a8cad9f4-7e39-42eb-aa2c-d2aa53bddf0b',	'Authentication Options',	'Authentication options.',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'basic-flow',	'f',	't'),
('100423f7-fd72-45ba-859e-a99d43615e99',	'browser',	'browser based authentication',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('bac60d1c-700b-435e-8b3f-476d9c0f460c',	'forms',	'Username, password, otp and other auth forms.',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('3bcdf1ef-8ff6-4c0b-b731-1e5cf3aca970',	'Browser - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('0ef8713a-6476-4e51-a5c8-a25a42e9963a',	'direct grant',	'OpenID Connect Resource Owner Grant',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('961cab95-57d8-42e5-95bb-044d021e5bab',	'Direct Grant - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('0737f2a5-3cf4-40f9-864f-fd60b32e5064',	'registration',	'registration flow',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('f6137cbc-aa07-4860-adb4-8fa892849252',	'registration form',	'registration form',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'form-flow',	'f',	't'),
('c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	'reset credentials',	'Reset credentials for a user if they forgot their password or something',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('4f888f77-7e82-40f2-9b9e-bb88d843c23b',	'Reset - Conditional OTP',	'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	'clients',	'Base authentication for clients',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'client-flow',	't',	't'),
('e5d97416-91ce-48a6-ab21-664919ad6b59',	'first broker login',	'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('4a64a70a-25d9-454d-9f3e-399a18b6aeee',	'User creation or linking',	'Flow for the existing/non-existing user alternatives',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('5dc49ef4-81de-4320-ba6b-009ec881984c',	'Handle Existing Account',	'Handle what to do if there is existing account with same email/username like authenticated identity provider',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('b5d6f8b1-0f14-453d-9711-79356eec73a5',	'Account verification options',	'Method with which to verity the existing account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('a54ad2dc-5775-40e5-9653-ab0d778573d1',	'Verify Existing Account by Re-authentication',	'Reauthentication of existing account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('1f001a8e-6724-4c6e-9146-5bd9199fed0c',	'First broker login - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't'),
('133fc081-f949-478f-a0ee-f8886f0b1f1f',	'saml ecp',	'SAML ECP Profile Authentication Flow',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('fb0a420f-e73a-4ea1-8e86-1cc9a61c35ce',	'docker auth',	'Used by Docker clients to authenticate against the IDP',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('3036b048-cb35-4f04-a8fa-e8d936321b26',	'http challenge',	'An authentication flow based on challenge-response HTTP Authentication Schemes',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	't',	't'),
('addd2db2-d7b8-4ed2-a2f7-3dbbcce8b42e',	'Authentication Options',	'Authentication options.',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'basic-flow',	'f',	't');

DROP TABLE IF EXISTS "authenticator_config";
CREATE TABLE "keycloak"."authenticator_config" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "realm_id" character varying(36),
    CONSTRAINT "constraint_auth_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_config_realm" ON "keycloak"."authenticator_config" USING btree ("realm_id");

INSERT INTO "authenticator_config" ("id", "alias", "realm_id") VALUES
('2ba2a41f-385c-47cf-91b2-ebd65f757d78',	'review profile config',	'3be8f8be-092a-45c6-9bd9-e059158830c8'),
('9d4b4969-2e48-4938-aeec-7c68e211cc04',	'create unique user config',	'3be8f8be-092a-45c6-9bd9-e059158830c8'),
('1cd17f5d-8b7a-41d4-a74a-40e18d514b7d',	'review profile config',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0'),
('0f92c5f9-fbbe-49d4-80f5-99568c1e0e95',	'create unique user config',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0');

DROP TABLE IF EXISTS "authenticator_config_entry";
CREATE TABLE "keycloak"."authenticator_config_entry" (
    "authenticator_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_auth_cfg_pk" PRIMARY KEY ("authenticator_id", "name")
) WITH (oids = false);

INSERT INTO "authenticator_config_entry" ("authenticator_id", "value", "name") VALUES
('2ba2a41f-385c-47cf-91b2-ebd65f757d78',	'missing',	'update.profile.on.first.login'),
('9d4b4969-2e48-4938-aeec-7c68e211cc04',	'false',	'require.password.update.after.registration'),
('0f92c5f9-fbbe-49d4-80f5-99568c1e0e95',	'false',	'require.password.update.after.registration'),
('1cd17f5d-8b7a-41d4-a74a-40e18d514b7d',	'missing',	'update.profile.on.first.login');

DROP TABLE IF EXISTS "broker_link";
CREATE TABLE "keycloak"."broker_link" (
    "identity_provider" character varying(255) NOT NULL,
    "storage_provider_id" character varying(255),
    "realm_id" character varying(36) NOT NULL,
    "broker_user_id" character varying(255),
    "broker_username" character varying(255),
    "token" text,
    "user_id" character varying(255) NOT NULL,
    CONSTRAINT "constr_broker_link_pk" PRIMARY KEY ("identity_provider", "user_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "client";
CREATE TABLE "keycloak"."client" (
    "id" character varying(36) NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "full_scope_allowed" boolean DEFAULT false NOT NULL,
    "client_id" character varying(255),
    "not_before" integer,
    "public_client" boolean DEFAULT false NOT NULL,
    "secret" character varying(255),
    "base_url" character varying(255),
    "bearer_only" boolean DEFAULT false NOT NULL,
    "management_url" character varying(255),
    "surrogate_auth_required" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36),
    "protocol" character varying(255),
    "node_rereg_timeout" integer DEFAULT '0',
    "frontchannel_logout" boolean DEFAULT false NOT NULL,
    "consent_required" boolean DEFAULT false NOT NULL,
    "name" character varying(255),
    "service_accounts_enabled" boolean DEFAULT false NOT NULL,
    "client_authenticator_type" character varying(255),
    "root_url" character varying(255),
    "description" character varying(255),
    "registration_token" character varying(255),
    "standard_flow_enabled" boolean DEFAULT true NOT NULL,
    "implicit_flow_enabled" boolean DEFAULT false NOT NULL,
    "direct_access_grants_enabled" boolean DEFAULT false NOT NULL,
    "always_display_in_console" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_7" PRIMARY KEY ("id"),
    CONSTRAINT "uk_b71cjlbenv945rb6gcon438at" UNIQUE ("realm_id", "client_id")
) WITH (oids = false);

CREATE INDEX "idx_client_id" ON "keycloak"."client" USING btree ("client_id");

INSERT INTO "client" ("id", "enabled", "full_scope_allowed", "client_id", "not_before", "public_client", "secret", "base_url", "bearer_only", "management_url", "surrogate_auth_required", "realm_id", "protocol", "node_rereg_timeout", "frontchannel_logout", "consent_required", "name", "service_accounts_enabled", "client_authenticator_type", "root_url", "description", "registration_token", "standard_flow_enabled", "implicit_flow_enabled", "direct_access_grants_enabled", "always_display_in_console") VALUES
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'f',	'master-realm',	0,	'f',	NULL,	NULL,	't',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	0,	'f',	'f',	'master Realm',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('80f861e8-0c85-49f3-be78-6cf002723609',	't',	'f',	'account',	0,	't',	NULL,	'/realms/master/account/',	'f',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'openid-connect',	0,	'f',	'f',	'${client_account}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	't',	'f',	'account-console',	0,	't',	NULL,	'/realms/master/account/',	'f',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'openid-connect',	0,	'f',	'f',	'${client_account-console}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	't',	'f',	'broker',	0,	'f',	NULL,	NULL,	't',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'openid-connect',	0,	'f',	'f',	'${client_broker}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	't',	'f',	'security-admin-console',	0,	't',	NULL,	'/admin/master/console/',	'f',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'openid-connect',	0,	'f',	'f',	'${client_security-admin-console}',	'f',	'client-secret',	'${authAdminUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	't',	'f',	'admin-cli',	0,	't',	NULL,	NULL,	'f',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'openid-connect',	0,	'f',	'f',	'${client_admin-cli}',	'f',	'client-secret',	NULL,	NULL,	NULL,	'f',	'f',	't',	'f'),
('fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'f',	'dms-realm',	0,	'f',	NULL,	NULL,	't',	NULL,	'f',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	0,	'f',	'f',	'dms Realm',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'f',	'realm-management',	0,	'f',	NULL,	NULL,	't',	NULL,	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_realm-management}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'f',	'account',	0,	't',	NULL,	'/realms/dms/account/',	'f',	NULL,	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_account}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	't',	'f',	'account-console',	0,	't',	NULL,	'/realms/dms/account/',	'f',	NULL,	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_account-console}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	't',	'f',	'broker',	0,	'f',	NULL,	NULL,	't',	NULL,	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_broker}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	't',	'f',	'security-admin-console',	0,	't',	NULL,	'/admin/dms/console/',	'f',	NULL,	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_security-admin-console}',	'f',	'client-secret',	'${authAdminUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	't',	'f',	'admin-cli',	0,	'f',	'TXyNEnacrDSmCvmsIRbCDS1lBrKQ0GZw',	'',	'f',	'',	'f',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'openid-connect',	0,	'f',	'f',	'${client_admin-cli}',	't',	'client-secret',	'',	'',	NULL,	't',	'f',	't',	'f');

DROP TABLE IF EXISTS "client_attributes";
CREATE TABLE "keycloak"."client_attributes" (
    "client_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" text,
    CONSTRAINT "constraint_3c" PRIMARY KEY ("client_id", "name")
) WITH (oids = false);

INSERT INTO "client_attributes" ("client_id", "name", "value") VALUES
('80f861e8-0c85-49f3-be78-6cf002723609',	'post.logout.redirect.uris',	'+'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'post.logout.redirect.uris',	'+'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'pkce.code.challenge.method',	'S256'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'post.logout.redirect.uris',	'+'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'pkce.code.challenge.method',	'S256'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'post.logout.redirect.uris',	'+'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'post.logout.redirect.uris',	'+'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'pkce.code.challenge.method',	'S256'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'post.logout.redirect.uris',	'+'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'pkce.code.challenge.method',	'S256'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'oauth2.device.authorization.grant.enabled',	'false'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'oidc.ciba.grant.enabled',	'false'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'display.on.consent.screen',	'false'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'backchannel.logout.session.required',	'true'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'backchannel.logout.revoke.offline.tokens',	'false'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'client.secret.creation.time',	'1684610990');

DROP TABLE IF EXISTS "client_auth_flow_bindings";
CREATE TABLE "keycloak"."client_auth_flow_bindings" (
    "client_id" character varying(36) NOT NULL,
    "flow_id" character varying(36),
    "binding_name" character varying(255) NOT NULL,
    CONSTRAINT "c_cli_flow_bind" PRIMARY KEY ("client_id", "binding_name")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_initial_access";
CREATE TABLE "keycloak"."client_initial_access" (
    "id" character varying(36) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "timestamp" integer,
    "expiration" integer,
    "count" integer,
    "remaining_count" integer,
    CONSTRAINT "cnstr_client_init_acc_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_client_init_acc_realm" ON "keycloak"."client_initial_access" USING btree ("realm_id");


DROP TABLE IF EXISTS "client_node_registrations";
CREATE TABLE "keycloak"."client_node_registrations" (
    "client_id" character varying(36) NOT NULL,
    "value" integer,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_84" PRIMARY KEY ("client_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_scope";
CREATE TABLE "keycloak"."client_scope" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "realm_id" character varying(36),
    "description" character varying(255),
    "protocol" character varying(255),
    CONSTRAINT "pk_cli_template" PRIMARY KEY ("id"),
    CONSTRAINT "uk_cli_scope" UNIQUE ("realm_id", "name")
) WITH (oids = false);

CREATE INDEX "idx_realm_clscope" ON "keycloak"."client_scope" USING btree ("realm_id");

INSERT INTO "client_scope" ("id", "name", "realm_id", "description", "protocol") VALUES
('d872860d-41e8-477b-bed5-d9074f7d9bcf',	'offline_access',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect built-in scope: offline_access',	'openid-connect'),
('7bb15574-854f-404e-b15f-3b778c68616e',	'role_list',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'SAML role list',	'saml'),
('a94903d9-076e-47ce-b321-dfb303e90a4f',	'profile',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect built-in scope: profile',	'openid-connect'),
('b414de7d-0516-4817-a15c-3d0d80046c1c',	'email',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect built-in scope: email',	'openid-connect'),
('6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'address',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect built-in scope: address',	'openid-connect'),
('58606ebd-dae9-4c91-8407-1659830db5aa',	'phone',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect built-in scope: phone',	'openid-connect'),
('cee8ae8a-8f30-4c8f-9c45-c9870f228666',	'roles',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect scope for add user roles to the access token',	'openid-connect'),
('818940b0-0544-4719-a439-6f1e40719b3c',	'web-origins',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect scope for add allowed web origins to the access token',	'openid-connect'),
('8f1541ef-95d2-4588-a428-ce52ed44794a',	'microprofile-jwt',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'Microprofile - JWT built-in scope',	'openid-connect'),
('33f8c3bb-c72a-442c-a7cf-355d43a5f500',	'acr',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'OpenID Connect scope for add acr (authentication context class reference) to the token',	'openid-connect'),
('f35882c0-132b-4b49-88cc-ac79015b5c60',	'offline_access',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect built-in scope: offline_access',	'openid-connect'),
('38085e92-1c77-409d-b7f1-443fce561a67',	'role_list',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'SAML role list',	'saml'),
('37fe646b-2268-4cd0-9878-53c30f3a473a',	'profile',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect built-in scope: profile',	'openid-connect'),
('51040b64-31ef-4eb3-9c91-1ee4395d1243',	'email',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect built-in scope: email',	'openid-connect'),
('875c08ae-fd1a-458b-908f-d2a56c22a25f',	'address',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect built-in scope: address',	'openid-connect'),
('5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'phone',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect built-in scope: phone',	'openid-connect'),
('2dfcf2a6-0223-442b-9c69-005aee507e18',	'roles',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect scope for add user roles to the access token',	'openid-connect'),
('4362aabb-8316-456d-a4d1-e8d643297a35',	'web-origins',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect scope for add allowed web origins to the access token',	'openid-connect'),
('9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'microprofile-jwt',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'Microprofile - JWT built-in scope',	'openid-connect'),
('786ed661-6c0b-470a-81ce-b68146494182',	'acr',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'OpenID Connect scope for add acr (authentication context class reference) to the token',	'openid-connect');

DROP TABLE IF EXISTS "client_scope_attributes";
CREATE TABLE "keycloak"."client_scope_attributes" (
    "scope_id" character varying(36) NOT NULL,
    "value" character varying(2048),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "pk_cl_tmpl_attr" PRIMARY KEY ("scope_id", "name")
) WITH (oids = false);

CREATE INDEX "idx_clscope_attrs" ON "keycloak"."client_scope_attributes" USING btree ("scope_id");

INSERT INTO "client_scope_attributes" ("scope_id", "value", "name") VALUES
('d872860d-41e8-477b-bed5-d9074f7d9bcf',	'true',	'display.on.consent.screen'),
('d872860d-41e8-477b-bed5-d9074f7d9bcf',	'${offlineAccessScopeConsentText}',	'consent.screen.text'),
('7bb15574-854f-404e-b15f-3b778c68616e',	'true',	'display.on.consent.screen'),
('7bb15574-854f-404e-b15f-3b778c68616e',	'${samlRoleListScopeConsentText}',	'consent.screen.text'),
('a94903d9-076e-47ce-b321-dfb303e90a4f',	'true',	'display.on.consent.screen'),
('a94903d9-076e-47ce-b321-dfb303e90a4f',	'${profileScopeConsentText}',	'consent.screen.text'),
('a94903d9-076e-47ce-b321-dfb303e90a4f',	'true',	'include.in.token.scope'),
('b414de7d-0516-4817-a15c-3d0d80046c1c',	'true',	'display.on.consent.screen'),
('b414de7d-0516-4817-a15c-3d0d80046c1c',	'${emailScopeConsentText}',	'consent.screen.text'),
('b414de7d-0516-4817-a15c-3d0d80046c1c',	'true',	'include.in.token.scope'),
('6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'true',	'display.on.consent.screen'),
('6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'${addressScopeConsentText}',	'consent.screen.text'),
('6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'true',	'include.in.token.scope'),
('58606ebd-dae9-4c91-8407-1659830db5aa',	'true',	'display.on.consent.screen'),
('58606ebd-dae9-4c91-8407-1659830db5aa',	'${phoneScopeConsentText}',	'consent.screen.text'),
('58606ebd-dae9-4c91-8407-1659830db5aa',	'true',	'include.in.token.scope'),
('cee8ae8a-8f30-4c8f-9c45-c9870f228666',	'true',	'display.on.consent.screen'),
('cee8ae8a-8f30-4c8f-9c45-c9870f228666',	'${rolesScopeConsentText}',	'consent.screen.text'),
('cee8ae8a-8f30-4c8f-9c45-c9870f228666',	'false',	'include.in.token.scope'),
('818940b0-0544-4719-a439-6f1e40719b3c',	'false',	'display.on.consent.screen'),
('818940b0-0544-4719-a439-6f1e40719b3c',	'',	'consent.screen.text'),
('818940b0-0544-4719-a439-6f1e40719b3c',	'false',	'include.in.token.scope'),
('8f1541ef-95d2-4588-a428-ce52ed44794a',	'false',	'display.on.consent.screen'),
('8f1541ef-95d2-4588-a428-ce52ed44794a',	'true',	'include.in.token.scope'),
('33f8c3bb-c72a-442c-a7cf-355d43a5f500',	'false',	'display.on.consent.screen'),
('33f8c3bb-c72a-442c-a7cf-355d43a5f500',	'false',	'include.in.token.scope'),
('f35882c0-132b-4b49-88cc-ac79015b5c60',	'true',	'display.on.consent.screen'),
('f35882c0-132b-4b49-88cc-ac79015b5c60',	'${offlineAccessScopeConsentText}',	'consent.screen.text'),
('38085e92-1c77-409d-b7f1-443fce561a67',	'true',	'display.on.consent.screen'),
('38085e92-1c77-409d-b7f1-443fce561a67',	'${samlRoleListScopeConsentText}',	'consent.screen.text'),
('37fe646b-2268-4cd0-9878-53c30f3a473a',	'true',	'display.on.consent.screen'),
('37fe646b-2268-4cd0-9878-53c30f3a473a',	'${profileScopeConsentText}',	'consent.screen.text'),
('37fe646b-2268-4cd0-9878-53c30f3a473a',	'true',	'include.in.token.scope'),
('51040b64-31ef-4eb3-9c91-1ee4395d1243',	'true',	'display.on.consent.screen'),
('51040b64-31ef-4eb3-9c91-1ee4395d1243',	'${emailScopeConsentText}',	'consent.screen.text'),
('51040b64-31ef-4eb3-9c91-1ee4395d1243',	'true',	'include.in.token.scope'),
('875c08ae-fd1a-458b-908f-d2a56c22a25f',	'true',	'display.on.consent.screen'),
('875c08ae-fd1a-458b-908f-d2a56c22a25f',	'${addressScopeConsentText}',	'consent.screen.text'),
('875c08ae-fd1a-458b-908f-d2a56c22a25f',	'true',	'include.in.token.scope'),
('5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'true',	'display.on.consent.screen'),
('5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'${phoneScopeConsentText}',	'consent.screen.text'),
('5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'true',	'include.in.token.scope'),
('2dfcf2a6-0223-442b-9c69-005aee507e18',	'true',	'display.on.consent.screen'),
('2dfcf2a6-0223-442b-9c69-005aee507e18',	'${rolesScopeConsentText}',	'consent.screen.text'),
('2dfcf2a6-0223-442b-9c69-005aee507e18',	'false',	'include.in.token.scope'),
('4362aabb-8316-456d-a4d1-e8d643297a35',	'false',	'display.on.consent.screen'),
('4362aabb-8316-456d-a4d1-e8d643297a35',	'',	'consent.screen.text'),
('4362aabb-8316-456d-a4d1-e8d643297a35',	'false',	'include.in.token.scope'),
('9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'false',	'display.on.consent.screen'),
('9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'true',	'include.in.token.scope'),
('786ed661-6c0b-470a-81ce-b68146494182',	'false',	'display.on.consent.screen'),
('786ed661-6c0b-470a-81ce-b68146494182',	'false',	'include.in.token.scope');

DROP TABLE IF EXISTS "client_scope_client";
CREATE TABLE "keycloak"."client_scope_client" (
    "client_id" character varying(255) NOT NULL,
    "scope_id" character varying(255) NOT NULL,
    "default_scope" boolean DEFAULT false NOT NULL,
    CONSTRAINT "c_cli_scope_bind" PRIMARY KEY ("client_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_cl_clscope" ON "keycloak"."client_scope_client" USING btree ("scope_id");

CREATE INDEX "idx_clscope_cl" ON "keycloak"."client_scope_client" USING btree ("client_id");

INSERT INTO "client_scope_client" ("client_id", "scope_id", "default_scope") VALUES
('80f861e8-0c85-49f3-be78-6cf002723609',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('80f861e8-0c85-49f3-be78-6cf002723609',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('545a8bc4-3604-4e22-9fa1-eef1706558b1',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('5134a88f-62f8-4719-b81b-ebf025b29f47',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('ca28d79c-a08e-4ef7-af95-f99d20c3723e',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('00b17f71-6d04-492d-9a02-da855fdf96c3',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'786ed661-6c0b-470a-81ce-b68146494182',	't'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f');

DROP TABLE IF EXISTS "client_scope_role_mapping";
CREATE TABLE "keycloak"."client_scope_role_mapping" (
    "scope_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "pk_template_scope" PRIMARY KEY ("scope_id", "role_id")
) WITH (oids = false);

CREATE INDEX "idx_clscope_role" ON "keycloak"."client_scope_role_mapping" USING btree ("scope_id");

CREATE INDEX "idx_role_clscope" ON "keycloak"."client_scope_role_mapping" USING btree ("role_id");

INSERT INTO "client_scope_role_mapping" ("scope_id", "role_id") VALUES
('d872860d-41e8-477b-bed5-d9074f7d9bcf',	'0cfb9d96-369e-4b65-b60c-1500b24ea557'),
('f35882c0-132b-4b49-88cc-ac79015b5c60',	'8eb5dc6b-437b-45ec-8777-bb027c945c76');

DROP TABLE IF EXISTS "client_session";
CREATE TABLE "keycloak"."client_session" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(36),
    "redirect_uri" character varying(255),
    "state" character varying(255),
    "timestamp" integer,
    "session_id" character varying(36),
    "auth_method" character varying(255),
    "realm_id" character varying(255),
    "auth_user_id" character varying(36),
    "current_action" character varying(36),
    CONSTRAINT "constraint_8" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_client_session_session" ON "keycloak"."client_session" USING btree ("session_id");


DROP TABLE IF EXISTS "client_session_auth_status";
CREATE TABLE "keycloak"."client_session_auth_status" (
    "authenticator" character varying(36) NOT NULL,
    "status" integer,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_auth_status_pk" PRIMARY KEY ("client_session", "authenticator")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_session_note";
CREATE TABLE "keycloak"."client_session_note" (
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_5e" PRIMARY KEY ("client_session", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_session_prot_mapper";
CREATE TABLE "keycloak"."client_session_prot_mapper" (
    "protocol_mapper_id" character varying(36) NOT NULL,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_cs_pmp_pk" PRIMARY KEY ("client_session", "protocol_mapper_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_session_role";
CREATE TABLE "keycloak"."client_session_role" (
    "role_id" character varying(255) NOT NULL,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_5" PRIMARY KEY ("client_session", "role_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "client_user_session_note";
CREATE TABLE "keycloak"."client_user_session_note" (
    "name" character varying(255) NOT NULL,
    "value" character varying(2048),
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constr_cl_usr_ses_note" PRIMARY KEY ("client_session", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "component";
CREATE TABLE "keycloak"."component" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "parent_id" character varying(36),
    "provider_id" character varying(36),
    "provider_type" character varying(255),
    "realm_id" character varying(36),
    "sub_type" character varying(255),
    CONSTRAINT "constr_component_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_component_provider_type" ON "keycloak"."component" USING btree ("provider_type");

CREATE INDEX "idx_component_realm" ON "keycloak"."component" USING btree ("realm_id");

INSERT INTO "component" ("id", "name", "parent_id", "provider_id", "provider_type", "realm_id", "sub_type") VALUES
('1f03b5f8-9956-4393-823b-7bca8130b2fe',	'Trusted Hosts',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'trusted-hosts',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('20e44454-442d-4de0-bca4-7302b7ebf5cd',	'Consent Required',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'consent-required',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('32ee0a6d-1169-429c-98df-7d3d81efecf7',	'Full Scope Disabled',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'scope',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('afc1cef3-52c2-4752-8032-39cfa69a28bd',	'Max Clients Limit',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'max-clients',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('0d44137d-0c90-4366-bac9-b11205b0b41e',	'Allowed Protocol Mapper Types',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('39db0b0d-641c-4350-9911-5fd48aae67ad',	'Allowed Client Scopes',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'anonymous'),
('0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'Allowed Protocol Mapper Types',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'authenticated'),
('b3b49e56-c4be-4217-8a00-560ea8219f0f',	'Allowed Client Scopes',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'authenticated'),
('2fe93e9d-ff30-4767-9aa2-679a5c79fa8d',	'rsa-generated',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'rsa-generated',	'org.keycloak.keys.KeyProvider',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL),
('7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'rsa-enc-generated',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'rsa-enc-generated',	'org.keycloak.keys.KeyProvider',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL),
('614d646f-0722-471a-9aa3-2863cdda473d',	'hmac-generated',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'hmac-generated',	'org.keycloak.keys.KeyProvider',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL),
('aa7cc915-cb52-486d-b104-7277d9144e43',	'aes-generated',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'aes-generated',	'org.keycloak.keys.KeyProvider',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL),
('66fa79c4-09dc-46eb-83dc-c2855570815f',	'rsa-generated',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'rsa-generated',	'org.keycloak.keys.KeyProvider',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL),
('318c6c45-6bd5-4c21-98b2-436c335e139e',	'rsa-enc-generated',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'rsa-enc-generated',	'org.keycloak.keys.KeyProvider',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL),
('bbd67644-1449-4005-845b-1d05311a50f3',	'hmac-generated',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'hmac-generated',	'org.keycloak.keys.KeyProvider',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL),
('65153024-f9d8-4632-bc0f-a54e9da2fae2',	'aes-generated',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'aes-generated',	'org.keycloak.keys.KeyProvider',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL),
('1352d9f9-196a-491b-bb5c-6599d04b285b',	'Trusted Hosts',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'trusted-hosts',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('df5328cb-eac5-4398-be83-0aecfd82d67d',	'Consent Required',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'consent-required',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('b19ada0f-2c73-4c8c-8e21-52448a3df61f',	'Full Scope Disabled',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'scope',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('05e895ef-3416-4694-abe9-d6734a3c3e3a',	'Max Clients Limit',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'max-clients',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'Allowed Protocol Mapper Types',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('7848b57e-e1c6-4e47-8a48-9898e50e426e',	'Allowed Client Scopes',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'anonymous'),
('ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'Allowed Protocol Mapper Types',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'authenticated'),
('6d31893b-876b-476f-ac2a-1caabfd4d6af',	'Allowed Client Scopes',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'authenticated');

DROP TABLE IF EXISTS "component_config";
CREATE TABLE "keycloak"."component_config" (
    "id" character varying(36) NOT NULL,
    "component_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(4000),
    CONSTRAINT "constr_component_config_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_compo_config_compo" ON "keycloak"."component_config" USING btree ("component_id");

INSERT INTO "component_config" ("id", "component_id", "name", "value") VALUES
('f6b45908-8c64-4d80-982a-73d968efe87b',	'afc1cef3-52c2-4752-8032-39cfa69a28bd',	'max-clients',	'200'),
('46e1e86d-d40e-4c7d-9cd4-9c6c30526b8c',	'b3b49e56-c4be-4217-8a00-560ea8219f0f',	'allow-default-scopes',	'true'),
('92710f25-256a-49f2-bc29-cb8c1b222287',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('f0b47076-aab5-4497-9a80-9c5937017845',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('d76234c1-df01-406e-961d-f9e3531faef2',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('5bf9c854-9e17-4797-930a-dc9acce4aa26',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('f0733be9-b9d4-4acc-9b91-a5e155e20910',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('abffb577-75f9-476c-98da-5519d3bdb3fe',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('e965ad77-13cf-4b83-bb7e-00f9726cd79b',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('26d57ecd-961f-4e7a-b1e6-cb76efca75e7',	'0ef111eb-099a-4cb3-99c5-bbe7167227cb',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('9cf1e286-b219-4688-ade9-6500dacdfb07',	'39db0b0d-641c-4350-9911-5fd48aae67ad',	'allow-default-scopes',	'true'),
('cb6dfbe3-5845-4a1d-b718-53f02b20b109',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('d88e22c2-c9d2-4622-a795-6ea6c830034b',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('15ee37c0-6516-4879-8ae6-c40ccde74ae1',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('a27125f8-21b6-4f26-873d-9ba8bc94bb06',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('f63d2143-7ad9-4ae3-8f0a-bceb33b67af9',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('79d50fbd-49cc-4c1a-8f78-b4bb3b976ad8',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('2b7196e7-41ca-4398-a1f4-9e402a168346',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('75770c0e-eb91-4d1d-a85f-ca96c21acd4c',	'0d44137d-0c90-4366-bac9-b11205b0b41e',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('26f652d7-6af4-4872-9544-20c400a0da27',	'1f03b5f8-9956-4393-823b-7bca8130b2fe',	'host-sending-registration-request-must-match',	'true'),
('db9aa64a-84cd-47f9-a051-bba3de8d2dce',	'1f03b5f8-9956-4393-823b-7bca8130b2fe',	'client-uris-must-match',	'true'),
('af72d8dc-9c16-4b18-ba93-b6c3d08fc6ff',	'614d646f-0722-471a-9aa3-2863cdda473d',	'algorithm',	'HS256'),
('93f48f62-470f-4b44-ba7b-53da9abedb0a',	'614d646f-0722-471a-9aa3-2863cdda473d',	'kid',	'd789dbf9-ac41-49a5-a17f-b0fb842eb134'),
('64f13dcf-489f-48ae-85fc-a68587752c7f',	'614d646f-0722-471a-9aa3-2863cdda473d',	'secret',	'WtH_pxhLKfhvub2aFrAeTjXwG44Vv2bWo7QgsSdFw4swpQrXMW5TLOM3V-ft8Wo6Nao9XYAh7qZdyCIpA65Vuw'),
('f2c241d0-b1f4-4971-bfef-6252f3cb1725',	'614d646f-0722-471a-9aa3-2863cdda473d',	'priority',	'100'),
('1bd13da0-4360-429b-944a-4b6c2f873d37',	'7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'privateKey',	'MIIEpAIBAAKCAQEAnRkgTsu+XJqySETUqEm0VHTq0p5j9nc9F0YcXnTJXOHGD7YRtLGZe705kB7wqEYzYRTpn8rbiZEOk+XF+sYiLtUKazA5OzEeJtBYjDVFCKmzf4WsEq/40s+RdTTzO0QS8eU8IMda4jojVVkPB/Hg+Ivij13TqZFgUl+8MXr1bVrxZOXsmGgWpJMWldB6z8aI+L8hssGy/3c4DFs/uZ3QpvK7Fi7CWWmrz6xhxK2kT6rECyhdfWL9xbVtiCsKdqNcOANASwMl3eSom5wB7pf7bM9hfe0kX5q6zON2d64tV1uRDtz1KTaf/n9ZJmuVIdqcRtFDwbUHxE7JXGWFnWzC9wIDAQABAoIBAAcq7ntEjDFxH3bw/luVTU8t1x73+hX0jSAtjegjX6KcwdWAAvZ3GfUi25L/TmSnG1CvzGmthERruWS3GZ2JAmXs83Y+M4ZHW0RTF48syQhi/HJyOLkmN+31FC0VrDlahZttevJV64gh4Jspc+hIDsctqWR4LUrx0UQWOSHFe0LbeUD1RsjR15dS9leJ4DgkORIS4hyWhUyYeH7QhB0MhXyzf1uXcXopMwDch7AA7JWUaeU+yWrFhna2oRh2CJCKiY+AXVzWsSkWxZDzmE1if9lzrSoa0TexJUE2yipW6QV3yD0pIdaW/4s0SHFh6iUHcfHkU4tWRV3PmnVLBWcMAjECgYEAyLE/TJUY+vSdVH8SLlqhjc9+eL7YrgWRZ8/CHUIs2BFn/pstXjGV+uOL4HCx/h3BJE0kFiipo+kGar8GrjuNDzQX1qQuHVswZGriZ36g/Ca3lXQ9XsEd7Orj/onyxtovEjRLlIoz9Cqx4YPnxhP8RY1S2/iyBUNJCvQ8pyTNP+cCgYEAyGRTs5FGT9OHLGvagCq8kixLuymX1qnPsE6MLz77SqPtKKG/nptRvlvLEpG6ygKC3F8yquF2y2iVSTWwghR+uhWMVfUUIXxcOkhl0pLFBXiAyuaZyMzfm3fcgWgNuuaGOtL5Oiz8lMelX4U0TLY01vIIaAOHyzuxJf6OfYWWQnECgYEAxpqZMJkvwlFGTLL/c/3eeC7JUoZSeUwrS9dOmpO9Owlmp5A7AkcBy+lYp//+NKKPWvQ37PHKhtl4rzRhURS/kDcWDCQnOofeSNF5QcAPYdiSvoTsopNroOQGQgOTzHNoN5Sm4tUtesixhaF6QQvQD6g+Qk9HJGwkoYF3cFS8BSsCgYB3ED03NPrc1Sa8evyhKENQamc4tjbUQaL380ORks9GAu4XNTugJlLEUs/uoY2lFybffuSg6UNnCiWhEPhl4X2GXOU78VjbqIM30epF2hSb8oQ7ihYXW7sEKYxniwaVZQCeFNol+bK9R333qjJv3da5W6co/egCFd5kX8ITzHqB0QKBgQC9VBaaWQh+pb4dTbMEaYm2Xg2yu49ERz7YlpVYz98D8rduk9qQjIaaaiT9WPMwDz7ZoqmScm7oxsyALcZ4ptUrKp3B/y7wu1RX2U7MYJYGyTq24yu04ZZ86MNXld6/PRqymvT7Ke9n9xb8FgXBMDuyeMCTpjSOQY4N3oLjNu2FgA=='),
('ea5a7305-e8e7-4e2b-8ce3-0bfc1db3bf96',	'7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'keyUse',	'ENC'),
('84887d61-5f0a-4a4d-81d8-e37bade290e3',	'7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'certificate',	'MIICmzCCAYMCBgGIOnm8dDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTIwMTg0MjE2WhcNMzMwNTIwMTg0MzU2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCdGSBOy75cmrJIRNSoSbRUdOrSnmP2dz0XRhxedMlc4cYPthG0sZl7vTmQHvCoRjNhFOmfytuJkQ6T5cX6xiIu1QprMDk7MR4m0FiMNUUIqbN/hawSr/jSz5F1NPM7RBLx5Twgx1riOiNVWQ8H8eD4i+KPXdOpkWBSX7wxevVtWvFk5eyYaBakkxaV0HrPxoj4vyGywbL/dzgMWz+5ndCm8rsWLsJZaavPrGHEraRPqsQLKF19Yv3FtW2IKwp2o1w4A0BLAyXd5KibnAHul/tsz2F97SRfmrrM43Z3ri1XW5EO3PUpNp/+f1kma5Uh2pxG0UPBtQfETslcZYWdbML3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBADeOQ29TSIgK8pWQCQqbPg72pWGhYAzertihSkhHhSMcUS/V+OnllAAc2DTdlUlRH4KPGMqhIcBD9ySxrSYzlg96cIJJTPttyXNi2p5EmSLVjmeglsBxK1S1WhKPGaN4OrzzI+epsoBeZ8iaBHnixRm+R+pFbSk8drG0yopS48nO8weNe2PAKD0surOzBIjiDwsKGqgNXR/wv5sXjzqF7RtLHiTmUllk04LCr4qyEao8aA29zHDKbcx1gjGRgFMe0pKwmmm44JM3q/h7A0x4kdPaqkcErW/JyBKFFElOPRsCRwpAa9DNfG/TWqAqOejbxW7IqNgrUnPSgsKO5KqHngY='),
('a5b5d016-7342-413c-88ec-5ab856c48fca',	'7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'priority',	'100'),
('b505bfb5-a9f0-4af0-af53-51edafcac852',	'7fc62b69-b8ab-4a79-8d30-c42d1b012d6a',	'algorithm',	'RSA-OAEP'),
('0afabee4-e1f1-4721-a15b-c9682e1d0a94',	'aa7cc915-cb52-486d-b104-7277d9144e43',	'kid',	'724275ac-67d6-486f-8edd-9a6f5e896ad2'),
('820eff54-3901-43f4-a61f-ad22612763ce',	'aa7cc915-cb52-486d-b104-7277d9144e43',	'secret',	'n1xRDOxozmKlnDnDbnv9eA'),
('b987048f-213c-4387-90cd-fad50b4060ae',	'aa7cc915-cb52-486d-b104-7277d9144e43',	'priority',	'100'),
('6eb51e48-f96c-49d9-bb60-0efe25056e3c',	'2fe93e9d-ff30-4767-9aa2-679a5c79fa8d',	'privateKey',	'MIIEowIBAAKCAQEA2OyZvjwXxlXF7im8YJX+A0wpqkGSg6ouCvFSyfLyuuplFqfCil4rL1oZTvhRD0HLuj3j8snnNa6jEgDLywX9EjDXgGeBWBBJ39ckILt0phrCfDya10WRquGR5kVx0w0tNYDdq15cj5/Vu/kizDAcWL/VTmMswToydHw9WbTUeFlSWrLqjJDPVme+aLxzvU77iSQale2tLvP0Wb/lUciuHzzH6LPmBFlAyTEajLIZp4+DQLMF85heLzx8c7W0MRjaYIJE0xMVV/bBQJKH2mC0Jy8WmT7vhnNJjSDCCbPLjydVGzdXsTzqCY7lfELepYLeTx9x5zFw1beTELgbmA6rWQIDAQABAoIBABfKhUcluJbOV/W5upkeQjxy2Tv80pihrMiS9JlFDcWdyQX90rqRvutD1rRATEWf2fv8Zzh81+CdnXFvSGqlJr8cv7nrwDYcHToRUrtLS+0e0LdG/1V+Yg5LjJCki6oRzyRH1KgDoqO27D5gQeaCnU1HhtnAy0sK+rcnXCQvTsE/GM1FkjLJZE40hyZmZ/m/xXWHoWo8HPyElRlVCnAgTwJs8E9YXI65kIV3PUlpU4fLZet0ddCYViq3GI735rNgu4cs3Ft6jkGPvSkd5SDfJ/lUaFeS9ChOVNS68SzS6hkIFbDhGK32s5is8m+/k0IiLOfmQ0Ixaugw6tVDPgLmWf0CgYEA/t+rvwEsLfzVVWzbBZU/G7vJB322kQUj+OmNFIdyH/XNjAK21aCXtQt71GfbqSA9jK0+CCopnJMYnlDa9bkPBNRNaIEGtIqZJmfCiGPb2I3Z5aSyx+c9Y5iY0ST1yAYIfAaXQQ4OuWBEx7iLFhpxN5jakDGaLg0kEb+6gP20kWUCgYEA2eH/s18sI8gc0dKXLxeyTZ0lZyvbSKAb6WJJEOlMLWJpzZN+03cVFWxQ3znEW4dQVcPxmkhBoVS4abar/eZ1s3df/+FKbAjxV3dfpZyZrlKKflvVKyXHFSc/YqakbShBgOMpflKjhDZWOw1GFBz/5SmI5Nzp6drhV+f7jh1KbOUCgYAG4DHZ7UYr125J563g8K3LKb26ngGW1/SoemR78Ut64T6yUEBucu6ky7KDgGnEnkIK0YGi5sBIoQ9A9h1yE5P8JV4RO6napQKMrq/ozgjYRrtiHpdUHUDitvMocT7QLpl7/xGFh8ON7LLuUGQwLHZxcYYz7aKjK2eVsv5tDGsaoQKBgHPMYEjlySDPRzng8cbuki4b2fgmX+oOZic4vFqHk5v/VPoUbPBYttTm92hcXFbE6NZcSHjV9EOZMlXE504PAPk79cKZ6yLV8eappCTxwN/cMI0No5LGBjPg4xg8NuFo5r9oe/IOW6d19Yh2+orQCtSxqXbxTkSitucwfQq/2IFdAoGBAJNwbTMEEZhDzY4RYLuwGl4156bgkDVrfDhx58pKH+xZ9+pbguWgG2zP8GpVVnJhoDI+NXEIptdCelIWtBfA/ZcrXBuv+N4QChLfzw8Ti8hwbSCC4TrHk1nB2vJrp/DuOG/1AR8xIoOFNuk5Q4Hrs9y3OHDhIuHidQd41xVYjOsF'),
('0d0e19f3-028c-42ec-a314-56062d57f1e6',	'2fe93e9d-ff30-4767-9aa2-679a5c79fa8d',	'priority',	'100'),
('2e93ad57-2c66-4eef-a081-1f32a8acdd8c',	'2fe93e9d-ff30-4767-9aa2-679a5c79fa8d',	'keyUse',	'SIG'),
('21765d30-7dd9-4c12-8d0a-63aa8b4e4d88',	'2fe93e9d-ff30-4767-9aa2-679a5c79fa8d',	'certificate',	'MIICmzCCAYMCBgGIOnm8FDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTIwMTg0MjE2WhcNMzMwNTIwMTg0MzU2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDY7Jm+PBfGVcXuKbxglf4DTCmqQZKDqi4K8VLJ8vK66mUWp8KKXisvWhlO+FEPQcu6PePyyec1rqMSAMvLBf0SMNeAZ4FYEEnf1yQgu3SmGsJ8PJrXRZGq4ZHmRXHTDS01gN2rXlyPn9W7+SLMMBxYv9VOYyzBOjJ0fD1ZtNR4WVJasuqMkM9WZ75ovHO9TvuJJBqV7a0u8/RZv+VRyK4fPMfos+YEWUDJMRqMshmnj4NAswXzmF4vPHxztbQxGNpggkTTExVX9sFAkofaYLQnLxaZPu+Gc0mNIMIJs8uPJ1UbN1exPOoJjuV8Qt6lgt5PH3HnMXDVt5MQuBuYDqtZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJDVY53Lm11EBzkusegqesnxttW63rN6y6XrYtgCPlkY01JbR2Wa6hsxhg24YMQ1gMFRH1ANFf4SZg8qdab6xo1Qu2KlPrZgWS0F2gK9qhFbskidAZac+6x9KRxkBjClsG8ZOLpjrm2rDIbxQ61cveXRJaz2GrPxzoghblEIP5IkFL9vBWGY2CobxdSwh+SejFWnmkMcJDB+rX/SUvq90gdt0ejihx775hvXxAUqkfalyNj7HkpjT29cwoe+irfdYCMLEg3e/m3y4aIXz1+EuTCEf4sP8LeTZU6icYdhAKVOhwTz2edY9nGuB1TXBuygPixPOYJUhnJfIs/HmKrM+RA='),
('4c7d477a-d330-46d4-a5b8-b94f9e6f6378',	'66fa79c4-09dc-46eb-83dc-c2855570815f',	'keyUse',	'SIG'),
('0a83c25c-8f4c-46d1-aecc-c1b797e3fa99',	'66fa79c4-09dc-46eb-83dc-c2855570815f',	'certificate',	'MIIClTCCAX0CBgGIOqOYDTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkbXMwHhcNMjMwNTIwMTkyNzU5WhcNMzMwNTIwMTkyOTM5WjAOMQwwCgYDVQQDDANkbXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCK82LK0BYF30kbtAkbUGOKrxjF525PysNUK8azSL1fJMfMgYxyeYg+kaiNhZVDueTY3OY6JfPT32oFLHIPllDXkQHd4OlmF9xcj4xhnjsiAw39j1MkOAY1aGrWW2jl5KuqoUDC8Tn630kZxQkj0TOF83IEzaippJohPRqbvsBFGGg6aqQgK+g0xG/DT4h92DHFqLKl8IbHD+28se1R6lui4A3X8eMzLJpdpYchGPR6H79R/YXOpsVLGWvUkqb62Y06Do8sTlbR36EAZ8ul8nyw4t/E8Hd0vXpu2dCWMbgGqc/LpBEqjOzZRyws1yfMJqzu1nRzaP+/lMzzz/Q8WYKBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEzxkerpCg7qIzCMQhIUTvokVde8NtGYCiXrbEXAb2DVpgYAcTjGBx6HbsFBw45X7YqINrHRc3URv9MoxX7HfYkg052Tz+0r1znLSs8V7S2va8mYrAgnvPOjrmpOi1lto/cAYnli9cs3kNESKTa5sVr4ZdrUafNAaU6F2ZhO+BSwtfOJQv2AhOQRXhW/DLXrSpe5R1AZj7A3mvM0XHCznJGPyjriqVJbWSOV31deLkl/M5X3jm9fe6XmxgvNWiOR4sq3rAZzS+3SN6pJnQZERzJV7UFnBJr469fdUJJv/FpHBB+sJj6bK2868N4WLtLRg4V8C65+lW9OCjmfV01gVek='),
('6cd9575a-79f7-4b66-9974-b6969e166dfe',	'66fa79c4-09dc-46eb-83dc-c2855570815f',	'priority',	'100'),
('6e406531-1eff-4048-b54d-e3c1f9004171',	'66fa79c4-09dc-46eb-83dc-c2855570815f',	'privateKey',	'MIIEogIBAAKCAQEAivNiytAWBd9JG7QJG1Bjiq8YxeduT8rDVCvGs0i9XyTHzIGMcnmIPpGojYWVQ7nk2NzmOiXz099qBSxyD5ZQ15EB3eDpZhfcXI+MYZ47IgMN/Y9TJDgGNWhq1lto5eSrqqFAwvE5+t9JGcUJI9EzhfNyBM2oqaSaIT0am77ARRhoOmqkICvoNMRvw0+IfdgxxaiypfCGxw/tvLHtUepbouAN1/HjMyyaXaWHIRj0eh+/Uf2FzqbFSxlr1JKm+tmNOg6PLE5W0d+hAGfLpfJ8sOLfxPB3dL16btnQljG4BqnPy6QRKozs2UcsLNcnzCas7tZ0c2j/v5TM88/0PFmCgQIDAQABAoIBAAiV8GFKyUmUme5ZygRDi9sKZbP40GKiyz38tHrogDcMTUIwMQ7zvnzrQCh6fBYiuubBg4JNTQsm72ShcezPo3AmeCCPIKzbxZR8lDaF8e5wlOE5hXAj/BI5wPw8yrcF0aup6hgBks0TFe+/MojhiNb6i22LjaPp1VI/ddDw0O2T9K+MQ1cUCkQBDrb4CMJQrTuEuEOndm8oQxvyHyzUHGJSq4MT6aVpmFhjiatt58UaQfATTxPa2FbEEmRuoNpb40nm191+WEr2hEII3GVzdEyxaMqGw7cse3/oHYDEjR0DIcmeDguqWCvAnuCvMjqn5MsbiZNUai/CcuYc6CCURQkCgYEAwgqi/MWK3ydITSLhjLJV8dqMreAGXzmTX7An8LGmEUygi+OxXV1xNA2ixDs9aMmLy00TWSKKGA4P/lo6BEnl08gIHO34RLo1R3bl4rH34fGB5GnYvNsVyWeT+lMtzy4E4QFgyc8FjkTmS1Bu0auMA27IXyyy85e/f24AmFG5ST0CgYEAt1GCgCtJXMAF11UvUgiMrXZZcsejiOZ8EFvtAnoQsPmZYcrRTwlFUwg8CGhluhdOEEGmvkCVaQT//4rIEfybv2azbLDPZh7yj96XSCu2+jJr+5TGepihjGaZCYHRkG6tCYwI8zuEF6zDFCyoYaRv1djrDIdqP5qQkz92BGyTipUCgYAaiZ/e2Bl1CYdO3V1hg6ZTbGNfCEt2zIYGSS49Md6XcRZn61z/et8XkmHXWo68fQv8Yu8peprOTWYMkERs/7pJ64qIglc49wqAWpd4GIThRslP9tXohkIFiH/pdWTHd/C84RZeo0yMN4oTdM2jKUX91jHbKl7TB8bt45p7OnoPtQKBgA6NB8DIrtAP5ebLui/WwePa6wqzUgXB1cMuqMdzjPOfPE+I28hcQgZvNuSr9LcqtmWP8H5VfgaSAQf1qh/TX0F4E3HjLvM6LaLB1lxCLAn8CpozmvWMO/Z7Bla82TePsWh6lxNHfBqs+ecWDF+Dv+THjRC3hvV5fVRSyzlarPNpAoGATmDN5flaR/fSqqtpDQHyeFDG/EsMT2UHbDCjEP7H40sCkS0MD+O92kcWBWBcu08g9IxY1hEL5Jn37tTCsOd7x0Q5wwJFkTAHfMKB1HLXG0r/Oy+iPkk/7WzFoKNNjqu28VJADGpVo+KgOt2/HI9WYbOZtY18CLtFYesD0DePfPU='),
('48969d76-fbe8-46bd-bec6-26af35639f0c',	'318c6c45-6bd5-4c21-98b2-436c335e139e',	'algorithm',	'RSA-OAEP'),
('9e54f9fa-bf80-4aa6-aca8-372cdd7b8041',	'318c6c45-6bd5-4c21-98b2-436c335e139e',	'privateKey',	'MIIEogIBAAKCAQEAsbdFawKN/msbTuEnIuGbYYhbsM5X5FGX/7bjFEqP/y63oatJ9NTYcAfhGFG+KIq8Oq4XJjBQNKUVydOFe7ZEJhmYHqlEOWtJaabgx3SOV4IApMm/UVBIOrjyFAqndKFMiS+h/b1os49M/3ckQfj3k2lpRvlPmu6vH+Z6lub3KkQFDtAMO9hFt+WNgKQPi1vfQaZErw3UG4TOMVOlERTGFfTi8QDorO8SspVVtKIJIrQJT12JvpbeIjkvp4MsSTwh6/Z3E1ZnegIUH5uUn1jZ1W1bgtducPITfYxhw4NAIdzT0phqa5Eheacu1CT42TWF20/VrXBQNtaU+ispagMRUQIDAQABAoIBABtngYLg3/iNl6ZwPdK5K3a8yjbXeuIwWtoJ37ZvUQkusQ5zFXJ1p/KOpH1VjZc+3YvG8Lbo2FVl55g5z+mlz5h4dea0f1rDWoy6OQtIw/Jmj6bZnXDyilDT2DCS/AOWI/E7sSUpog2eWWdDfgnWVIccyCkzpLzldYfbyKegchjIJfKWUi0wtiFeQPK++CU350tRTJQ5ubNzfzVNI3sCTDRK6+0cD1i2oisR4YJclXBZUt1t5SnfLB4HB4D9bcx7N0DiVGjlcd06AE1F5/kbc/9ZzN5qvB7SBF8xyxf5g1SyLcbYEnJKjYFAbW+VN4vnb1dLwpD1jNcgu/tQunIsN6kCgYEA9hdm+O79rQuMcFtlfq/tRlz2kbv9ErSZrxz32VBbTsvaLPBkTyb5Aqn8zwL7+1hTtSdyAamnNIICSuSFmw45/h7Lfn3scX7axQSUSSsFx5WumtnqOpB2eTUfikWL4fIH0bbPQsOTh6WLRSKWM8gR+uT/VANVvYxcOrMY1FGCSNcCgYEAuN8V3hDYsDrAgktLXGqNvfKahkbasy/ES/9THNxKbsNc7AIhx/YuH8waXFVjls9sWxPjj/25WifpVyh+1tf8ucLk0hlx/zxCRg4nowZmf3VAFu7z7V2D+4ZutYDJvPjTEjGGJVEHFH0SXu1svw9xLXhwlGQ8kqYUvsqtECvW6hcCgYBVAH5b68kJtZx7zsX+/Wt6y2+LpSBkDqeq+dmOYZg4Xmds8FflkzOdvPOK2aAKEFdRkl9pvZz4oRODpO2VQlO7uA1YEszR4xxTwyIpJ8gmSUh3SmACfJW/hh7v1tfbYota38c1a3KQ/xhc9/Zjym6Td/fNoB1EjK/qwqQH6mOTHwKBgFrDrEjKnJhpP/q4XNeSuOR5J8SlJNq0qPtm77dLsH+RCx4ULeGuzBZwbsDGa46vZ9OPgDpBp67LyZQxHZT9lebd+NnuBDn7q84ZRPyVN918A2s/BiOTtijXZ6NVB7bvszFLf0Dy9zbn8Q0KJEnpmvdoGl3AmLynLag+eZlm7K0hAoGAKD8a0iPyZYAP/bLxGlu43+vxh2NVkl5rG9ReT2nHucDsGE8J0FpWzHtDqE0e73pHjt/ovQFwQGyXN0tZ5cAvPs00haNagMO85B1tfAaZRaXERjIBavuL4im38g8UE9KJWd3wjH7vF/hL35CVMEySGTE2rjXeMFTdk5d+OeoPV2A='),
('1425db56-775d-4397-b854-64bd36236d96',	'318c6c45-6bd5-4c21-98b2-436c335e139e',	'priority',	'100'),
('4eef4051-52f8-4ba6-a8ba-8a70956d83a6',	'318c6c45-6bd5-4c21-98b2-436c335e139e',	'certificate',	'MIIClTCCAX0CBgGIOqOYqTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkbXMwHhcNMjMwNTIwMTkyODAwWhcNMzMwNTIwMTkyOTQwWjAOMQwwCgYDVQQDDANkbXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCxt0VrAo3+axtO4Sci4ZthiFuwzlfkUZf/tuMUSo//Lrehq0n01NhwB+EYUb4oirw6rhcmMFA0pRXJ04V7tkQmGZgeqUQ5a0lppuDHdI5XggCkyb9RUEg6uPIUCqd0oUyJL6H9vWizj0z/dyRB+PeTaWlG+U+a7q8f5nqW5vcqRAUO0Aw72EW35Y2ApA+LW99BpkSvDdQbhM4xU6URFMYV9OLxAOis7xKylVW0ogkitAlPXYm+lt4iOS+ngyxJPCHr9ncTVmd6AhQfm5SfWNnVbVuC125w8hN9jGHDg0Ah3NPSmGprkSF5py7UJPjZNYXbT9WtcFA21pT6KylqAxFRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIjSh6k/pqAwQJz8XhDzYbb1bYCP9g2v0qWCSoFcE5AztXSpHba1wLuOKHltpGCY+u49lnHjReamF+cQjFnixa9pTfVRLg79HzjaGeAgG+PnEPv3M6hX0C/O36P1AUujWueGiXmnfgYqLgmMIQm/bxvrq2fR6UBrFA3oHNPEsP7sNM3Ui0LSd7C50csLMFKBkfEU0JT08dt1od9N+qrDjCInPtsoQqaw9ymV7mn7g9OzWAoPVUd0hElf/sLPI8ZFLQmyB84VRCy+PaWxcjJ1CF7oOyZNiTMYVDv78E7BXq78tCuyJNcsDR9BzY0g7rzj0+5JnJEImHDJNlWvY6VAIE0='),
('f95a5c17-bfac-4e8a-8231-fc40c93bb9c4',	'318c6c45-6bd5-4c21-98b2-436c335e139e',	'keyUse',	'ENC'),
('0aa62849-4a44-49de-8a08-0a68e258be42',	'bbd67644-1449-4005-845b-1d05311a50f3',	'secret',	'-TUxhkrCyZpk6A212rVR7x_UEkpDL_sQcsnFaC4tuu8tfHVXPfl3F8hMP8bdWsYJcCoUiqDkDpNFn0pmWB1nUw'),
('83a655d5-6b8f-406c-82ee-db53578368ff',	'bbd67644-1449-4005-845b-1d05311a50f3',	'priority',	'100'),
('a811d9f5-55c0-49a1-ae79-b2e3cc2cc7b8',	'bbd67644-1449-4005-845b-1d05311a50f3',	'algorithm',	'HS256'),
('95c3d1d3-f310-4920-957a-d8f3c68f2ca0',	'bbd67644-1449-4005-845b-1d05311a50f3',	'kid',	'b94f3fb4-609c-408c-9492-f694db0f3f9f'),
('0c655e51-3c1c-4f63-a1dc-037dbcd56975',	'65153024-f9d8-4632-bc0f-a54e9da2fae2',	'priority',	'100'),
('6bb538ca-4f23-43ee-ab86-c4bf61e4e28d',	'65153024-f9d8-4632-bc0f-a54e9da2fae2',	'secret',	'3XMJ6fvEmmSA7Y-gyaVBJQ'),
('63b566eb-7230-4e98-933d-1a1516374bd9',	'65153024-f9d8-4632-bc0f-a54e9da2fae2',	'kid',	'04b2cb95-c5ba-48f2-b207-e0aea4ec744c'),
('bee7ae69-943c-4412-8a76-dc973d745c0a',	'7848b57e-e1c6-4e47-8a48-9898e50e426e',	'allow-default-scopes',	'true'),
('5b737215-1275-4e0a-b645-d5598c7891f4',	'05e895ef-3416-4694-abe9-d6734a3c3e3a',	'max-clients',	'200'),
('5cb63e87-32cb-4251-a40b-4940b6ded216',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('6109ee0b-a01f-4127-8e1d-18a12b0ab752',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('b5407d13-6624-4677-9d0a-ceb6695e6693',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('f0744e2f-c0e9-4c5f-8c0e-7e8cca3cc94c',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('6a833890-8d83-49a6-9352-df4f8168ecc9',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('be895c47-b10b-4bec-a7db-8eaab60b1e84',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('56e1427a-0922-474f-9baa-18189b906946',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('2d453982-0e6e-4110-8f89-78375342d4b9',	'6947e090-4ad0-4f60-957f-35ad0d2cb80d',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('b60488e4-1965-47e4-9658-ddf6dbcf28d0',	'1352d9f9-196a-491b-bb5c-6599d04b285b',	'client-uris-must-match',	'true'),
('43b5b47a-c39f-4dc7-ab28-0b432650603c',	'1352d9f9-196a-491b-bb5c-6599d04b285b',	'host-sending-registration-request-must-match',	'true'),
('e31a0186-59c3-44ef-96e4-3ab43209260e',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('0f276910-aeb5-48f3-8721-4e816badad2a',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('b6458a40-b89c-4435-bfd2-1936200e9183',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('03c1404b-7590-4e68-8582-02dab1a47649',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('6cc0d3d8-f456-4a4e-a12b-ff86de3d1f31',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('344a4021-42e3-474b-b33b-e128be95ac5b',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('9a8b7eb0-b319-4381-9e72-1fd6d4e3f38d',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('94b21ce7-7127-4d35-8828-688767b0749c',	'ba14f179-7e16-46bb-bf09-ba1cb8e15222',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('5403a8f4-e933-412a-beb0-669a54edc263',	'6d31893b-876b-476f-ac2a-1caabfd4d6af',	'allow-default-scopes',	'true');

DROP TABLE IF EXISTS "composite_role";
CREATE TABLE "keycloak"."composite_role" (
    "composite" character varying(36) NOT NULL,
    "child_role" character varying(36) NOT NULL,
    CONSTRAINT "constraint_composite_role" PRIMARY KEY ("composite", "child_role")
) WITH (oids = false);

CREATE INDEX "idx_composite" ON "keycloak"."composite_role" USING btree ("composite");

CREATE INDEX "idx_composite_child" ON "keycloak"."composite_role" USING btree ("child_role");

INSERT INTO "composite_role" ("composite", "child_role") VALUES
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'49025ff7-1cf9-4e03-9539-d08d67f890b4'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'4631c014-6e7b-4d12-a2ea-ec46515fa365'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3e35080a-8b4c-41ff-b4c3-c32d87c9c7ab'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'0c8dec44-f901-4a87-bc0e-632248fd4f06'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'c9903715-4b41-4af6-a372-ab5e84797e1a'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'ecbf458f-a24d-4eb0-be9f-700bbaf59950'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'82c8e1d1-fb47-4fb1-b49a-e4ff3b19a7f8'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'1b952c2e-bb55-4f28-bd36-7dca81aedae3'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3a2c44c0-42e3-49a4-91ae-50ddec46679e'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'c1d805a7-e990-4b72-bc1e-a5277b42983d'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'5be7a4b4-60e1-4c7e-88da-c5bb19e67b22'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'8ad67131-84fb-4710-a039-e5e5449e72d0'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'1d89e05b-0154-4734-b0f7-5eec61a48786'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'ce6502a3-0db0-4fb1-b052-d25a57d8c27b'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3b1aeb92-9c04-461e-b9af-7dce6c6af55d'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'dadfc124-13ce-4e27-80d1-ab93030cdf41'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'78c5a2fa-ba90-4fe2-a0ff-b6bb045cd9de'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'cf696499-220e-4009-a748-ab4cfde29976'),
('0c8dec44-f901-4a87-bc0e-632248fd4f06',	'cf696499-220e-4009-a748-ab4cfde29976'),
('0c8dec44-f901-4a87-bc0e-632248fd4f06',	'3b1aeb92-9c04-461e-b9af-7dce6c6af55d'),
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'ef6a5529-cbee-4828-8819-6eded5d57f9b'),
('c9903715-4b41-4af6-a372-ab5e84797e1a',	'dadfc124-13ce-4e27-80d1-ab93030cdf41'),
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'ae4198e3-6901-4de6-8e1a-26c0b83fa36e'),
('ae4198e3-6901-4de6-8e1a-26c0b83fa36e',	'c8847536-6b4a-4480-91c5-d28c2eeb56fc'),
('c5ed9d6c-4f52-4301-9447-2c178ec7951c',	'341d0a67-0409-4384-8b09-48400fce0d37'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'65e6bb97-cb8a-46a0-8d16-5e46801d9be3'),
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'0cfb9d96-369e-4b65-b60c-1500b24ea557'),
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'a408fb05-706e-4563-abe6-39792ab88136'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3ce733a0-9c79-42e9-9e6c-5b960b104bf9'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'7cae39b1-bded-4567-bc75-6add4b39dd1b'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'f1ebba88-0ef8-4a09-8aa5-96e3b5968af4'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'89613939-0ec8-4d17-9978-b7bb7d97727c'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'dd241ea7-fd3f-44da-897c-843852ac6e44'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3a75928e-5cb9-4cf8-a81d-30c297177e55'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'729452dd-d8af-40be-84c2-2bdbd1a2e3e6'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'b6f1a94d-9289-4881-9300-5e1931ddc4e3'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'30937504-ba38-443b-875b-ed13b17b8bc1'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'63e0f9ee-5024-4a05-803f-05face03226d'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'c27169c0-1618-426d-8fa4-6bbf9dcd8946'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'2eec05ab-bfc5-429f-bee4-fe095718040e'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'df057e1c-44e1-49e0-8041-6482745929f0'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'56a6c525-1588-4b78-8a12-524f86a539fc'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'31f96787-4506-48ca-b16f-fa41c4eaf503'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'0b137134-72bf-4417-92af-fa39a4453ced'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'8b1433bf-a11a-4cb5-9f16-5ea8162edb69'),
('89613939-0ec8-4d17-9978-b7bb7d97727c',	'31f96787-4506-48ca-b16f-fa41c4eaf503'),
('f1ebba88-0ef8-4a09-8aa5-96e3b5968af4',	'56a6c525-1588-4b78-8a12-524f86a539fc'),
('f1ebba88-0ef8-4a09-8aa5-96e3b5968af4',	'8b1433bf-a11a-4cb5-9f16-5ea8162edb69'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'6e6f3b57-7a47-4f2b-8a5b-868a3fd5adfb'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'577e2c92-dc43-4681-bae0-91c62278f6d8'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'e9e8f4a8-bfbd-4138-9108-d785f3c6af89'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'6c0d8cc5-9428-4369-a7f2-80ce1f947388'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'ad064d4b-bd17-4bcd-9535-785f9eb9f058'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'e083511b-a815-4feb-b696-92e138f3e57f'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'0db7a082-46b7-497e-8b05-82f15692af5a'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'cefb724f-b20f-4c32-9d3f-ef59f080b62d'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'ae098112-47bd-44e4-91e8-995514f57d0b'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'89b8329a-7a4d-4d60-a33f-8e69ff338bcd'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'6a7c29ff-14ba-4924-8306-4b51ac50c46c'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'98ec5874-6e72-4d91-9a9f-9697d401c57b'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'08a5c005-4972-45d8-86be-9ba35b025821'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'59e81c88-eb1f-4659-972d-fbd6a6b22c4d'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'26cafde3-be04-43bf-91f5-783d34ee874b'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'36a205bd-8165-4780-8213-b88993f9f65e'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'381d17b5-514c-4d3a-9334-83185a0e198f'),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'1b7b5636-d175-4c8b-9291-c0c53b01266f'),
('6c0d8cc5-9428-4369-a7f2-80ce1f947388',	'26cafde3-be04-43bf-91f5-783d34ee874b'),
('e9e8f4a8-bfbd-4138-9108-d785f3c6af89',	'59e81c88-eb1f-4659-972d-fbd6a6b22c4d'),
('e9e8f4a8-bfbd-4138-9108-d785f3c6af89',	'381d17b5-514c-4d3a-9334-83185a0e198f'),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'1d176cff-a3f8-46b6-8e2a-83e2e632ae5e'),
('1d176cff-a3f8-46b6-8e2a-83e2e632ae5e',	'52e96c23-f80b-4a60-9389-f63fe6962772'),
('3c17832c-575d-4c40-8b10-194253e623b7',	'ed22c8a6-2955-44b0-baf6-38c1108c314d'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'461358e9-90f0-451b-b093-2b776a0254d6'),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'5e51c6b7-f1a8-4539-b793-8a10152b08ed'),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'8eb5dc6b-437b-45ec-8777-bb027c945c76'),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'c581cfea-d582-4cca-9422-f5fd2e1fab18');

DROP TABLE IF EXISTS "credential";
CREATE TABLE "keycloak"."credential" (
    "id" character varying(36) NOT NULL,
    "salt" bytea,
    "type" character varying(255),
    "user_id" character varying(36),
    "created_date" bigint,
    "user_label" character varying(255),
    "secret_data" text,
    "credential_data" text,
    "priority" integer,
    CONSTRAINT "constraint_f" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_user_credential" ON "keycloak"."credential" USING btree ("user_id");

INSERT INTO "credential" ("id", "salt", "type", "user_id", "created_date", "user_label", "secret_data", "credential_data", "priority") VALUES
('b02389c2-3800-455b-a6ee-ede5a7172678',	NULL,	'password',	'46a90daa-ce2b-4701-bc29-deffbb3fb521',	1684608237177,	NULL,	'{"value":"si0yf90glD0YvSG+xa0Nm9sZ7Lgr82u0fWxQlufny5k=","salt":"JjXoD96L2Vj63BdVl5MBiQ==","additionalParameters":{}}',	'{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}',	10);

DROP TABLE IF EXISTS "databasechangelog";
CREATE TABLE "keycloak"."databasechangelog" (
    "id" character varying(255) NOT NULL,
    "author" character varying(255) NOT NULL,
    "filename" character varying(255) NOT NULL,
    "dateexecuted" timestamp NOT NULL,
    "orderexecuted" integer NOT NULL,
    "exectype" character varying(10) NOT NULL,
    "md5sum" character varying(35),
    "description" character varying(255),
    "comments" character varying(255),
    "tag" character varying(255),
    "liquibase" character varying(20),
    "contexts" character varying(255),
    "labels" character varying(255),
    "deployment_id" character varying(10)
) WITH (oids = false);

INSERT INTO "databasechangelog" ("id", "author", "filename", "dateexecuted", "orderexecuted", "exectype", "md5sum", "description", "comments", "tag", "liquibase", "contexts", "labels", "deployment_id") VALUES
('1.0.0.Final-KEYCLOAK-5461',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.0.0.Final.xml',	'2023-05-20 18:43:51.959881',	1,	'EXECUTED',	'8:bda77d94bf90182a1e30c24f1c155ec7',	'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.0.0.Final-KEYCLOAK-5461',	'sthorger@redhat.com',	'META-INF/db2-jpa-changelog-1.0.0.Final.xml',	'2023-05-20 18:43:51.974387',	2,	'MARK_RAN',	'8:1ecb330f30986693d1cba9ab579fa219',	'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.1.0.Beta1',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.1.0.Beta1.xml',	'2023-05-20 18:43:52.040288',	3,	'EXECUTED',	'8:cb7ace19bc6d959f305605d255d4c843',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.1.0.Final',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.1.0.Final.xml',	'2023-05-20 18:43:52.047387',	4,	'EXECUTED',	'8:80230013e961310e6872e871be424a63',	'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.2.0.Beta1',	'psilva@redhat.com',	'META-INF/jpa-changelog-1.2.0.Beta1.xml',	'2023-05-20 18:43:52.202063',	5,	'EXECUTED',	'8:67f4c20929126adc0c8e9bf48279d244',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.2.0.Beta1',	'psilva@redhat.com',	'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml',	'2023-05-20 18:43:52.207215',	6,	'MARK_RAN',	'8:7311018b0b8179ce14628ab412bb6783',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.2.0.RC1',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.2.0.CR1.xml',	'2023-05-20 18:43:52.365762',	7,	'EXECUTED',	'8:037ba1216c3640f8785ee6b8e7c8e3c1',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.2.0.RC1',	'bburke@redhat.com',	'META-INF/db2-jpa-changelog-1.2.0.CR1.xml',	'2023-05-20 18:43:52.369403',	8,	'MARK_RAN',	'8:7fe6ffe4af4df289b3157de32c624263',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.2.0.Final',	'keycloak',	'META-INF/jpa-changelog-1.2.0.Final.xml',	'2023-05-20 18:43:52.380051',	9,	'EXECUTED',	'8:9c136bc3187083a98745c7d03bc8a303',	'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.3.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.3.0.xml',	'2023-05-20 18:43:52.562519',	10,	'EXECUTED',	'8:b5f09474dca81fb56a97cf5b6553d331',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.4.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.4.0.xml',	'2023-05-20 18:43:52.661394',	11,	'EXECUTED',	'8:ca924f31bd2a3b219fdcfe78c82dacf4',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.4.0',	'bburke@redhat.com',	'META-INF/db2-jpa-changelog-1.4.0.xml',	'2023-05-20 18:43:52.666433',	12,	'MARK_RAN',	'8:8acad7483e106416bcfa6f3b824a16cd',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.5.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.5.0.xml',	'2023-05-20 18:43:52.692104',	13,	'EXECUTED',	'8:9b1266d17f4f87c78226f5055408fd5e',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.6.1_from15',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-05-20 18:43:52.730929',	14,	'EXECUTED',	'8:d80ec4ab6dbfe573550ff72396c7e910',	'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.6.1_from16-pre',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-05-20 18:43:52.734032',	15,	'MARK_RAN',	'8:d86eb172171e7c20b9c849b584d147b2',	'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.6.1_from16',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-05-20 18:43:52.738055',	16,	'MARK_RAN',	'8:5735f46f0fa60689deb0ecdc2a0dea22',	'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.6.1',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-05-20 18:43:52.743661',	17,	'EXECUTED',	'8:d41d8cd98f00b204e9800998ecf8427e',	'empty',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.7.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.7.0.xml',	'2023-05-20 18:43:52.824892',	18,	'EXECUTED',	'8:5c1a8fd2014ac7fc43b90a700f117b23',	'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.8.0',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.8.0.xml',	'2023-05-20 18:43:52.890217',	19,	'EXECUTED',	'8:1f6c2c2dfc362aff4ed75b3f0ef6b331',	'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.8.0-2',	'keycloak',	'META-INF/jpa-changelog-1.8.0.xml',	'2023-05-20 18:43:52.897298',	20,	'EXECUTED',	'8:dee9246280915712591f83a127665107',	'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.8.0',	'mposolda@redhat.com',	'META-INF/db2-jpa-changelog-1.8.0.xml',	'2023-05-20 18:43:52.901075',	21,	'MARK_RAN',	'8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a',	'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.8.0-2',	'keycloak',	'META-INF/db2-jpa-changelog-1.8.0.xml',	'2023-05-20 18:43:52.907049',	22,	'MARK_RAN',	'8:dee9246280915712591f83a127665107',	'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.9.0',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.9.0.xml',	'2023-05-20 18:43:52.938591',	23,	'EXECUTED',	'8:d9fa18ffa355320395b86270680dd4fe',	'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.9.1',	'keycloak',	'META-INF/jpa-changelog-1.9.1.xml',	'2023-05-20 18:43:52.949151',	24,	'EXECUTED',	'8:90cff506fedb06141ffc1c71c4a1214c',	'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.9.1',	'keycloak',	'META-INF/db2-jpa-changelog-1.9.1.xml',	'2023-05-20 18:43:52.9534',	25,	'MARK_RAN',	'8:11a788aed4961d6d29c427c063af828c',	'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('1.9.2',	'keycloak',	'META-INF/jpa-changelog-1.9.2.xml',	'2023-05-20 18:43:53.060951',	26,	'EXECUTED',	'8:a4218e51e1faf380518cce2af5d39b43',	'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-2.0.0',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-2.0.0.xml',	'2023-05-20 18:43:53.239334',	27,	'EXECUTED',	'8:d9e9a1bfaa644da9952456050f07bbdc',	'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-2.5.1',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-2.5.1.xml',	'2023-05-20 18:43:53.244966',	28,	'EXECUTED',	'8:d1bf991a6163c0acbfe664b615314505',	'update tableName=RESOURCE_SERVER_POLICY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.1.0-KEYCLOAK-5461',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.1.0.xml',	'2023-05-20 18:43:53.402282',	29,	'EXECUTED',	'8:88a743a1e87ec5e30bf603da68058a8c',	'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.2.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.2.0.xml',	'2023-05-20 18:43:53.431516',	30,	'EXECUTED',	'8:c5517863c875d325dea463d00ec26d7a',	'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.3.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.3.0.xml',	'2023-05-20 18:43:53.465',	31,	'EXECUTED',	'8:ada8b4833b74a498f376d7136bc7d327',	'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.4.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.4.0.xml',	'2023-05-20 18:43:53.473427',	32,	'EXECUTED',	'8:b9b73c8ea7299457f99fcbb825c263ba',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-05-20 18:43:53.483294',	33,	'EXECUTED',	'8:07724333e625ccfcfc5adc63d57314f3',	'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.0-unicode-oracle',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-05-20 18:43:53.486466',	34,	'MARK_RAN',	'8:8b6fd445958882efe55deb26fc541a7b',	'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.0-unicode-other-dbs',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-05-20 18:43:53.531621',	35,	'EXECUTED',	'8:29b29cfebfd12600897680147277a9d7',	'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.0-duplicate-email-support',	'slawomir@dabek.name',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-05-20 18:43:53.539696',	36,	'EXECUTED',	'8:73ad77ca8fd0410c7f9f15a471fa52bc',	'addColumn tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.0-unique-group-names',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-05-20 18:43:53.554305',	37,	'EXECUTED',	'8:64f27a6fdcad57f6f9153210f2ec1bdb',	'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('2.5.1',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.5.1.xml',	'2023-05-20 18:43:53.561493',	38,	'EXECUTED',	'8:27180251182e6c31846c2ddab4bc5781',	'addColumn tableName=FED_USER_CONSENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.0.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-3.0.0.xml',	'2023-05-20 18:43:53.568021',	39,	'EXECUTED',	'8:d56f201bfcfa7a1413eb3e9bc02978f9',	'addColumn tableName=IDENTITY_PROVIDER',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.2.0-fix',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-05-20 18:43:53.571235',	40,	'MARK_RAN',	'8:91f5522bf6afdc2077dfab57fbd3455c',	'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.2.0-fix-with-keycloak-5416',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-05-20 18:43:53.574803',	41,	'MARK_RAN',	'8:0f01b554f256c22caeb7d8aee3a1cdc8',	'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.2.0-fix-offline-sessions',	'hmlnarik',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-05-20 18:43:53.583748',	42,	'EXECUTED',	'8:ab91cf9cee415867ade0e2df9651a947',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.2.0-fixed',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-05-20 18:43:53.844745',	43,	'EXECUTED',	'8:ceac9b1889e97d602caf373eadb0d4b7',	'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.3.0',	'keycloak',	'META-INF/jpa-changelog-3.3.0.xml',	'2023-05-20 18:43:53.852242',	44,	'EXECUTED',	'8:84b986e628fe8f7fd8fd3c275c5259f2',	'addColumn tableName=USER_ENTITY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-3.4.0.CR1-resource-server-pk-change-part1',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-05-20 18:43:53.859807',	45,	'EXECUTED',	'8:a164ae073c56ffdbc98a615493609a52',	'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-05-20 18:43:53.866875',	46,	'EXECUTED',	'8:70a2b4f1f4bd4dbf487114bdb1810e64',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-05-20 18:43:53.870241',	47,	'MARK_RAN',	'8:7be68b71d2f5b94b8df2e824f2860fa2',	'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-05-20 18:43:53.938128',	48,	'EXECUTED',	'8:bab7c631093c3861d6cf6144cd944982',	'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authn-3.4.0.CR1-refresh-token-max-reuse',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-05-20 18:43:53.944738',	49,	'EXECUTED',	'8:fa809ac11877d74d76fe40869916daad',	'addColumn tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.4.0',	'keycloak',	'META-INF/jpa-changelog-3.4.0.xml',	'2023-05-20 18:43:54.02549',	50,	'EXECUTED',	'8:fac23540a40208f5f5e326f6ceb4d291',	'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.4.0-KEYCLOAK-5230',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-3.4.0.xml',	'2023-05-20 18:43:54.088896',	51,	'EXECUTED',	'8:2612d1b8a97e2b5588c346e817307593',	'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.4.1',	'psilva@redhat.com',	'META-INF/jpa-changelog-3.4.1.xml',	'2023-05-20 18:43:54.095233',	52,	'EXECUTED',	'8:9842f155c5db2206c88bcb5d1046e941',	'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.4.2',	'keycloak',	'META-INF/jpa-changelog-3.4.2.xml',	'2023-05-20 18:43:54.099751',	53,	'EXECUTED',	'8:2e12e06e45498406db72d5b3da5bbc76',	'update tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('3.4.2-KEYCLOAK-5172',	'mkanis@redhat.com',	'META-INF/jpa-changelog-3.4.2.xml',	'2023-05-20 18:43:54.105204',	54,	'EXECUTED',	'8:33560e7c7989250c40da3abdabdc75a4',	'update tableName=CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.0.0-KEYCLOAK-6335',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-05-20 18:43:54.117031',	55,	'EXECUTED',	'8:87a8d8542046817a9107c7eb9cbad1cd',	'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.0.0-CLEANUP-UNUSED-TABLE',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-05-20 18:43:54.124163',	56,	'EXECUTED',	'8:3ea08490a70215ed0088c273d776311e',	'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.0.0-KEYCLOAK-6228',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-05-20 18:43:54.160733',	57,	'EXECUTED',	'8:2d56697c8723d4592ab608ce14b6ed68',	'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.0.0-KEYCLOAK-5579-fixed',	'mposolda@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-05-20 18:43:54.293715',	58,	'EXECUTED',	'8:3e423e249f6068ea2bbe48bf907f9d86',	'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-4.0.0.CR1',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-4.0.0.CR1.xml',	'2023-05-20 18:43:54.329037',	59,	'EXECUTED',	'8:15cabee5e5df0ff099510a0fc03e4103',	'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-4.0.0.Beta3',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml',	'2023-05-20 18:43:54.338703',	60,	'EXECUTED',	'8:4b80200af916ac54d2ffbfc47918ab0e',	'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-4.2.0.Final',	'mhajas@redhat.com',	'META-INF/jpa-changelog-authz-4.2.0.Final.xml',	'2023-05-20 18:43:54.348464',	61,	'EXECUTED',	'8:66564cd5e168045d52252c5027485bbb',	'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-4.2.0.Final-KEYCLOAK-9944',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-authz-4.2.0.Final.xml',	'2023-05-20 18:43:54.362887',	62,	'EXECUTED',	'8:1c7064fafb030222be2bd16ccf690f6f',	'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.2.0-KEYCLOAK-6313',	'wadahiro@gmail.com',	'META-INF/jpa-changelog-4.2.0.xml',	'2023-05-20 18:43:54.371266',	63,	'EXECUTED',	'8:2de18a0dce10cdda5c7e65c9b719b6e5',	'addColumn tableName=REQUIRED_ACTION_PROVIDER',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.3.0-KEYCLOAK-7984',	'wadahiro@gmail.com',	'META-INF/jpa-changelog-4.3.0.xml',	'2023-05-20 18:43:54.377404',	64,	'EXECUTED',	'8:03e413dd182dcbd5c57e41c34d0ef682',	'update tableName=REQUIRED_ACTION_PROVIDER',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.6.0-KEYCLOAK-7950',	'psilva@redhat.com',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-05-20 18:43:54.381496',	65,	'EXECUTED',	'8:d27b42bb2571c18fbe3fe4e4fb7582a7',	'update tableName=RESOURCE_SERVER_RESOURCE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.6.0-KEYCLOAK-8377',	'keycloak',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-05-20 18:43:54.408265',	66,	'EXECUTED',	'8:698baf84d9fd0027e9192717c2154fb8',	'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.6.0-KEYCLOAK-8555',	'gideonray@gmail.com',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-05-20 18:43:54.419985',	67,	'EXECUTED',	'8:ced8822edf0f75ef26eb51582f9a821a',	'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.7.0-KEYCLOAK-1267',	'sguilhen@redhat.com',	'META-INF/jpa-changelog-4.7.0.xml',	'2023-05-20 18:43:54.427098',	68,	'EXECUTED',	'8:f0abba004cf429e8afc43056df06487d',	'addColumn tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.7.0-KEYCLOAK-7275',	'keycloak',	'META-INF/jpa-changelog-4.7.0.xml',	'2023-05-20 18:43:54.444943',	69,	'EXECUTED',	'8:6662f8b0b611caa359fcf13bf63b4e24',	'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('4.8.0-KEYCLOAK-8835',	'sguilhen@redhat.com',	'META-INF/jpa-changelog-4.8.0.xml',	'2023-05-20 18:43:54.454846',	70,	'EXECUTED',	'8:9e6b8009560f684250bdbdf97670d39e',	'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('authz-7.0.0-KEYCLOAK-10443',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-7.0.0.xml',	'2023-05-20 18:43:54.46212',	71,	'EXECUTED',	'8:4223f561f3b8dc655846562b57bb502e',	'addColumn tableName=RESOURCE_SERVER',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('8.0.0-adding-credential-columns',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-05-20 18:43:54.471991',	72,	'EXECUTED',	'8:215a31c398b363ce383a2b301202f29e',	'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('8.0.0-updating-credential-data-not-oracle-fixed',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-05-20 18:43:54.480111',	73,	'EXECUTED',	'8:83f7a671792ca98b3cbd3a1a34862d3d',	'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('8.0.0-updating-credential-data-oracle-fixed',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-05-20 18:43:54.48281',	74,	'MARK_RAN',	'8:f58ad148698cf30707a6efbdf8061aa7',	'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('8.0.0-credential-cleanup-fixed',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-05-20 18:43:54.501837',	75,	'EXECUTED',	'8:79e4fd6c6442980e58d52ffc3ee7b19c',	'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('8.0.0-resource-tag-support',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-05-20 18:43:54.516975',	76,	'EXECUTED',	'8:87af6a1e6d241ca4b15801d1f86a297d',	'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.0-always-display-client',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-05-20 18:43:54.523802',	77,	'EXECUTED',	'8:b44f8d9b7b6ea455305a6d72a200ed15',	'addColumn tableName=CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.0-drop-constraints-for-column-increase',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-05-20 18:43:54.526631',	78,	'MARK_RAN',	'8:2d8ed5aaaeffd0cb004c046b4a903ac5',	'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.0-increase-column-size-federated-fk',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-05-20 18:43:54.553155',	79,	'EXECUTED',	'8:e290c01fcbc275326c511633f6e2acde',	'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.0-recreate-constraints-after-column-increase',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-05-20 18:43:54.55593',	80,	'MARK_RAN',	'8:c9db8784c33cea210872ac2d805439f8',	'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.1-add-index-to-client.client_id',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-05-20 18:43:54.569026',	81,	'EXECUTED',	'8:95b676ce8fc546a1fcfb4c92fae4add5',	'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.1-KEYCLOAK-12579-drop-constraints',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-05-20 18:43:54.572068',	82,	'MARK_RAN',	'8:38a6b2a41f5651018b1aca93a41401e5',	'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.1-KEYCLOAK-12579-add-not-null-constraint',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-05-20 18:43:54.580385',	83,	'EXECUTED',	'8:3fb99bcad86a0229783123ac52f7609c',	'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.1-KEYCLOAK-12579-recreate-constraints',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-05-20 18:43:54.58405',	84,	'MARK_RAN',	'8:64f27a6fdcad57f6f9153210f2ec1bdb',	'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('9.0.1-add-index-to-events',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-05-20 18:43:54.598196',	85,	'EXECUTED',	'8:ab4f863f39adafd4c862f7ec01890abc',	'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('map-remove-ri',	'keycloak',	'META-INF/jpa-changelog-11.0.0.xml',	'2023-05-20 18:43:54.608347',	86,	'EXECUTED',	'8:13c419a0eb336e91ee3a3bf8fda6e2a7',	'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('map-remove-ri',	'keycloak',	'META-INF/jpa-changelog-12.0.0.xml',	'2023-05-20 18:43:54.634128',	87,	'EXECUTED',	'8:e3fb1e698e0471487f51af1ed80fe3ac',	'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('12.1.0-add-realm-localization-table',	'keycloak',	'META-INF/jpa-changelog-12.0.0.xml',	'2023-05-20 18:43:54.653348',	88,	'EXECUTED',	'8:babadb686aab7b56562817e60bf0abd0',	'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('default-roles',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.664827',	89,	'EXECUTED',	'8:72d03345fda8e2f17093d08801947773',	'addColumn tableName=REALM; customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('default-roles-cleanup',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.675884',	90,	'EXECUTED',	'8:61c9233951bd96ffecd9ba75f7d978a4',	'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('13.0.0-KEYCLOAK-16844',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.69147',	91,	'EXECUTED',	'8:ea82e6ad945cec250af6372767b25525',	'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('map-remove-ri-13.0.0',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.710877',	92,	'EXECUTED',	'8:d3f4a33f41d960ddacd7e2ef30d126b3',	'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('13.0.0-KEYCLOAK-17992-drop-constraints',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.714749',	93,	'MARK_RAN',	'8:1284a27fbd049d65831cb6fc07c8a783',	'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('13.0.0-increase-column-size-federated',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.730555',	94,	'EXECUTED',	'8:9d11b619db2ae27c25853b8a37cd0dea',	'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('13.0.0-KEYCLOAK-17992-recreate-constraints',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.733639',	95,	'MARK_RAN',	'8:3002bb3997451bb9e8bac5c5cd8d6327',	'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('json-string-accomodation-fixed',	'keycloak',	'META-INF/jpa-changelog-13.0.0.xml',	'2023-05-20 18:43:54.742909',	96,	'EXECUTED',	'8:dfbee0d6237a23ef4ccbb7a4e063c163',	'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('14.0.0-KEYCLOAK-11019',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.766909',	97,	'EXECUTED',	'8:75f3e372df18d38c62734eebb986b960',	'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('14.0.0-KEYCLOAK-18286',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.769913',	98,	'MARK_RAN',	'8:7fee73eddf84a6035691512c85637eef',	'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('14.0.0-KEYCLOAK-18286-revert',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.787899',	99,	'MARK_RAN',	'8:7a11134ab12820f999fbf3bb13c3adc8',	'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('14.0.0-KEYCLOAK-18286-supported-dbs',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.801909',	100,	'EXECUTED',	'8:c0f6eaac1f3be773ffe54cb5b8482b70',	'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('14.0.0-KEYCLOAK-18286-unsupported-dbs',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.806018',	101,	'MARK_RAN',	'8:18186f0008b86e0f0f49b0c4d0e842ac',	'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('KEYCLOAK-17267-add-index-to-user-attributes',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.822059',	102,	'EXECUTED',	'8:09c2780bcb23b310a7019d217dc7b433',	'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('KEYCLOAK-18146-add-saml-art-binding-identifier',	'keycloak',	'META-INF/jpa-changelog-14.0.0.xml',	'2023-05-20 18:43:54.830147',	103,	'EXECUTED',	'8:276a44955eab693c970a42880197fff2',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('15.0.0-KEYCLOAK-18467',	'keycloak',	'META-INF/jpa-changelog-15.0.0.xml',	'2023-05-20 18:43:54.84152',	104,	'EXECUTED',	'8:ba8ee3b694d043f2bfc1a1079d0760d7',	'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('17.0.0-9562',	'keycloak',	'META-INF/jpa-changelog-17.0.0.xml',	'2023-05-20 18:43:54.855803',	105,	'EXECUTED',	'8:5e06b1d75f5d17685485e610c2851b17',	'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('18.0.0-10625-IDX_ADMIN_EVENT_TIME',	'keycloak',	'META-INF/jpa-changelog-18.0.0.xml',	'2023-05-20 18:43:54.867077',	106,	'EXECUTED',	'8:4b80546c1dc550ac552ee7b24a4ab7c0',	'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('19.0.0-10135',	'keycloak',	'META-INF/jpa-changelog-19.0.0.xml',	'2023-05-20 18:43:54.873647',	107,	'EXECUTED',	'8:af510cd1bb2ab6339c45372f3e491696',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('20.0.0-12964-supported-dbs',	'keycloak',	'META-INF/jpa-changelog-20.0.0.xml',	'2023-05-20 18:43:54.884759',	108,	'EXECUTED',	'8:05c99fc610845ef66ee812b7921af0ef',	'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('20.0.0-12964-unsupported-dbs',	'keycloak',	'META-INF/jpa-changelog-20.0.0.xml',	'2023-05-20 18:43:54.887563',	109,	'MARK_RAN',	'8:314e803baf2f1ec315b3464e398b8247',	'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('client-attributes-string-accomodation-fixed',	'keycloak',	'META-INF/jpa-changelog-20.0.0.xml',	'2023-05-20 18:43:54.897094',	110,	'EXECUTED',	'8:56e4677e7e12556f70b604c573840100',	'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389'),
('21.0.2-17277',	'keycloak',	'META-INF/jpa-changelog-21.0.2.xml',	'2023-05-20 18:43:54.904979',	111,	'EXECUTED',	'8:8806cb33d2a546ce770384bf98cf6eac',	'customChange',	'',	NULL,	'4.16.1',	NULL,	NULL,	'4608231389');

DROP TABLE IF EXISTS "databasechangeloglock";
CREATE TABLE "keycloak"."databasechangeloglock" (
    "id" integer NOT NULL,
    "locked" boolean NOT NULL,
    "lockgranted" timestamp,
    "lockedby" character varying(255),
    CONSTRAINT "databasechangeloglock_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "databasechangeloglock" ("id", "locked", "lockgranted", "lockedby") VALUES
(1,	'f',	NULL,	NULL),
(1000,	'f',	NULL,	NULL),
(1001,	'f',	NULL,	NULL);

DROP TABLE IF EXISTS "default_client_scope";
CREATE TABLE "keycloak"."default_client_scope" (
    "realm_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    "default_scope" boolean DEFAULT false NOT NULL,
    CONSTRAINT "r_def_cli_scope_bind" PRIMARY KEY ("realm_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_defcls_realm" ON "keycloak"."default_client_scope" USING btree ("realm_id");

CREATE INDEX "idx_defcls_scope" ON "keycloak"."default_client_scope" USING btree ("scope_id");

INSERT INTO "default_client_scope" ("realm_id", "scope_id", "default_scope") VALUES
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'd872860d-41e8-477b-bed5-d9074f7d9bcf',	'f'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'7bb15574-854f-404e-b15f-3b778c68616e',	't'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'a94903d9-076e-47ce-b321-dfb303e90a4f',	't'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'b414de7d-0516-4817-a15c-3d0d80046c1c',	't'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4',	'f'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'58606ebd-dae9-4c91-8407-1659830db5aa',	'f'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'cee8ae8a-8f30-4c8f-9c45-c9870f228666',	't'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'818940b0-0544-4719-a439-6f1e40719b3c',	't'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'8f1541ef-95d2-4588-a428-ce52ed44794a',	'f'),
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'33f8c3bb-c72a-442c-a7cf-355d43a5f500',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f35882c0-132b-4b49-88cc-ac79015b5c60',	'f'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'38085e92-1c77-409d-b7f1-443fce561a67',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'37fe646b-2268-4cd0-9878-53c30f3a473a',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'51040b64-31ef-4eb3-9c91-1ee4395d1243',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'875c08ae-fd1a-458b-908f-d2a56c22a25f',	'f'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b',	'f'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'2dfcf2a6-0223-442b-9c69-005aee507e18',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'4362aabb-8316-456d-a4d1-e8d643297a35',	't'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd',	'f'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'786ed661-6c0b-470a-81ce-b68146494182',	't');

DROP TABLE IF EXISTS "event_entity";
CREATE TABLE "keycloak"."event_entity" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "details_json" character varying(2550),
    "error" character varying(255),
    "ip_address" character varying(255),
    "realm_id" character varying(255),
    "session_id" character varying(255),
    "event_time" bigint,
    "type" character varying(255),
    "user_id" character varying(255),
    CONSTRAINT "constraint_4" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_event_time" ON "keycloak"."event_entity" USING btree ("realm_id", "event_time");


DROP TABLE IF EXISTS "fed_user_attribute";
CREATE TABLE "keycloak"."fed_user_attribute" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "value" character varying(2024),
    CONSTRAINT "constr_fed_user_attr_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_attribute" ON "keycloak"."fed_user_attribute" USING btree ("user_id", "realm_id", "name");


DROP TABLE IF EXISTS "fed_user_consent";
CREATE TABLE "keycloak"."fed_user_consent" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "created_date" bigint,
    "last_updated_date" bigint,
    "client_storage_provider" character varying(36),
    "external_client_id" character varying(255),
    CONSTRAINT "constr_fed_user_consent_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_cnsnt_ext" ON "keycloak"."fed_user_consent" USING btree ("user_id", "client_storage_provider", "external_client_id");

CREATE INDEX "idx_fu_consent" ON "keycloak"."fed_user_consent" USING btree ("user_id", "client_id");

CREATE INDEX "idx_fu_consent_ru" ON "keycloak"."fed_user_consent" USING btree ("realm_id", "user_id");


DROP TABLE IF EXISTS "fed_user_consent_cl_scope";
CREATE TABLE "keycloak"."fed_user_consent_cl_scope" (
    "user_consent_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_fgrntcsnt_clsc_pm" PRIMARY KEY ("user_consent_id", "scope_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "fed_user_credential";
CREATE TABLE "keycloak"."fed_user_credential" (
    "id" character varying(36) NOT NULL,
    "salt" bytea,
    "type" character varying(255),
    "created_date" bigint,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "user_label" character varying(255),
    "secret_data" text,
    "credential_data" text,
    "priority" integer,
    CONSTRAINT "constr_fed_user_cred_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_credential" ON "keycloak"."fed_user_credential" USING btree ("user_id", "type");

CREATE INDEX "idx_fu_credential_ru" ON "keycloak"."fed_user_credential" USING btree ("realm_id", "user_id");


DROP TABLE IF EXISTS "fed_user_group_membership";
CREATE TABLE "keycloak"."fed_user_group_membership" (
    "group_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_user_group" PRIMARY KEY ("group_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_group_membership" ON "keycloak"."fed_user_group_membership" USING btree ("user_id", "group_id");

CREATE INDEX "idx_fu_group_membership_ru" ON "keycloak"."fed_user_group_membership" USING btree ("realm_id", "user_id");


DROP TABLE IF EXISTS "fed_user_required_action";
CREATE TABLE "keycloak"."fed_user_required_action" (
    "required_action" character varying(255) DEFAULT ' ' NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_required_action" PRIMARY KEY ("required_action", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_required_action" ON "keycloak"."fed_user_required_action" USING btree ("user_id", "required_action");

CREATE INDEX "idx_fu_required_action_ru" ON "keycloak"."fed_user_required_action" USING btree ("realm_id", "user_id");


DROP TABLE IF EXISTS "fed_user_role_mapping";
CREATE TABLE "keycloak"."fed_user_role_mapping" (
    "role_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_user_role" PRIMARY KEY ("role_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_role_mapping" ON "keycloak"."fed_user_role_mapping" USING btree ("user_id", "role_id");

CREATE INDEX "idx_fu_role_mapping_ru" ON "keycloak"."fed_user_role_mapping" USING btree ("realm_id", "user_id");


DROP TABLE IF EXISTS "federated_identity";
CREATE TABLE "keycloak"."federated_identity" (
    "identity_provider" character varying(255) NOT NULL,
    "realm_id" character varying(36),
    "federated_user_id" character varying(255),
    "federated_username" character varying(255),
    "token" text,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_40" PRIMARY KEY ("identity_provider", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fedidentity_feduser" ON "keycloak"."federated_identity" USING btree ("federated_user_id");

CREATE INDEX "idx_fedidentity_user" ON "keycloak"."federated_identity" USING btree ("user_id");


DROP TABLE IF EXISTS "federated_user";
CREATE TABLE "keycloak"."federated_user" (
    "id" character varying(255) NOT NULL,
    "storage_provider_id" character varying(255),
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constr_federated_user" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "group_attribute";
CREATE TABLE "keycloak"."group_attribute" (
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_group_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_group_att_by_name_value" ON "keycloak"."group_attribute" USING btree ("name");

CREATE INDEX "idx_group_attr_group" ON "keycloak"."group_attribute" USING btree ("group_id");


DROP TABLE IF EXISTS "group_role_mapping";
CREATE TABLE "keycloak"."group_role_mapping" (
    "role_id" character varying(36) NOT NULL,
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_group_role" PRIMARY KEY ("role_id", "group_id")
) WITH (oids = false);

CREATE INDEX "idx_group_role_mapp_group" ON "keycloak"."group_role_mapping" USING btree ("group_id");


DROP TABLE IF EXISTS "identity_provider";
CREATE TABLE "keycloak"."identity_provider" (
    "internal_id" character varying(36) NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "provider_alias" character varying(255),
    "provider_id" character varying(255),
    "store_token" boolean DEFAULT false NOT NULL,
    "authenticate_by_default" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36),
    "add_token_role" boolean DEFAULT true NOT NULL,
    "trust_email" boolean DEFAULT false NOT NULL,
    "first_broker_login_flow_id" character varying(36),
    "post_broker_login_flow_id" character varying(36),
    "provider_display_name" character varying(255),
    "link_only" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_2b" PRIMARY KEY ("internal_id"),
    CONSTRAINT "uk_2daelwnibji49avxsrtuf6xj33" UNIQUE ("provider_alias", "realm_id")
) WITH (oids = false);

CREATE INDEX "idx_ident_prov_realm" ON "keycloak"."identity_provider" USING btree ("realm_id");


DROP TABLE IF EXISTS "identity_provider_config";
CREATE TABLE "keycloak"."identity_provider_config" (
    "identity_provider_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_d" PRIMARY KEY ("identity_provider_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "identity_provider_mapper";
CREATE TABLE "keycloak"."identity_provider_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "idp_alias" character varying(255) NOT NULL,
    "idp_mapper_name" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_idpm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_id_prov_mapp_realm" ON "keycloak"."identity_provider_mapper" USING btree ("realm_id");


DROP TABLE IF EXISTS "idp_mapper_config";
CREATE TABLE "keycloak"."idp_mapper_config" (
    "idp_mapper_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_idpmconfig" PRIMARY KEY ("idp_mapper_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "keycloak_group";
CREATE TABLE "keycloak"."keycloak_group" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "parent_group" character varying(36) NOT NULL,
    "realm_id" character varying(36),
    CONSTRAINT "constraint_group" PRIMARY KEY ("id"),
    CONSTRAINT "sibling_names" UNIQUE ("realm_id", "parent_group", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "keycloak_role";
CREATE TABLE "keycloak"."keycloak_role" (
    "id" character varying(36) NOT NULL,
    "client_realm_constraint" character varying(255),
    "client_role" boolean DEFAULT false NOT NULL,
    "description" character varying(255),
    "name" character varying(255),
    "realm_id" character varying(255),
    "client" character varying(36),
    "realm" character varying(36),
    CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE ("name", "client_realm_constraint"),
    CONSTRAINT "constraint_a" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_keycloak_role_client" ON "keycloak"."keycloak_role" USING btree ("client");

CREATE INDEX "idx_keycloak_role_realm" ON "keycloak"."keycloak_role" USING btree ("realm");

INSERT INTO "keycloak_role" ("id", "client_realm_constraint", "client_role", "description", "name", "realm_id", "client", "realm") VALUES
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'${role_default-roles}',	'default-roles-master',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	NULL),
('49025ff7-1cf9-4e03-9539-d08d67f890b4',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'${role_create-realm}',	'create-realm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	NULL),
('4631c014-6e7b-4d12-a2ea-ec46515fa365',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_create-client}',	'create-client',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('3e35080a-8b4c-41ff-b4c3-c32d87c9c7ab',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-realm}',	'view-realm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('0c8dec44-f901-4a87-bc0e-632248fd4f06',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-users}',	'view-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('c9903715-4b41-4af6-a372-ab5e84797e1a',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-clients}',	'view-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('ecbf458f-a24d-4eb0-be9f-700bbaf59950',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-events}',	'view-events',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('82c8e1d1-fb47-4fb1-b49a-e4ff3b19a7f8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('1b952c2e-bb55-4f28-bd36-7dca81aedae3',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_view-authorization}',	'view-authorization',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('3a2c44c0-42e3-49a4-91ae-50ddec46679e',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-realm}',	'manage-realm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('c1d805a7-e990-4b72-bc1e-a5277b42983d',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-users}',	'manage-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('5be7a4b4-60e1-4c7e-88da-c5bb19e67b22',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-clients}',	'manage-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('8ad67131-84fb-4710-a039-e5e5449e72d0',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-events}',	'manage-events',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('1d89e05b-0154-4734-b0f7-5eec61a48786',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('ce6502a3-0db0-4fb1-b052-d25a57d8c27b',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_manage-authorization}',	'manage-authorization',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('3b1aeb92-9c04-461e-b9af-7dce6c6af55d',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_query-users}',	'query-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('dadfc124-13ce-4e27-80d1-ab93030cdf41',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_query-clients}',	'query-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('78c5a2fa-ba90-4fe2-a0ff-b6bb045cd9de',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_query-realms}',	'query-realms',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'${role_admin}',	'admin',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	NULL),
('cf696499-220e-4009-a748-ab4cfde29976',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_query-groups}',	'query-groups',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('ef6a5529-cbee-4828-8819-6eded5d57f9b',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_view-profile}',	'view-profile',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('ae4198e3-6901-4de6-8e1a-26c0b83fa36e',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_manage-account}',	'manage-account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('c8847536-6b4a-4480-91c5-d28c2eeb56fc',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_manage-account-links}',	'manage-account-links',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('19b45d91-285b-4cd7-acfe-baf76e3307e0',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_view-applications}',	'view-applications',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('341d0a67-0409-4384-8b09-48400fce0d37',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_view-consent}',	'view-consent',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('c5ed9d6c-4f52-4301-9447-2c178ec7951c',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_manage-consent}',	'manage-consent',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('f5c3454a-0f7f-41aa-bdb7-cf92f78058b0',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_view-groups}',	'view-groups',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('8712689f-a72d-4907-8c88-0be423a974c5',	'80f861e8-0c85-49f3-be78-6cf002723609',	't',	'${role_delete-account}',	'delete-account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'80f861e8-0c85-49f3-be78-6cf002723609',	NULL),
('56ce1c9d-0783-43a1-a8c2-c6263273dea0',	'5134a88f-62f8-4719-b81b-ebf025b29f47',	't',	'${role_read-token}',	'read-token',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'5134a88f-62f8-4719-b81b-ebf025b29f47',	NULL),
('65e6bb97-cb8a-46a0-8d16-5e46801d9be3',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	't',	'${role_impersonation}',	'impersonation',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	NULL),
('0cfb9d96-369e-4b65-b60c-1500b24ea557',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'${role_offline-access}',	'offline_access',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	NULL),
('a408fb05-706e-4563-abe6-39792ab88136',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'${role_uma_authorization}',	'uma_authorization',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	NULL,	NULL),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f',	'${role_default-roles}',	'default-roles-dms',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL,	NULL),
('3ce733a0-9c79-42e9-9e6c-5b960b104bf9',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_create-client}',	'create-client',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('7cae39b1-bded-4567-bc75-6add4b39dd1b',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-realm}',	'view-realm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('f1ebba88-0ef8-4a09-8aa5-96e3b5968af4',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-users}',	'view-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('89613939-0ec8-4d17-9978-b7bb7d97727c',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-clients}',	'view-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('dd241ea7-fd3f-44da-897c-843852ac6e44',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-events}',	'view-events',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('3a75928e-5cb9-4cf8-a81d-30c297177e55',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('729452dd-d8af-40be-84c2-2bdbd1a2e3e6',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_view-authorization}',	'view-authorization',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('b6f1a94d-9289-4881-9300-5e1931ddc4e3',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-realm}',	'manage-realm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('30937504-ba38-443b-875b-ed13b17b8bc1',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-users}',	'manage-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('63e0f9ee-5024-4a05-803f-05face03226d',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-clients}',	'manage-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('c27169c0-1618-426d-8fa4-6bbf9dcd8946',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-events}',	'manage-events',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('2eec05ab-bfc5-429f-bee4-fe095718040e',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('df057e1c-44e1-49e0-8041-6482745929f0',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_manage-authorization}',	'manage-authorization',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('56a6c525-1588-4b78-8a12-524f86a539fc',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_query-users}',	'query-users',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('31f96787-4506-48ca-b16f-fa41c4eaf503',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_query-clients}',	'query-clients',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('0b137134-72bf-4417-92af-fa39a4453ced',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_query-realms}',	'query-realms',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('8b1433bf-a11a-4cb5-9f16-5ea8162edb69',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_query-groups}',	'query-groups',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('21ceab8f-18e5-45b6-8709-4d0d2f046fdd',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_realm-admin}',	'realm-admin',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('6e6f3b57-7a47-4f2b-8a5b-868a3fd5adfb',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_create-client}',	'create-client',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('577e2c92-dc43-4681-bae0-91c62278f6d8',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-realm}',	'view-realm',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('e9e8f4a8-bfbd-4138-9108-d785f3c6af89',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-users}',	'view-users',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('6c0d8cc5-9428-4369-a7f2-80ce1f947388',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-clients}',	'view-clients',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('ad064d4b-bd17-4bcd-9535-785f9eb9f058',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-events}',	'view-events',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('e083511b-a815-4feb-b696-92e138f3e57f',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('0db7a082-46b7-497e-8b05-82f15692af5a',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_view-authorization}',	'view-authorization',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('cefb724f-b20f-4c32-9d3f-ef59f080b62d',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-realm}',	'manage-realm',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('ae098112-47bd-44e4-91e8-995514f57d0b',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-users}',	'manage-users',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('89b8329a-7a4d-4d60-a33f-8e69ff338bcd',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-clients}',	'manage-clients',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('6a7c29ff-14ba-4924-8306-4b51ac50c46c',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-events}',	'manage-events',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('98ec5874-6e72-4d91-9a9f-9697d401c57b',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('08a5c005-4972-45d8-86be-9ba35b025821',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_manage-authorization}',	'manage-authorization',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('59e81c88-eb1f-4659-972d-fbd6a6b22c4d',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_query-users}',	'query-users',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('26cafde3-be04-43bf-91f5-783d34ee874b',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_query-clients}',	'query-clients',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('36a205bd-8165-4780-8213-b88993f9f65e',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_query-realms}',	'query-realms',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('381d17b5-514c-4d3a-9334-83185a0e198f',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_query-groups}',	'query-groups',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('1b7b5636-d175-4c8b-9291-c0c53b01266f',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_view-profile}',	'view-profile',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('1d176cff-a3f8-46b6-8e2a-83e2e632ae5e',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_manage-account}',	'manage-account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('52e96c23-f80b-4a60-9389-f63fe6962772',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_manage-account-links}',	'manage-account-links',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('566bda7b-5a13-4511-8de5-2a2bd81a421f',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_view-applications}',	'view-applications',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('ed22c8a6-2955-44b0-baf6-38c1108c314d',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_view-consent}',	'view-consent',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('3c17832c-575d-4c40-8b10-194253e623b7',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_manage-consent}',	'manage-consent',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('0ebfb281-7c1b-4bd2-8a34-012589b35689',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_view-groups}',	'view-groups',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('c62e3a6f-c359-4800-921f-e8a8fcc43d5c',	'486d3b41-ec66-432b-b96b-c559447fd82e',	't',	'${role_delete-account}',	'delete-account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'486d3b41-ec66-432b-b96b-c559447fd82e',	NULL),
('461358e9-90f0-451b-b093-2b776a0254d6',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	't',	'${role_impersonation}',	'impersonation',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	NULL),
('5e51c6b7-f1a8-4539-b793-8a10152b08ed',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	't',	'${role_impersonation}',	'impersonation',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'00b17f71-6d04-492d-9a02-da855fdf96c3',	NULL),
('45595d34-7575-4b42-96f8-8d921636ba76',	'5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	't',	'${role_read-token}',	'read-token',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5c22622e-75b6-4b5a-a6c0-93ec4eef3969',	NULL),
('8eb5dc6b-437b-45ec-8777-bb027c945c76',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f',	'${role_offline-access}',	'offline_access',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL,	NULL),
('c581cfea-d582-4cca-9422-f5fd2e1fab18',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f',	'${role_uma_authorization}',	'uma_authorization',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	NULL,	NULL),
('e438e0bd-ce2e-4068-923c-5fc25b3939b8',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	't',	NULL,	'uma_protection',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL);

DROP TABLE IF EXISTS "migration_model";
CREATE TABLE "keycloak"."migration_model" (
    "id" character varying(36) NOT NULL,
    "version" character varying(36),
    "update_time" bigint DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_migmod" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_update_time" ON "keycloak"."migration_model" USING btree ("update_time");

INSERT INTO "migration_model" ("id", "version", "update_time") VALUES
('qvjdy',	'21.0.2',	1684608235);

DROP TABLE IF EXISTS "offline_client_session";
CREATE TABLE "keycloak"."offline_client_session" (
    "user_session_id" character varying(36) NOT NULL,
    "client_id" character varying(255) NOT NULL,
    "offline_flag" character varying(4) NOT NULL,
    "timestamp" integer,
    "data" text,
    "client_storage_provider" character varying(36) DEFAULT 'local' NOT NULL,
    "external_client_id" character varying(255) DEFAULT 'local' NOT NULL,
    CONSTRAINT "constraint_offl_cl_ses_pk3" PRIMARY KEY ("user_session_id", "client_id", "client_storage_provider", "external_client_id", "offline_flag")
) WITH (oids = false);

CREATE INDEX "idx_offline_css_preload" ON "keycloak"."offline_client_session" USING btree ("client_id", "offline_flag");

CREATE INDEX "idx_us_sess_id_on_cl_sess" ON "keycloak"."offline_client_session" USING btree ("user_session_id");


DROP TABLE IF EXISTS "offline_user_session";
CREATE TABLE "keycloak"."offline_user_session" (
    "user_session_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "created_on" integer NOT NULL,
    "offline_flag" character varying(4) NOT NULL,
    "data" text,
    "last_session_refresh" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_offl_us_ses_pk2" PRIMARY KEY ("user_session_id", "offline_flag")
) WITH (oids = false);

CREATE INDEX "idx_offline_uss_by_user" ON "keycloak"."offline_user_session" USING btree ("user_id", "realm_id", "offline_flag");

CREATE INDEX "idx_offline_uss_by_usersess" ON "keycloak"."offline_user_session" USING btree ("realm_id", "offline_flag", "user_session_id");

CREATE INDEX "idx_offline_uss_createdon" ON "keycloak"."offline_user_session" USING btree ("created_on");

CREATE INDEX "idx_offline_uss_preload" ON "keycloak"."offline_user_session" USING btree ("offline_flag", "created_on", "user_session_id");


DROP TABLE IF EXISTS "policy_config";
CREATE TABLE "keycloak"."policy_config" (
    "policy_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" text,
    CONSTRAINT "constraint_dpc" PRIMARY KEY ("policy_id", "name")
) WITH (oids = false);

INSERT INTO "policy_config" ("policy_id", "name", "value") VALUES
('538fb3fe-b812-444d-ac4b-ef6919b90546',	'code',	'// by default, grants any permission associated with this policy
$evaluation.grant();
'),
('42bce6be-b35f-4cc5-b8d7-7f788c13d621',	'defaultResourceType',	'urn:admin-cli:resources:default');

DROP TABLE IF EXISTS "protocol_mapper";
CREATE TABLE "keycloak"."protocol_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "protocol" character varying(255) NOT NULL,
    "protocol_mapper_name" character varying(255) NOT NULL,
    "client_id" character varying(36),
    "client_scope_id" character varying(36),
    CONSTRAINT "constraint_pcm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_clscope_protmap" ON "keycloak"."protocol_mapper" USING btree ("client_scope_id");

CREATE INDEX "idx_protocol_mapper_client" ON "keycloak"."protocol_mapper" USING btree ("client_id");

INSERT INTO "protocol_mapper" ("id", "name", "protocol", "protocol_mapper_name", "client_id", "client_scope_id") VALUES
('4ec8df35-a497-47a3-ac2c-964928805f66',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	'2ca60de6-7092-41cf-97f9-3a53324baeb5',	NULL),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	'15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	NULL),
('3fbb7b08-babf-4319-a53f-900d00b9589f',	'role list',	'saml',	'saml-role-list-mapper',	NULL,	'7bb15574-854f-404e-b15f-3b778c68616e'),
('415d92f6-82a6-4525-96dd-2384979b1a21',	'full name',	'openid-connect',	'oidc-full-name-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'family name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'given name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'middle name',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'nickname',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'username',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('148d4798-f823-44fa-8cec-38a587772474',	'profile',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'picture',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'website',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'gender',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'birthdate',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'zoneinfo',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'updated at',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'a94903d9-076e-47ce-b321-dfb303e90a4f'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'email',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'b414de7d-0516-4817-a15c-3d0d80046c1c'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'email verified',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'b414de7d-0516-4817-a15c-3d0d80046c1c'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'address',	'openid-connect',	'oidc-address-mapper',	NULL,	'6166fcdc-a5d4-4b75-9a1c-7e752d43e1f4'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'phone number',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'58606ebd-dae9-4c91-8407-1659830db5aa'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'phone number verified',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'58606ebd-dae9-4c91-8407-1659830db5aa'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'realm roles',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'cee8ae8a-8f30-4c8f-9c45-c9870f228666'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'client roles',	'openid-connect',	'oidc-usermodel-client-role-mapper',	NULL,	'cee8ae8a-8f30-4c8f-9c45-c9870f228666'),
('c062a00f-7717-4f1a-a4de-0b1818c40e50',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	NULL,	'cee8ae8a-8f30-4c8f-9c45-c9870f228666'),
('eb401dc5-c8d3-4507-b39f-2537bf631498',	'allowed web origins',	'openid-connect',	'oidc-allowed-origins-mapper',	NULL,	'818940b0-0544-4719-a439-6f1e40719b3c'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'upn',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'8f1541ef-95d2-4588-a428-ce52ed44794a'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'groups',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'8f1541ef-95d2-4588-a428-ce52ed44794a'),
('472574c5-7d44-433e-86cb-0d94b7257f47',	'acr loa level',	'openid-connect',	'oidc-acr-mapper',	NULL,	'33f8c3bb-c72a-442c-a7cf-355d43a5f500'),
('130822dc-7554-44af-9484-7c3851c648ac',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	'22833a2a-5856-4a1c-a559-155cb16b6ffa',	NULL),
('fd3f77cb-68fd-449a-b26d-787a7bc095de',	'role list',	'saml',	'saml-role-list-mapper',	NULL,	'38085e92-1c77-409d-b7f1-443fce561a67'),
('96762984-d25d-4b87-bb7d-b5359d500846',	'full name',	'openid-connect',	'oidc-full-name-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'family name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'given name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'middle name',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'nickname',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'username',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'profile',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'picture',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'website',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'gender',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'birthdate',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'zoneinfo',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('b4637781-2479-44db-ab7a-d045282f8520',	'updated at',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'37fe646b-2268-4cd0-9878-53c30f3a473a'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'email',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'51040b64-31ef-4eb3-9c91-1ee4395d1243'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'email verified',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'51040b64-31ef-4eb3-9c91-1ee4395d1243'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'address',	'openid-connect',	'oidc-address-mapper',	NULL,	'875c08ae-fd1a-458b-908f-d2a56c22a25f'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'phone number',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'phone number verified',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'5b2a4b90-2fbe-48c1-9ea8-34ab63a30f9b'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'realm roles',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'2dfcf2a6-0223-442b-9c69-005aee507e18'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'client roles',	'openid-connect',	'oidc-usermodel-client-role-mapper',	NULL,	'2dfcf2a6-0223-442b-9c69-005aee507e18'),
('5e724726-0e15-405c-bc11-d1a5fba2921a',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	NULL,	'2dfcf2a6-0223-442b-9c69-005aee507e18'),
('f9dbcfb1-aa82-4eea-81f7-4e6b6e6a23f9',	'allowed web origins',	'openid-connect',	'oidc-allowed-origins-mapper',	NULL,	'4362aabb-8316-456d-a4d1-e8d643297a35'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'upn',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'groups',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'9d1fb77d-adfe-4c6d-b7a7-ef139b6b4edd'),
('bf570f9f-19e2-458f-a168-8e899b7bf028',	'acr loa level',	'openid-connect',	'oidc-acr-mapper',	NULL,	'786ed661-6c0b-470a-81ce-b68146494182'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	'b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	NULL),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'Client ID',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'Client Host',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'Client IP Address',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL);

DROP TABLE IF EXISTS "protocol_mapper_config";
CREATE TABLE "keycloak"."protocol_mapper_config" (
    "protocol_mapper_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_pmconfig" PRIMARY KEY ("protocol_mapper_id", "name")
) WITH (oids = false);

INSERT INTO "protocol_mapper_config" ("protocol_mapper_id", "value", "name") VALUES
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'true',	'userinfo.token.claim'),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'locale',	'user.attribute'),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'true',	'id.token.claim'),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'true',	'access.token.claim'),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'locale',	'claim.name'),
('eae1dcb5-5f6a-4c6a-8ad1-34991c345f78',	'String',	'jsonType.label'),
('3fbb7b08-babf-4319-a53f-900d00b9589f',	'false',	'single'),
('3fbb7b08-babf-4319-a53f-900d00b9589f',	'Basic',	'attribute.nameformat'),
('3fbb7b08-babf-4319-a53f-900d00b9589f',	'Role',	'attribute.name'),
('148d4798-f823-44fa-8cec-38a587772474',	'true',	'userinfo.token.claim'),
('148d4798-f823-44fa-8cec-38a587772474',	'profile',	'user.attribute'),
('148d4798-f823-44fa-8cec-38a587772474',	'true',	'id.token.claim'),
('148d4798-f823-44fa-8cec-38a587772474',	'true',	'access.token.claim'),
('148d4798-f823-44fa-8cec-38a587772474',	'profile',	'claim.name'),
('148d4798-f823-44fa-8cec-38a587772474',	'String',	'jsonType.label'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'true',	'userinfo.token.claim'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'middleName',	'user.attribute'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'true',	'id.token.claim'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'true',	'access.token.claim'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'middle_name',	'claim.name'),
('2c427e0f-8bff-4fd3-9c30-7888ce6339d1',	'String',	'jsonType.label'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'true',	'userinfo.token.claim'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'username',	'user.attribute'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'true',	'id.token.claim'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'true',	'access.token.claim'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'preferred_username',	'claim.name'),
('412c1e0f-0e6a-4fe9-a376-96c287785486',	'String',	'jsonType.label'),
('415d92f6-82a6-4525-96dd-2384979b1a21',	'true',	'userinfo.token.claim'),
('415d92f6-82a6-4525-96dd-2384979b1a21',	'true',	'id.token.claim'),
('415d92f6-82a6-4525-96dd-2384979b1a21',	'true',	'access.token.claim'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'true',	'userinfo.token.claim'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'locale',	'user.attribute'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'true',	'id.token.claim'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'true',	'access.token.claim'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'locale',	'claim.name'),
('49a88482-b6e0-4af6-b8b0-a324e793a0f4',	'String',	'jsonType.label'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'true',	'userinfo.token.claim'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'zoneinfo',	'user.attribute'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'true',	'id.token.claim'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'true',	'access.token.claim'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'zoneinfo',	'claim.name'),
('64a683db-78c2-4cf0-886e-bbdc1d5287a8',	'String',	'jsonType.label'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'true',	'userinfo.token.claim'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'website',	'user.attribute'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'true',	'id.token.claim'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'true',	'access.token.claim'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'website',	'claim.name'),
('6b3aa163-6107-4a88-82d0-e2d3d846afdf',	'String',	'jsonType.label'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'true',	'userinfo.token.claim'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'picture',	'user.attribute'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'true',	'id.token.claim'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'true',	'access.token.claim'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'picture',	'claim.name'),
('6da29dbb-21ca-4fd8-83f4-0502570c83f5',	'String',	'jsonType.label'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'true',	'userinfo.token.claim'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'gender',	'user.attribute'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'true',	'id.token.claim'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'true',	'access.token.claim'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'gender',	'claim.name'),
('7c821f0e-5203-4e92-bdcf-73df23af4406',	'String',	'jsonType.label'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'true',	'userinfo.token.claim'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'lastName',	'user.attribute'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'true',	'id.token.claim'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'true',	'access.token.claim'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'family_name',	'claim.name'),
('82958032-deeb-4cd5-b286-5792e74a51a1',	'String',	'jsonType.label'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'true',	'userinfo.token.claim'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'firstName',	'user.attribute'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'true',	'id.token.claim'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'true',	'access.token.claim'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'given_name',	'claim.name'),
('96fd9c6b-8d81-493d-a378-b641527444e5',	'String',	'jsonType.label'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'true',	'userinfo.token.claim'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'birthdate',	'user.attribute'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'true',	'id.token.claim'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'true',	'access.token.claim'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'birthdate',	'claim.name'),
('b7a2903e-56bd-42da-9a85-233df5d0512e',	'String',	'jsonType.label'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'true',	'userinfo.token.claim'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'updatedAt',	'user.attribute'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'true',	'id.token.claim'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'true',	'access.token.claim'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'updated_at',	'claim.name'),
('d2cb381d-9784-4ea2-a7d4-3ee8a3a98da8',	'long',	'jsonType.label'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'true',	'userinfo.token.claim'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'nickname',	'user.attribute'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'true',	'id.token.claim'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'true',	'access.token.claim'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'nickname',	'claim.name'),
('dc2c3fac-e7db-4f97-8454-6db3a5d24a6b',	'String',	'jsonType.label'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'true',	'userinfo.token.claim'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'email',	'user.attribute'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'true',	'id.token.claim'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'true',	'access.token.claim'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'email',	'claim.name'),
('5514e30d-ba7d-4f59-8b8d-046c8ada9481',	'String',	'jsonType.label'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'true',	'userinfo.token.claim'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'emailVerified',	'user.attribute'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'true',	'id.token.claim'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'true',	'access.token.claim'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'email_verified',	'claim.name'),
('d589f497-fb40-43d2-bb58-5630f0107d97',	'boolean',	'jsonType.label'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'formatted',	'user.attribute.formatted'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'country',	'user.attribute.country'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'postal_code',	'user.attribute.postal_code'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'true',	'userinfo.token.claim'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'street',	'user.attribute.street'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'true',	'id.token.claim'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'region',	'user.attribute.region'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'true',	'access.token.claim'),
('3fbeeb18-bb4c-415d-8550-18107e60bf90',	'locality',	'user.attribute.locality'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'true',	'userinfo.token.claim'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'phoneNumberVerified',	'user.attribute'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'true',	'id.token.claim'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'true',	'access.token.claim'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'phone_number_verified',	'claim.name'),
('15267197-c0e8-4050-88b9-cf891d440b54',	'boolean',	'jsonType.label'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'true',	'userinfo.token.claim'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'phoneNumber',	'user.attribute'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'true',	'id.token.claim'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'true',	'access.token.claim'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'phone_number',	'claim.name'),
('e365f881-6f4b-4b64-8430-51a09dd3beb1',	'String',	'jsonType.label'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'true',	'multivalued'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'foo',	'user.attribute'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'true',	'access.token.claim'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'realm_access.roles',	'claim.name'),
('34068dc5-6997-48fc-b428-613abf343ea6',	'String',	'jsonType.label'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'true',	'multivalued'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'foo',	'user.attribute'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'true',	'access.token.claim'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'resource_access.${client_id}.roles',	'claim.name'),
('d8a97cda-f2f8-4b0c-b797-2f13d401d93a',	'String',	'jsonType.label'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'true',	'userinfo.token.claim'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'username',	'user.attribute'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'true',	'id.token.claim'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'true',	'access.token.claim'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'upn',	'claim.name'),
('d8b2395e-c02f-4666-8796-8855cf5d5a63',	'String',	'jsonType.label'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'true',	'multivalued'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'foo',	'user.attribute'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'true',	'id.token.claim'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'true',	'access.token.claim'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'groups',	'claim.name'),
('e8665dd6-9d1d-4ae6-b7c4-9477453a6af2',	'String',	'jsonType.label'),
('472574c5-7d44-433e-86cb-0d94b7257f47',	'true',	'id.token.claim'),
('472574c5-7d44-433e-86cb-0d94b7257f47',	'true',	'access.token.claim'),
('fd3f77cb-68fd-449a-b26d-787a7bc095de',	'false',	'single'),
('fd3f77cb-68fd-449a-b26d-787a7bc095de',	'Basic',	'attribute.nameformat'),
('fd3f77cb-68fd-449a-b26d-787a7bc095de',	'Role',	'attribute.name'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'true',	'userinfo.token.claim'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'lastName',	'user.attribute'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'true',	'id.token.claim'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'true',	'access.token.claim'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'family_name',	'claim.name'),
('20f17b0f-477e-4c06-a97b-b2a9d629ebf9',	'String',	'jsonType.label'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'true',	'userinfo.token.claim'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'gender',	'user.attribute'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'true',	'id.token.claim'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'true',	'access.token.claim'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'gender',	'claim.name'),
('3165a033-3aaa-499f-b59b-93f6f3e1f139',	'String',	'jsonType.label'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'true',	'userinfo.token.claim'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'profile',	'user.attribute'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'true',	'id.token.claim'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'true',	'access.token.claim'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'profile',	'claim.name'),
('3e176fd5-681d-4ffd-94b7-c6803d6c8898',	'String',	'jsonType.label'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'true',	'userinfo.token.claim'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'zoneinfo',	'user.attribute'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'true',	'id.token.claim'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'true',	'access.token.claim'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'zoneinfo',	'claim.name'),
('587d439c-dc4f-40fb-b7f4-fe48ddecc0e2',	'String',	'jsonType.label'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'true',	'userinfo.token.claim'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'birthdate',	'user.attribute'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'true',	'id.token.claim'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'true',	'access.token.claim'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'birthdate',	'claim.name'),
('5f5ba44c-44b0-4f25-a57b-e957834964b7',	'String',	'jsonType.label'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'true',	'userinfo.token.claim'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'nickname',	'user.attribute'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'true',	'id.token.claim'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'true',	'access.token.claim'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'nickname',	'claim.name'),
('7e22f861-e255-47d9-9e23-a7a33eeb8447',	'String',	'jsonType.label'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'true',	'userinfo.token.claim'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'website',	'user.attribute'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'true',	'id.token.claim'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'true',	'access.token.claim'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'website',	'claim.name'),
('80ee2178-5fe8-4907-bb79-ee96e8037397',	'String',	'jsonType.label'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'true',	'userinfo.token.claim'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'username',	'user.attribute'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'true',	'id.token.claim'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'true',	'access.token.claim'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'preferred_username',	'claim.name'),
('91dada47-6159-47ef-8ec7-ab0288eb3b63',	'String',	'jsonType.label'),
('96762984-d25d-4b87-bb7d-b5359d500846',	'true',	'userinfo.token.claim'),
('96762984-d25d-4b87-bb7d-b5359d500846',	'true',	'id.token.claim'),
('96762984-d25d-4b87-bb7d-b5359d500846',	'true',	'access.token.claim'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'true',	'userinfo.token.claim'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'picture',	'user.attribute'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'true',	'id.token.claim'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'true',	'access.token.claim'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'picture',	'claim.name'),
('9e06e45e-5af4-4dd1-b536-fb73071ccc9f',	'String',	'jsonType.label'),
('b4637781-2479-44db-ab7a-d045282f8520',	'true',	'userinfo.token.claim'),
('b4637781-2479-44db-ab7a-d045282f8520',	'updatedAt',	'user.attribute'),
('b4637781-2479-44db-ab7a-d045282f8520',	'true',	'id.token.claim'),
('b4637781-2479-44db-ab7a-d045282f8520',	'true',	'access.token.claim'),
('b4637781-2479-44db-ab7a-d045282f8520',	'updated_at',	'claim.name'),
('b4637781-2479-44db-ab7a-d045282f8520',	'long',	'jsonType.label'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'true',	'userinfo.token.claim'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'middleName',	'user.attribute'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'true',	'id.token.claim'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'true',	'access.token.claim'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'middle_name',	'claim.name'),
('c7a4469e-08e2-445a-88d9-3ede81799eb1',	'String',	'jsonType.label'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'true',	'userinfo.token.claim'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'locale',	'user.attribute'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'true',	'id.token.claim'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'true',	'access.token.claim'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'locale',	'claim.name'),
('d7213ad5-1ac5-44fc-9119-095d0ae904fb',	'String',	'jsonType.label'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'true',	'userinfo.token.claim'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'firstName',	'user.attribute'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'true',	'id.token.claim'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'true',	'access.token.claim'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'given_name',	'claim.name'),
('db6a2b4f-f6b6-4125-a458-a6d41b70727d',	'String',	'jsonType.label'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'true',	'userinfo.token.claim'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'email',	'user.attribute'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'true',	'id.token.claim'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'true',	'access.token.claim'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'email',	'claim.name'),
('2f878c29-3a0a-4a49-bd45-bbf1338c43f9',	'String',	'jsonType.label'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'true',	'userinfo.token.claim'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'emailVerified',	'user.attribute'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'true',	'id.token.claim'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'true',	'access.token.claim'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'email_verified',	'claim.name'),
('3a65c4f9-99e0-4f69-ab06-1d952ddfa34c',	'boolean',	'jsonType.label'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'formatted',	'user.attribute.formatted'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'country',	'user.attribute.country'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'postal_code',	'user.attribute.postal_code'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'true',	'userinfo.token.claim'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'street',	'user.attribute.street'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'true',	'id.token.claim'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'region',	'user.attribute.region'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'true',	'access.token.claim'),
('59d2a4a4-dee1-4455-bf45-44e6e7788a2c',	'locality',	'user.attribute.locality'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'true',	'userinfo.token.claim'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'phoneNumberVerified',	'user.attribute'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'true',	'id.token.claim'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'true',	'access.token.claim'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'phone_number_verified',	'claim.name'),
('60712c37-d1bd-4c53-934c-03a544e81d7f',	'boolean',	'jsonType.label'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'true',	'userinfo.token.claim'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'phoneNumber',	'user.attribute'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'true',	'id.token.claim'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'true',	'access.token.claim'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'phone_number',	'claim.name'),
('bbbaabf4-ed47-4405-8d0e-9aa92ee349eb',	'String',	'jsonType.label'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'true',	'multivalued'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'foo',	'user.attribute'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'true',	'access.token.claim'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'realm_access.roles',	'claim.name'),
('3f3c51ef-4ea3-4ee2-adcd-7be1ed78c3ea',	'String',	'jsonType.label'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'true',	'multivalued'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'foo',	'user.attribute'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'true',	'access.token.claim'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'resource_access.${client_id}.roles',	'claim.name'),
('ff6e2398-2002-433e-8475-61f36c35d0d8',	'String',	'jsonType.label'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'true',	'multivalued'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'foo',	'user.attribute'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'true',	'id.token.claim'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'true',	'access.token.claim'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'groups',	'claim.name'),
('af6a0944-ac22-420a-8e78-1fb50977b021',	'String',	'jsonType.label'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'true',	'userinfo.token.claim'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'username',	'user.attribute'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'true',	'id.token.claim'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'true',	'access.token.claim'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'upn',	'claim.name'),
('df6f8a95-9733-48e0-ba1a-0b2ee070234c',	'String',	'jsonType.label'),
('bf570f9f-19e2-458f-a168-8e899b7bf028',	'true',	'id.token.claim'),
('bf570f9f-19e2-458f-a168-8e899b7bf028',	'true',	'access.token.claim'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'true',	'userinfo.token.claim'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'locale',	'user.attribute'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'true',	'id.token.claim'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'true',	'access.token.claim'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'locale',	'claim.name'),
('0c9d03c1-13a7-4005-9eca-e636ce45d892',	'String',	'jsonType.label'),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'clientAddress',	'user.session.note'),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'true',	'id.token.claim'),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'true',	'access.token.claim'),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'clientAddress',	'claim.name'),
('285afc39-57f5-4842-b3e2-af92197a28f0',	'String',	'jsonType.label'),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'clientHost',	'user.session.note'),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'true',	'id.token.claim'),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'true',	'access.token.claim'),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'clientHost',	'claim.name'),
('2a409122-1793-4ec7-897d-7cb8d6dd473b',	'String',	'jsonType.label'),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'clientId',	'user.session.note'),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'true',	'id.token.claim'),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'true',	'access.token.claim'),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'clientId',	'claim.name'),
('e9c8f9cb-5531-458c-9ab7-8326b6c04ec9',	'String',	'jsonType.label');

DROP TABLE IF EXISTS "realm";
CREATE TABLE "keycloak"."realm" (
    "id" character varying(36) NOT NULL,
    "access_code_lifespan" integer,
    "user_action_lifespan" integer,
    "access_token_lifespan" integer,
    "account_theme" character varying(255),
    "admin_theme" character varying(255),
    "email_theme" character varying(255),
    "enabled" boolean DEFAULT false NOT NULL,
    "events_enabled" boolean DEFAULT false NOT NULL,
    "events_expiration" bigint,
    "login_theme" character varying(255),
    "name" character varying(255),
    "not_before" integer,
    "password_policy" character varying(2550),
    "registration_allowed" boolean DEFAULT false NOT NULL,
    "remember_me" boolean DEFAULT false NOT NULL,
    "reset_password_allowed" boolean DEFAULT false NOT NULL,
    "social" boolean DEFAULT false NOT NULL,
    "ssl_required" character varying(255),
    "sso_idle_timeout" integer,
    "sso_max_lifespan" integer,
    "update_profile_on_soc_login" boolean DEFAULT false NOT NULL,
    "verify_email" boolean DEFAULT false NOT NULL,
    "master_admin_client" character varying(36),
    "login_lifespan" integer,
    "internationalization_enabled" boolean DEFAULT false NOT NULL,
    "default_locale" character varying(255),
    "reg_email_as_username" boolean DEFAULT false NOT NULL,
    "admin_events_enabled" boolean DEFAULT false NOT NULL,
    "admin_events_details_enabled" boolean DEFAULT false NOT NULL,
    "edit_username_allowed" boolean DEFAULT false NOT NULL,
    "otp_policy_counter" integer DEFAULT '0',
    "otp_policy_window" integer DEFAULT '1',
    "otp_policy_period" integer DEFAULT '30',
    "otp_policy_digits" integer DEFAULT '6',
    "otp_policy_alg" character varying(36) DEFAULT 'HmacSHA1',
    "otp_policy_type" character varying(36) DEFAULT 'totp',
    "browser_flow" character varying(36),
    "registration_flow" character varying(36),
    "direct_grant_flow" character varying(36),
    "reset_credentials_flow" character varying(36),
    "client_auth_flow" character varying(36),
    "offline_session_idle_timeout" integer DEFAULT '0',
    "revoke_refresh_token" boolean DEFAULT false NOT NULL,
    "access_token_life_implicit" integer DEFAULT '0',
    "login_with_email_allowed" boolean DEFAULT true NOT NULL,
    "duplicate_emails_allowed" boolean DEFAULT false NOT NULL,
    "docker_auth_flow" character varying(36),
    "refresh_token_max_reuse" integer DEFAULT '0',
    "allow_user_managed_access" boolean DEFAULT false NOT NULL,
    "sso_max_lifespan_remember_me" integer DEFAULT '0' NOT NULL,
    "sso_idle_timeout_remember_me" integer DEFAULT '0' NOT NULL,
    "default_role" character varying(255),
    CONSTRAINT "constraint_4a" PRIMARY KEY ("id"),
    CONSTRAINT "uk_orvsdmla56612eaefiq6wl5oi" UNIQUE ("name")
) WITH (oids = false);

CREATE INDEX "idx_realm_master_adm_cli" ON "keycloak"."realm" USING btree ("master_admin_client");

INSERT INTO "realm" ("id", "access_code_lifespan", "user_action_lifespan", "access_token_lifespan", "account_theme", "admin_theme", "email_theme", "enabled", "events_enabled", "events_expiration", "login_theme", "name", "not_before", "password_policy", "registration_allowed", "remember_me", "reset_password_allowed", "social", "ssl_required", "sso_idle_timeout", "sso_max_lifespan", "update_profile_on_soc_login", "verify_email", "master_admin_client", "login_lifespan", "internationalization_enabled", "default_locale", "reg_email_as_username", "admin_events_enabled", "admin_events_details_enabled", "edit_username_allowed", "otp_policy_counter", "otp_policy_window", "otp_policy_period", "otp_policy_digits", "otp_policy_alg", "otp_policy_type", "browser_flow", "registration_flow", "direct_grant_flow", "reset_credentials_flow", "client_auth_flow", "offline_session_idle_timeout", "revoke_refresh_token", "access_token_life_implicit", "login_with_email_allowed", "duplicate_emails_allowed", "docker_auth_flow", "refresh_token_max_reuse", "allow_user_managed_access", "sso_max_lifespan_remember_me", "sso_idle_timeout_remember_me", "default_role") VALUES
('3be8f8be-092a-45c6-9bd9-e059158830c8',	60,	300,	60,	NULL,	NULL,	NULL,	't',	'f',	0,	NULL,	'master',	0,	NULL,	'f',	'f',	'f',	'f',	'EXTERNAL',	1800,	36000,	'f',	'f',	'ca28d79c-a08e-4ef7-af95-f99d20c3723e',	1800,	'f',	NULL,	'f',	'f',	'f',	'f',	0,	1,	30,	6,	'HmacSHA1',	'totp',	'80786489-3b12-4d31-9a7a-88fb7adcdc8a',	'ab39e9b2-b081-42c0-8dc2-da59862558a2',	'81c2cd16-064f-4d87-8680-688c9aaac6af',	'f1c25adc-d3dd-4222-8543-af350b2825da',	'0ef5166a-cb91-4072-b90b-b4e070a87563',	2592000,	'f',	900,	't',	'f',	'af6f290f-e174-4d32-a101-ea9dce0e306d',	0,	'f',	0,	0,	'8dfb5e7d-6705-4c67-b90c-f0eda3dac284'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	60,	300,	300,	NULL,	NULL,	NULL,	't',	'f',	0,	NULL,	'dms',	0,	NULL,	'f',	'f',	'f',	'f',	'EXTERNAL',	1800,	36000,	'f',	'f',	'fa552b48-cd6b-4eec-9f62-ae7f569e635a',	1800,	'f',	NULL,	'f',	'f',	'f',	'f',	0,	1,	30,	6,	'HmacSHA1',	'totp',	'100423f7-fd72-45ba-859e-a99d43615e99',	'0737f2a5-3cf4-40f9-864f-fd60b32e5064',	'0ef8713a-6476-4e51-a5c8-a25a42e9963a',	'c0177ef4-a7ac-4177-9e1b-9d9ac3058c3a',	'a6d8e6f9-568a-4c59-95fb-cec1c746d12f',	2592000,	'f',	900,	't',	'f',	'fb0a420f-e73a-4ea1-8e86-1cc9a61c35ce',	0,	'f',	0,	0,	'2160f19d-7a6e-4e01-85e9-31e68c5fc6b0');

DROP TABLE IF EXISTS "realm_attribute";
CREATE TABLE "keycloak"."realm_attribute" (
    "name" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "value" text,
    CONSTRAINT "constraint_9" PRIMARY KEY ("name", "realm_id")
) WITH (oids = false);

CREATE INDEX "idx_realm_attr_realm" ON "keycloak"."realm_attribute" USING btree ("realm_id");

INSERT INTO "realm_attribute" ("name", "realm_id", "value") VALUES
('_browser_header.contentSecurityPolicyReportOnly',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	''),
('_browser_header.xContentTypeOptions',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'nosniff'),
('_browser_header.xRobotsTag',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'none'),
('_browser_header.xFrameOptions',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'SAMEORIGIN'),
('_browser_header.contentSecurityPolicy',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';'),
('_browser_header.xXSSProtection',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'1; mode=block'),
('_browser_header.strictTransportSecurity',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'max-age=31536000; includeSubDomains'),
('bruteForceProtected',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'false'),
('permanentLockout',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'false'),
('maxFailureWaitSeconds',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'900'),
('minimumQuickLoginWaitSeconds',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'60'),
('waitIncrementSeconds',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'60'),
('quickLoginCheckMilliSeconds',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'1000'),
('maxDeltaTimeSeconds',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'43200'),
('failureFactor',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'30'),
('realmReusableOtpCode',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'false'),
('displayName',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'Keycloak'),
('displayNameHtml',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'<div class="kc-logo-text"><span>Keycloak</span></div>'),
('defaultSignatureAlgorithm',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'RS256'),
('offlineSessionMaxLifespanEnabled',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'false'),
('offlineSessionMaxLifespan',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'5184000'),
('_browser_header.contentSecurityPolicyReportOnly',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	''),
('_browser_header.xContentTypeOptions',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'nosniff'),
('_browser_header.xRobotsTag',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'none'),
('_browser_header.xFrameOptions',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'SAMEORIGIN'),
('_browser_header.contentSecurityPolicy',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';'),
('_browser_header.xXSSProtection',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'1; mode=block'),
('_browser_header.strictTransportSecurity',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'max-age=31536000; includeSubDomains'),
('bruteForceProtected',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('permanentLockout',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('maxFailureWaitSeconds',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'900'),
('minimumQuickLoginWaitSeconds',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'60'),
('waitIncrementSeconds',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'60'),
('quickLoginCheckMilliSeconds',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'1000'),
('maxDeltaTimeSeconds',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'43200'),
('failureFactor',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'30'),
('realmReusableOtpCode',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('defaultSignatureAlgorithm',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'RS256'),
('offlineSessionMaxLifespanEnabled',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('offlineSessionMaxLifespan',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5184000'),
('actionTokenGeneratedByAdminLifespan',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'43200'),
('actionTokenGeneratedByUserLifespan',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'300'),
('oauth2DeviceCodeLifespan',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'600'),
('oauth2DevicePollingInterval',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5'),
('webAuthnPolicyRpEntityName',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'keycloak'),
('webAuthnPolicySignatureAlgorithms',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'ES256'),
('webAuthnPolicyRpId',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	''),
('webAuthnPolicyAttestationConveyancePreference',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyAuthenticatorAttachment',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyRequireResidentKey',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyUserVerificationRequirement',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyCreateTimeout',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0'),
('webAuthnPolicyAvoidSameAuthenticatorRegister',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('webAuthnPolicyRpEntityNamePasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'keycloak'),
('webAuthnPolicySignatureAlgorithmsPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'ES256'),
('webAuthnPolicyRpIdPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	''),
('webAuthnPolicyAttestationConveyancePreferencePasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyAuthenticatorAttachmentPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyRequireResidentKeyPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyUserVerificationRequirementPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'not specified'),
('webAuthnPolicyCreateTimeoutPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'0'),
('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'false'),
('cibaBackchannelTokenDeliveryMode',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'poll'),
('cibaExpiresIn',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'120'),
('cibaInterval',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'5'),
('cibaAuthRequestedUserHint',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'login_hint'),
('parRequestUriLifespan',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'60');

DROP TABLE IF EXISTS "realm_default_groups";
CREATE TABLE "keycloak"."realm_default_groups" (
    "realm_id" character varying(36) NOT NULL,
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "con_group_id_def_groups" UNIQUE ("group_id"),
    CONSTRAINT "constr_realm_default_groups" PRIMARY KEY ("realm_id", "group_id")
) WITH (oids = false);

CREATE INDEX "idx_realm_def_grp_realm" ON "keycloak"."realm_default_groups" USING btree ("realm_id");


DROP TABLE IF EXISTS "realm_enabled_event_types";
CREATE TABLE "keycloak"."realm_enabled_event_types" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_enabl_event_types" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_evt_types_realm" ON "keycloak"."realm_enabled_event_types" USING btree ("realm_id");


DROP TABLE IF EXISTS "realm_events_listeners";
CREATE TABLE "keycloak"."realm_events_listeners" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_events_listeners" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_evt_list_realm" ON "keycloak"."realm_events_listeners" USING btree ("realm_id");

INSERT INTO "realm_events_listeners" ("realm_id", "value") VALUES
('3be8f8be-092a-45c6-9bd9-e059158830c8',	'jboss-logging'),
('ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'jboss-logging');

DROP TABLE IF EXISTS "realm_localizations";
CREATE TABLE "keycloak"."realm_localizations" (
    "realm_id" character varying(255) NOT NULL,
    "locale" character varying(255) NOT NULL,
    "texts" text NOT NULL,
    CONSTRAINT "realm_localizations_pkey" PRIMARY KEY ("realm_id", "locale")
) WITH (oids = false);


DROP TABLE IF EXISTS "realm_required_credential";
CREATE TABLE "keycloak"."realm_required_credential" (
    "type" character varying(255) NOT NULL,
    "form_label" character varying(255),
    "input" boolean DEFAULT false NOT NULL,
    "secret" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_92" PRIMARY KEY ("realm_id", "type")
) WITH (oids = false);

INSERT INTO "realm_required_credential" ("type", "form_label", "input", "secret", "realm_id") VALUES
('password',	'password',	't',	't',	'3be8f8be-092a-45c6-9bd9-e059158830c8'),
('password',	'password',	't',	't',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0');

DROP TABLE IF EXISTS "realm_smtp_config";
CREATE TABLE "keycloak"."realm_smtp_config" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_e" PRIMARY KEY ("realm_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "realm_supported_locales";
CREATE TABLE "keycloak"."realm_supported_locales" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_supported_locales" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_supp_local_realm" ON "keycloak"."realm_supported_locales" USING btree ("realm_id");


DROP TABLE IF EXISTS "redirect_uris";
CREATE TABLE "keycloak"."redirect_uris" (
    "client_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_redirect_uris" PRIMARY KEY ("client_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_redir_uri_client" ON "keycloak"."redirect_uris" USING btree ("client_id");

INSERT INTO "redirect_uris" ("client_id", "value") VALUES
('80f861e8-0c85-49f3-be78-6cf002723609',	'/realms/master/account/*'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'/realms/master/account/*'),
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'/admin/master/console/*'),
('486d3b41-ec66-432b-b96b-c559447fd82e',	'/realms/dms/account/*'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'/realms/dms/account/*'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'/admin/dms/console/*');

DROP TABLE IF EXISTS "required_action_config";
CREATE TABLE "keycloak"."required_action_config" (
    "required_action_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_req_act_cfg_pk" PRIMARY KEY ("required_action_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "required_action_provider";
CREATE TABLE "keycloak"."required_action_provider" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "name" character varying(255),
    "realm_id" character varying(36),
    "enabled" boolean DEFAULT false NOT NULL,
    "default_action" boolean DEFAULT false NOT NULL,
    "provider_id" character varying(255),
    "priority" integer,
    CONSTRAINT "constraint_req_act_prv_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_req_act_prov_realm" ON "keycloak"."required_action_provider" USING btree ("realm_id");

INSERT INTO "required_action_provider" ("id", "alias", "name", "realm_id", "enabled", "default_action", "provider_id", "priority") VALUES
('6721b6db-e5bc-4e55-80e2-a1d00a63dda6',	'VERIFY_EMAIL',	'Verify Email',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'VERIFY_EMAIL',	50),
('4a2a52c2-10d8-4bfd-95c7-aae5afe70d5f',	'UPDATE_PROFILE',	'Update Profile',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'UPDATE_PROFILE',	40),
('a92aa297-0362-4243-82a9-4f8af31a79bc',	'CONFIGURE_TOTP',	'Configure OTP',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'CONFIGURE_TOTP',	10),
('0e61062c-84cb-4465-96f8-1b590f462011',	'UPDATE_PASSWORD',	'Update Password',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'UPDATE_PASSWORD',	30),
('87270ac7-8a2c-403a-b492-ea3e611ce375',	'TERMS_AND_CONDITIONS',	'Terms and Conditions',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'f',	'TERMS_AND_CONDITIONS',	20),
('c8784abb-2415-4c12-96ea-8c64f385ca44',	'delete_account',	'Delete Account',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'f',	'f',	'delete_account',	60),
('70898b45-1c8d-4dce-9442-5f477bd18982',	'update_user_locale',	'Update User Locale',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'update_user_locale',	1000),
('34e2ef5d-d6c1-48ae-80b4-460963178a8b',	'webauthn-register',	'Webauthn Register',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'webauthn-register',	70),
('b9169f18-24c6-457b-9b7b-db99dc5c47c0',	'webauthn-register-passwordless',	'Webauthn Register Passwordless',	'3be8f8be-092a-45c6-9bd9-e059158830c8',	't',	'f',	'webauthn-register-passwordless',	80),
('aa9083db-a3e3-49b7-9606-83b83a3faef0',	'VERIFY_EMAIL',	'Verify Email',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'VERIFY_EMAIL',	50),
('dc70f3e1-a110-44c7-8abc-d2b9d14f687e',	'UPDATE_PROFILE',	'Update Profile',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'UPDATE_PROFILE',	40),
('78f2bf86-c1dd-4e7e-aa43-0e3cdb840de8',	'CONFIGURE_TOTP',	'Configure OTP',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'CONFIGURE_TOTP',	10),
('9fcc6dda-e51e-4ad7-b275-aca8f78943e4',	'UPDATE_PASSWORD',	'Update Password',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'UPDATE_PASSWORD',	30),
('63b8f278-2036-4630-976a-1a3c9ca69f39',	'TERMS_AND_CONDITIONS',	'Terms and Conditions',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f',	'f',	'TERMS_AND_CONDITIONS',	20),
('52e849e4-ac02-4f33-b8d0-cf4c1120dfbd',	'delete_account',	'Delete Account',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'f',	'f',	'delete_account',	60),
('b85d1d0c-4f0b-44c7-854f-17ee7e37132b',	'update_user_locale',	'Update User Locale',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'update_user_locale',	1000),
('8c56cd89-c16b-4f05-a672-c0b394b752cf',	'webauthn-register',	'Webauthn Register',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'webauthn-register',	70),
('5a5952a6-371f-421d-8a9f-1e2cbaa831f7',	'webauthn-register-passwordless',	'Webauthn Register Passwordless',	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	't',	'f',	'webauthn-register-passwordless',	80);

DROP TABLE IF EXISTS "resource_attribute";
CREATE TABLE "keycloak"."resource_attribute" (
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "resource_id" character varying(36) NOT NULL,
    CONSTRAINT "res_attr_pk" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "resource_policy";
CREATE TABLE "keycloak"."resource_policy" (
    "resource_id" character varying(36) NOT NULL,
    "policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrpp" PRIMARY KEY ("resource_id", "policy_id")
) WITH (oids = false);

CREATE INDEX "idx_res_policy_policy" ON "keycloak"."resource_policy" USING btree ("policy_id");


DROP TABLE IF EXISTS "resource_scope";
CREATE TABLE "keycloak"."resource_scope" (
    "resource_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrsp" PRIMARY KEY ("resource_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_res_scope_scope" ON "keycloak"."resource_scope" USING btree ("scope_id");


DROP TABLE IF EXISTS "resource_server";
CREATE TABLE "keycloak"."resource_server" (
    "id" character varying(36) NOT NULL,
    "allow_rs_remote_mgmt" boolean DEFAULT false NOT NULL,
    "policy_enforce_mode" character varying(15) NOT NULL,
    "decision_strategy" smallint DEFAULT '1' NOT NULL,
    CONSTRAINT "pk_resource_server" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "resource_server" ("id", "allow_rs_remote_mgmt", "policy_enforce_mode", "decision_strategy") VALUES
('c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	't',	'0',	1);

DROP TABLE IF EXISTS "resource_server_perm_ticket";
CREATE TABLE "keycloak"."resource_server_perm_ticket" (
    "id" character varying(36) NOT NULL,
    "owner" character varying(255) NOT NULL,
    "requester" character varying(255) NOT NULL,
    "created_timestamp" bigint NOT NULL,
    "granted_timestamp" bigint,
    "resource_id" character varying(36) NOT NULL,
    "scope_id" character varying(36),
    "resource_server_id" character varying(36) NOT NULL,
    "policy_id" character varying(36),
    CONSTRAINT "constraint_fapmt" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsr6t700s9v50bu18ws5pmt" UNIQUE ("owner", "requester", "resource_server_id", "resource_id", "scope_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "resource_server_policy";
CREATE TABLE "keycloak"."resource_server_policy" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "description" character varying(255),
    "type" character varying(255) NOT NULL,
    "decision_strategy" character varying(20),
    "logic" character varying(20),
    "resource_server_id" character varying(36) NOT NULL,
    "owner" character varying(255),
    CONSTRAINT "constraint_farsrp" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsrpt700s9v50bu18ws5ha6" UNIQUE ("name", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_serv_pol_res_serv" ON "keycloak"."resource_server_policy" USING btree ("resource_server_id");

INSERT INTO "resource_server_policy" ("id", "name", "description", "type", "decision_strategy", "logic", "resource_server_id", "owner") VALUES
('538fb3fe-b812-444d-ac4b-ef6919b90546',	'Default Policy',	'A policy that grants access only for users within this realm',	'js',	'0',	'0',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL),
('42bce6be-b35f-4cc5-b8d7-7f788c13d621',	'Default Permission',	'A permission that applies to the default resource type',	'resource',	'1',	'0',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	NULL);

DROP TABLE IF EXISTS "resource_server_resource";
CREATE TABLE "keycloak"."resource_server_resource" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(255),
    "icon_uri" character varying(255),
    "owner" character varying(255) NOT NULL,
    "resource_server_id" character varying(36) NOT NULL,
    "owner_managed_access" boolean DEFAULT false NOT NULL,
    "display_name" character varying(255),
    CONSTRAINT "constraint_farsr" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsr6t700s9v50bu18ws5ha6" UNIQUE ("name", "owner", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_srv_res_res_srv" ON "keycloak"."resource_server_resource" USING btree ("resource_server_id");

INSERT INTO "resource_server_resource" ("id", "name", "type", "icon_uri", "owner", "resource_server_id", "owner_managed_access", "display_name") VALUES
('42567ae7-f379-4eea-aae2-a52147394042',	'Default Resource',	'urn:admin-cli:resources:default',	NULL,	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	'f',	NULL);

DROP TABLE IF EXISTS "resource_server_scope";
CREATE TABLE "keycloak"."resource_server_scope" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "icon_uri" character varying(255),
    "resource_server_id" character varying(36) NOT NULL,
    "display_name" character varying(255),
    CONSTRAINT "constraint_farsrs" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsrst700s9v50bu18ws5ha6" UNIQUE ("name", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_srv_scope_res_srv" ON "keycloak"."resource_server_scope" USING btree ("resource_server_id");


DROP TABLE IF EXISTS "resource_uris";
CREATE TABLE "keycloak"."resource_uris" (
    "resource_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_resour_uris_pk" PRIMARY KEY ("resource_id", "value")
) WITH (oids = false);

INSERT INTO "resource_uris" ("resource_id", "value") VALUES
('42567ae7-f379-4eea-aae2-a52147394042',	'/*');

DROP TABLE IF EXISTS "role_attribute";
CREATE TABLE "keycloak"."role_attribute" (
    "id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    CONSTRAINT "constraint_role_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_role_attribute" ON "keycloak"."role_attribute" USING btree ("role_id");


DROP TABLE IF EXISTS "scope_mapping";
CREATE TABLE "keycloak"."scope_mapping" (
    "client_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_81" PRIMARY KEY ("client_id", "role_id")
) WITH (oids = false);

CREATE INDEX "idx_scope_mapping_role" ON "keycloak"."scope_mapping" USING btree ("role_id");

INSERT INTO "scope_mapping" ("client_id", "role_id") VALUES
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'f5c3454a-0f7f-41aa-bdb7-cf92f78058b0'),
('2ca60de6-7092-41cf-97f9-3a53324baeb5',	'ae4198e3-6901-4de6-8e1a-26c0b83fa36e'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'1d176cff-a3f8-46b6-8e2a-83e2e632ae5e'),
('22833a2a-5856-4a1c-a559-155cb16b6ffa',	'0ebfb281-7c1b-4bd2-8a34-012589b35689');

DROP TABLE IF EXISTS "scope_policy";
CREATE TABLE "keycloak"."scope_policy" (
    "scope_id" character varying(36) NOT NULL,
    "policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrsps" PRIMARY KEY ("scope_id", "policy_id")
) WITH (oids = false);

CREATE INDEX "idx_scope_policy_policy" ON "keycloak"."scope_policy" USING btree ("policy_id");


DROP TABLE IF EXISTS "user_attribute";
CREATE TABLE "keycloak"."user_attribute" (
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "user_id" character varying(36) NOT NULL,
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    CONSTRAINT "constraint_user_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_user_attribute" ON "keycloak"."user_attribute" USING btree ("user_id");

CREATE INDEX "idx_user_attribute_name" ON "keycloak"."user_attribute" USING btree ("name", "value");


DROP TABLE IF EXISTS "user_consent";
CREATE TABLE "keycloak"."user_consent" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "user_id" character varying(36) NOT NULL,
    "created_date" bigint,
    "last_updated_date" bigint,
    "client_storage_provider" character varying(36),
    "external_client_id" character varying(255),
    CONSTRAINT "constraint_grntcsnt_pm" PRIMARY KEY ("id"),
    CONSTRAINT "uk_jkuwuvd56ontgsuhogm8uewrt" UNIQUE ("client_id", "client_storage_provider", "external_client_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_consent" ON "keycloak"."user_consent" USING btree ("user_id");


DROP TABLE IF EXISTS "user_consent_client_scope";
CREATE TABLE "keycloak"."user_consent_client_scope" (
    "user_consent_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_grntcsnt_clsc_pm" PRIMARY KEY ("user_consent_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_usconsent_clscope" ON "keycloak"."user_consent_client_scope" USING btree ("user_consent_id");


DROP TABLE IF EXISTS "user_entity";
CREATE TABLE "keycloak"."user_entity" (
    "id" character varying(36) NOT NULL,
    "email" character varying(255),
    "email_constraint" character varying(255),
    "email_verified" boolean DEFAULT false NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "federation_link" character varying(255),
    "first_name" character varying(255),
    "last_name" character varying(255),
    "realm_id" character varying(255),
    "username" character varying(255),
    "created_timestamp" bigint,
    "service_account_client_link" character varying(255),
    "not_before" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_fb" PRIMARY KEY ("id"),
    CONSTRAINT "uk_dykn684sl8up1crfei6eckhd7" UNIQUE ("realm_id", "email_constraint"),
    CONSTRAINT "uk_ru8tt6t700s9v50bu18ws5ha6" UNIQUE ("realm_id", "username")
) WITH (oids = false);

CREATE INDEX "idx_user_email" ON "keycloak"."user_entity" USING btree ("email");

CREATE INDEX "idx_user_service_account" ON "keycloak"."user_entity" USING btree ("realm_id", "service_account_client_link");

INSERT INTO "user_entity" ("id", "email", "email_constraint", "email_verified", "enabled", "federation_link", "first_name", "last_name", "realm_id", "username", "created_timestamp", "service_account_client_link", "not_before") VALUES
('46a90daa-ce2b-4701-bc29-deffbb3fb521',	NULL,	'2c9d8937-2ea0-49a1-b476-09dc6ff54115',	'f',	't',	NULL,	NULL,	NULL,	'3be8f8be-092a-45c6-9bd9-e059158830c8',	'admin',	1684608237063,	NULL,	0),
('99399e75-f045-4820-99e6-d10c82950575',	NULL,	'f21be9f6-6a5f-4aa5-a072-649b847f20c3',	'f',	't',	NULL,	NULL,	NULL,	'ebbbe159-99b4-4a9e-b5da-0fdbf00c0da0',	'service-account-admin-cli',	1684610990890,	'c6a28b98-dcdc-42d1-9e92-25a9fb74ab8b',	0);

DROP TABLE IF EXISTS "user_federation_config";
CREATE TABLE "keycloak"."user_federation_config" (
    "user_federation_provider_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_f9" PRIMARY KEY ("user_federation_provider_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "user_federation_mapper";
CREATE TABLE "keycloak"."user_federation_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "federation_provider_id" character varying(36) NOT NULL,
    "federation_mapper_type" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_fedmapperpm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_usr_fed_map_fed_prv" ON "keycloak"."user_federation_mapper" USING btree ("federation_provider_id");

CREATE INDEX "idx_usr_fed_map_realm" ON "keycloak"."user_federation_mapper" USING btree ("realm_id");


DROP TABLE IF EXISTS "user_federation_mapper_config";
CREATE TABLE "keycloak"."user_federation_mapper_config" (
    "user_federation_mapper_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_fedmapper_cfg_pm" PRIMARY KEY ("user_federation_mapper_id", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "user_federation_provider";
CREATE TABLE "keycloak"."user_federation_provider" (
    "id" character varying(36) NOT NULL,
    "changed_sync_period" integer,
    "display_name" character varying(255),
    "full_sync_period" integer,
    "last_sync" integer,
    "priority" integer,
    "provider_name" character varying(255),
    "realm_id" character varying(36),
    CONSTRAINT "constraint_5c" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_usr_fed_prv_realm" ON "keycloak"."user_federation_provider" USING btree ("realm_id");


DROP TABLE IF EXISTS "user_group_membership";
CREATE TABLE "keycloak"."user_group_membership" (
    "group_id" character varying(36) NOT NULL,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_user_group" PRIMARY KEY ("group_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_group_mapping" ON "keycloak"."user_group_membership" USING btree ("user_id");


DROP TABLE IF EXISTS "user_required_action";
CREATE TABLE "keycloak"."user_required_action" (
    "user_id" character varying(36) NOT NULL,
    "required_action" character varying(255) DEFAULT ' ' NOT NULL,
    CONSTRAINT "constraint_required_action" PRIMARY KEY ("required_action", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_reqactions" ON "keycloak"."user_required_action" USING btree ("user_id");


DROP TABLE IF EXISTS "user_role_mapping";
CREATE TABLE "keycloak"."user_role_mapping" (
    "role_id" character varying(255) NOT NULL,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_c" PRIMARY KEY ("role_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_role_mapping" ON "keycloak"."user_role_mapping" USING btree ("user_id");

INSERT INTO "user_role_mapping" ("role_id", "user_id") VALUES
('8dfb5e7d-6705-4c67-b90c-f0eda3dac284',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('8dce4634-d68c-46be-99a4-6a30d4e9f9fe',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('3ce733a0-9c79-42e9-9e6c-5b960b104bf9',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('7cae39b1-bded-4567-bc75-6add4b39dd1b',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('f1ebba88-0ef8-4a09-8aa5-96e3b5968af4',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('89613939-0ec8-4d17-9978-b7bb7d97727c',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('dd241ea7-fd3f-44da-897c-843852ac6e44',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('3a75928e-5cb9-4cf8-a81d-30c297177e55',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('729452dd-d8af-40be-84c2-2bdbd1a2e3e6',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('b6f1a94d-9289-4881-9300-5e1931ddc4e3',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('30937504-ba38-443b-875b-ed13b17b8bc1',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('63e0f9ee-5024-4a05-803f-05face03226d',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('c27169c0-1618-426d-8fa4-6bbf9dcd8946',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('2eec05ab-bfc5-429f-bee4-fe095718040e',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('df057e1c-44e1-49e0-8041-6482745929f0',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('56a6c525-1588-4b78-8a12-524f86a539fc',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('31f96787-4506-48ca-b16f-fa41c4eaf503',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('0b137134-72bf-4417-92af-fa39a4453ced',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('8b1433bf-a11a-4cb5-9f16-5ea8162edb69',	'46a90daa-ce2b-4701-bc29-deffbb3fb521'),
('2160f19d-7a6e-4e01-85e9-31e68c5fc6b0',	'99399e75-f045-4820-99e6-d10c82950575'),
('e438e0bd-ce2e-4068-923c-5fc25b3939b8',	'99399e75-f045-4820-99e6-d10c82950575'),
('ae098112-47bd-44e4-91e8-995514f57d0b',	'99399e75-f045-4820-99e6-d10c82950575'),
('59e81c88-eb1f-4659-972d-fbd6a6b22c4d',	'99399e75-f045-4820-99e6-d10c82950575'),
('1d176cff-a3f8-46b6-8e2a-83e2e632ae5e',	'99399e75-f045-4820-99e6-d10c82950575'),
('c62e3a6f-c359-4800-921f-e8a8fcc43d5c',	'99399e75-f045-4820-99e6-d10c82950575'),
('1b7b5636-d175-4c8b-9291-c0c53b01266f',	'99399e75-f045-4820-99e6-d10c82950575');

DROP TABLE IF EXISTS "user_session";
CREATE TABLE "keycloak"."user_session" (
    "id" character varying(36) NOT NULL,
    "auth_method" character varying(255),
    "ip_address" character varying(255),
    "last_session_refresh" integer,
    "login_username" character varying(255),
    "realm_id" character varying(255),
    "remember_me" boolean DEFAULT false NOT NULL,
    "started" integer,
    "user_id" character varying(255),
    "user_session_state" integer,
    "broker_session_id" character varying(255),
    "broker_user_id" character varying(255),
    CONSTRAINT "constraint_57" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "user_session_note";
CREATE TABLE "keycloak"."user_session_note" (
    "user_session" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(2048),
    CONSTRAINT "constraint_usn_pk" PRIMARY KEY ("user_session", "name")
) WITH (oids = false);


DROP TABLE IF EXISTS "username_login_failure";
CREATE TABLE "keycloak"."username_login_failure" (
    "realm_id" character varying(36) NOT NULL,
    "username" character varying(255) NOT NULL,
    "failed_login_not_before" integer,
    "last_failure" bigint,
    "last_ip_failure" character varying(255),
    "num_failures" integer,
    CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY ("realm_id", "username")
) WITH (oids = false);


DROP TABLE IF EXISTS "web_origins";
CREATE TABLE "keycloak"."web_origins" (
    "client_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_web_origins" PRIMARY KEY ("client_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_web_orig_client" ON "keycloak"."web_origins" USING btree ("client_id");

INSERT INTO "web_origins" ("client_id", "value") VALUES
('15e2eb8b-e8cb-4f14-9a9d-8fe0ecdd64c0',	'+'),
('b4d7af9b-b0f1-4f54-98f3-1b731a23ff04',	'+');

ALTER TABLE ONLY "keycloak"."associated_policy" ADD CONSTRAINT "fk_frsr5s213xcx4wnkog82ssrfy" FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."associated_policy" ADD CONSTRAINT "fk_frsrpas14xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."authentication_execution" ADD CONSTRAINT "fk_auth_exec_flow" FOREIGN KEY (flow_id) REFERENCES authentication_flow(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."authentication_execution" ADD CONSTRAINT "fk_auth_exec_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."authentication_flow" ADD CONSTRAINT "fk_auth_flow_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."authenticator_config" ADD CONSTRAINT "fk_auth_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_attributes" ADD CONSTRAINT "fk3c47c64beacca966" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_initial_access" ADD CONSTRAINT "fk_client_init_acc_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_node_registrations" ADD CONSTRAINT "fk4129723ba992f594" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_scope_attributes" ADD CONSTRAINT "fk_cl_scope_attr_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_scope_role_mapping" ADD CONSTRAINT "fk_cl_scope_rm_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_session" ADD CONSTRAINT "fk_b4ao2vcvat6ukau74wbwtfqo1" FOREIGN KEY (session_id) REFERENCES user_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_session_auth_status" ADD CONSTRAINT "auth_status_constraint" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_session_note" ADD CONSTRAINT "fk5edfb00ff51c2736" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_session_prot_mapper" ADD CONSTRAINT "fk_33a8sgqw18i532811v7o2dk89" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_session_role" ADD CONSTRAINT "fk_11b7sgqw18i532811v7o2dv76" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."client_user_session_note" ADD CONSTRAINT "fk_cl_usr_ses_note" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."component" ADD CONSTRAINT "fk_component_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."component_config" ADD CONSTRAINT "fk_component_config" FOREIGN KEY (component_id) REFERENCES component(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."composite_role" ADD CONSTRAINT "fk_a63wvekftu8jo1pnj81e7mce2" FOREIGN KEY (composite) REFERENCES keycloak_role(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."composite_role" ADD CONSTRAINT "fk_gr7thllb9lu8q4vqa4524jjy8" FOREIGN KEY (child_role) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."credential" ADD CONSTRAINT "fk_pfyr0glasqyl0dei3kl69r6v0" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."default_client_scope" ADD CONSTRAINT "fk_r_def_cli_scope_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."federated_identity" ADD CONSTRAINT "fk404288b92ef007a6" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."group_attribute" ADD CONSTRAINT "fk_group_attribute_group" FOREIGN KEY (group_id) REFERENCES keycloak_group(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."group_role_mapping" ADD CONSTRAINT "fk_group_role_group" FOREIGN KEY (group_id) REFERENCES keycloak_group(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."identity_provider" ADD CONSTRAINT "fk2b4ebc52ae5c3b34" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."identity_provider_config" ADD CONSTRAINT "fkdc4897cf864c4e43" FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."identity_provider_mapper" ADD CONSTRAINT "fk_idpm_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."idp_mapper_config" ADD CONSTRAINT "fk_idpmconfig" FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."keycloak_role" ADD CONSTRAINT "fk_6vyqfe4cn4wlq8r6kt5vdsj5c" FOREIGN KEY (realm) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."policy_config" ADD CONSTRAINT "fkdc34197cf864c4e43" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."protocol_mapper" ADD CONSTRAINT "fk_cli_scope_mapper" FOREIGN KEY (client_scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."protocol_mapper" ADD CONSTRAINT "fk_pcm_realm" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."protocol_mapper_config" ADD CONSTRAINT "fk_pmconfig" FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_attribute" ADD CONSTRAINT "fk_8shxd6l3e9atqukacxgpffptw" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_default_groups" ADD CONSTRAINT "fk_def_groups_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_enabled_event_types" ADD CONSTRAINT "fk_h846o4h0w8epx5nwedrf5y69j" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_events_listeners" ADD CONSTRAINT "fk_h846o4h0w8epx5nxev9f5y69j" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_required_credential" ADD CONSTRAINT "fk_5hg65lybevavkqfki3kponh9v" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_smtp_config" ADD CONSTRAINT "fk_70ej8xdxgxd0b9hh6180irr0o" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."realm_supported_locales" ADD CONSTRAINT "fk_supported_locales_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."redirect_uris" ADD CONSTRAINT "fk_1burs8pb4ouj97h5wuppahv9f" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."required_action_provider" ADD CONSTRAINT "fk_req_act_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_attribute" ADD CONSTRAINT "fk_5hrm2vlf9ql5fu022kqepovbr" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_policy" ADD CONSTRAINT "fk_frsrpos53xcx4wnkog82ssrfy" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."resource_policy" ADD CONSTRAINT "fk_frsrpp213xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_scope" ADD CONSTRAINT "fk_frsrpos13xcx4wnkog82ssrfy" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."resource_scope" ADD CONSTRAINT "fk_frsrps213xcx4wnkog82ssrfy" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog82sspmt" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog83sspmt" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog84sspmt" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrpo2128cx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_server_policy" ADD CONSTRAINT "fk_frsrpo213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_server_resource" ADD CONSTRAINT "fk_frsrho213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_server_scope" ADD CONSTRAINT "fk_frsrso213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."resource_uris" ADD CONSTRAINT "fk_resource_server_uris" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."role_attribute" ADD CONSTRAINT "fk_role_attribute_id" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."scope_mapping" ADD CONSTRAINT "fk_ouse064plmlr732lxjcn1q5f1" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."scope_policy" ADD CONSTRAINT "fk_frsrasp13xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."scope_policy" ADD CONSTRAINT "fk_frsrpass3xcx4wnkog82ssrfy" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_attribute" ADD CONSTRAINT "fk_5hrm2vlf9ql5fu043kqepovbr" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_consent" ADD CONSTRAINT "fk_grntcsnt_user" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_consent_client_scope" ADD CONSTRAINT "fk_grntcsnt_clsc_usc" FOREIGN KEY (user_consent_id) REFERENCES user_consent(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_federation_config" ADD CONSTRAINT "fk_t13hpu1j94r2ebpekr39x5eu5" FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_federation_mapper" ADD CONSTRAINT "fk_fedmapperpm_fedprv" FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id) NOT DEFERRABLE;
ALTER TABLE ONLY "keycloak"."user_federation_mapper" ADD CONSTRAINT "fk_fedmapperpm_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_federation_mapper_config" ADD CONSTRAINT "fk_fedmapper_cfg" FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_federation_provider" ADD CONSTRAINT "fk_1fj32f6ptolw2qy60cd8n01e8" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_group_membership" ADD CONSTRAINT "fk_user_group_user" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_required_action" ADD CONSTRAINT "fk_6qj3w1jw9cvafhe19bwsiuvmd" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_role_mapping" ADD CONSTRAINT "fk_c4fqv34p1mbylloxang7b1q3l" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."user_session_note" ADD CONSTRAINT "fk5edfb00ff51d3472" FOREIGN KEY (user_session) REFERENCES user_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "keycloak"."web_origins" ADD CONSTRAINT "fk_lojpho213xcx4wnkog82ssrfy" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

-- 2023-05-20 19:31:40.98676+00
