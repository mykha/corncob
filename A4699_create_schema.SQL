CREATE SCHEMA IF NOT EXISTS A4699;

set search_path TO A4699;

CREATE TABLE IF NOT EXISTS process (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    display_name VARCHAR(150),
    parent_id INTEGER REFERENCES process(id)
)
;

CREATE TABLE IF NOT EXISTS  operation (
    id SERIAL PRIMARY KEY,
    process_id INTEGER REFERENCES process(id),
    name VARCHAR(80) NOT NULL,
    display_name VARCHAR(150),
    is_final BOOLEAN,
    sort_order INTEGER,
    multiinstance BOOLEAN,
    status_after VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS  next_steps (
    parent_id INTEGER REFERENCES operation(id),
    operation_id INTEGER REFERENCES operation(id),
    is_default BOOLEAN,
    sort_order INTEGER
);

CREATE TABLE IF NOT EXISTS  parallel_steps (
    parent_id INTEGER REFERENCES operation(id),
	operation_id INTEGER REFERENCES operation(id),
    is_required BOOLEAN
);

CREATE TABLE IF NOT EXISTS  workflow (
    id SERIAL PRIMARY KEY,
	process_id INTEGER REFERENCES process(id),
	start_date TIMESTAMP,
    finish_date  TIMESTAMP,
	done BOOLEAN
);

CREATE TABLE IF NOT EXISTS  task (
    id SERIAL PRIMARY KEY,
	workflow_id INTEGER REFERENCES workflow(id),
	operation_id INTEGER REFERENCES operation(id),
    task_date  TIMESTAMP,
	token integer
);

CREATE TABLE IF NOT EXISTS  task_data (
    id SERIAL PRIMARY KEY,
	task_id INTEGER REFERENCES task(id),
	body JSONB
);

CREATE TABLE IF NOT EXISTS  task_data_list (
	task_id INTEGER REFERENCES task(id),
    list_type VARCHAR(150),
    str_number integer,
	item JSONB
);

CREATE TABLE IF NOT EXISTS  task_data_template (
	operation_id INTEGER REFERENCES operation(id),
    field_name VARCHAR(150),
    field_type VARCHAR(150),
    list_type_name VARCHAR(150)
);


CREATE TABLE IF NOT EXISTS  person(
    id SERIAL PRIMARY KEY,
	full_name  VARCHAR(255),
	birthday DATE,
	rnokpp integer    
);

CREATE TABLE IF NOT EXISTS  military(
    id SERIAL PRIMARY KEY,
	person_id INTEGER REFERENCES person(id),
	full_name  VARCHAR(255),
	military_index VARCHAR(8)
);

CREATE TABLE IF NOT EXISTS  unit(
    id SERIAL PRIMARY KEY,
	parent_id INTEGER REFERENCES unit(id),
	unit_name  VARCHAR(150),
	full_name  VARCHAR(255)
);
ALTER TABLE unit
ADD COLUMN IF NOT EXISTS contact_person_id INTEGER REFERENCES person(id);

CREATE TABLE IF NOT EXISTS  life_cycle (
    action_date TIMESTAMP,
    workflow_id INTEGER REFERENCES workflow(id),
    task_id INTEGER REFERENCES task(id),
    military_id INTEGER REFERENCES military(id),
	unit_id INTEGER REFERENCES unit(id)
);

