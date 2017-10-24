CREATE TYPE public.employee_rank AS ENUM ('worker', 'manager');
ALTER TYPE public.employee_rank
 OWNER TO postgres;

CREATE TABLE public.user
(
 username character varying(80) NOT NULL,
 password character varying(80) NOT NULL,
 rank public.employee_rank NOT NULL,
 enabled boolean NOT NULL,
 CONSTRAINT user_pkey PRIMARY KEY (username)
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.user
 OWNER TO postgres;

CREATE TABLE public.employee
(
 username character varying(80) NOT NULL,
 email character varying(80),
 name character varying(80),
 CONSTRAINT employee_pkey PRIMARY KEY (username),
 CONSTRAINT employee_user_fkey FOREIGN KEY (username)
      REFERENCES public.user (username) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 )
WITH (
 OIDS=FALSE
);
ALTER TABLE public.employee
 OWNER TO postgres;

 CREATE TABLE public.store_section
 (
  id bigint NOT NULL,
  name character varying(80) NOT NULL,
  CONSTRAINT store_section_pkey PRIMARY KEY (id)
  )
 WITH (
  OIDS=FALSE
 );
 ALTER TABLE public.store_section
  OWNER TO postgres;

CREATE TYPE public.task_status AS ENUM ('new', 'in-progress', 'done');
ALTER TYPE public.task_status
 OWNER TO postgres;

CREATE TABLE public.task
(
 id bigint NOT NULL,
 name character varying(80) NOT NULL,
 description character varying(600),
 status public.task_status NOT NULL,
 urgent boolean NOT NULL,
 appeal boolean NOT NULL,
 template boolean NOT NULL,
 section_id bigint,
 creation_time timestamp NOT NULL,
 dueTime timestamp,
 creator_username character varying(80),
 CONSTRAINT task_pkey PRIMARY KEY (id),
 CONSTRAINT task_section_fkey FOREIGN KEY (section_id)
      REFERENCES public.store_section (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT task_user_fkey FOREIGN KEY (creator_username)
      REFERENCES public.user (username) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 )
WITH (
 OIDS=FALSE
);
ALTER TABLE public.task
 OWNER TO postgres;

CREATE TABLE public.task_employee
(
 task_id bigint NOT NULL,
 username character varying(80) NOT NULL,
 CONSTRAINT task_employee_task_fkey FOREIGN KEY (task_id)
     REFERENCES public.task (id) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT task_employee_employee_fkey FOREIGN KEY (username)
     REFERENCES public.employee (username) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.task_employee
 OWNER TO postgres;


INSERT INTO public.user (
  username,
  password,
  rank,
  enabled
) VALUES (
  'admin',
  '$2a$08$lDnHPz7eUkSi6ao14Twuau08mzhWrL4kyZGGU5xfiGALO/Vxd5DOi',
  'manager',
  true
);
INSERT INTO public.user (
  username,
  password,
  rank,
  enabled
) VALUES (
  'john',
  '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC',
  'worker',
  true
);
INSERT INTO public.user (
  username,
  password,
  rank,
  enabled
) VALUES (
  'jane',
  '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC',
  'worker',
  true
);
INSERT INTO public.employee (
  username,
  email,
  name
) VALUES (
  'admin',
  'admin@example.com',
  'Bob Chen'
);
INSERT INTO public.employee (
  username,
  email,
  name
) VALUES (
  'john',
  'john.doe@example.com',
  'John Doe'
);
INSERT INTO public.employee (
  username,
  email,
  name
) VALUES (
  'jane',
  'jane.doe@example.com',
  'Jane Doe'
);
INSERT INTO public.store_section (
  id,
  name
) VALUES (
  1,
  'Meat'
);
INSERT INTO public.store_section (
  id,
  name
) VALUES (
  2,
  'Fruits and Vegs'
);
INSERT INTO public.store_section (
  id,
  name
) VALUES (
  3,
  'Milk products'
);
INSERT INTO public.store_section (
  id,
  name
) VALUES (
  4,
  'Bread'
);
INSERT INTO public.store_section (
  id,
  name
) VALUES (
  5,
  'Sweets and cookies'
);
