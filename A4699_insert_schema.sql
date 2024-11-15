set search_path TO A4699;

INSERT INTO A4699.person(
	id, full_name)
	VALUES (1, 'Тарас Гаврилюк')
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO A4699.person(
	id, full_name)
	VALUES (2, 'БОНДАР Єлизавета Миколаївна')
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO A4699.person(
	id, full_name)
	VALUES (3, 'ХОЛОША Сергій')
	ON CONFLICT (id) DO NOTHING;	

INSERT INTO A4699.unit(
	id, parent_id, unit_name, full_name, contact_person_id)
	VALUES (1, null , '1 мб', '1 механізований батальйон', 1)
	ON CONFLICT (id) DO NOTHING;	;
INSERT INTO A4699.unit(
	id, parent_id, unit_name, full_name, contact_person_id)
	VALUES (2, null , '2 мб', '2 механізований батальйон', 2)
	ON CONFLICT (id) DO NOTHING;	;
INSERT INTO A4699.unit(
	id, parent_id, unit_name, full_name, contact_person_id)
	VALUES (3, null , '3 мб', '3 механізований батальйон', 3)
	ON CONFLICT (id) DO NOTHING;


--SELECT unit_name, p.full_name FROM A4699.unit AS u
--LEFT JOIN A4699.person as P ON P.id = u.contact_person_id

INSERT INTO process(
	id, name, display_name, parent_id)
	VALUES (1, 'Audit', 'Перевірка обліку', NULL )
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO operation(
	id, process_id, name, display_name, is_final, sort_order , multiinstance, status_after)
	VALUES (1, 1, 'Plan audit','Запланувати перевірку', false , 1, true, 'Запланована перевірка') 
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO operation(
	id, process_id, name, display_name, is_final, sort_order, status_after)
	VALUES (2, 1, 'Check','Провести перевірку', false , 2, 'Перевірку проведено') 
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO operation(
	id, process_id, name, display_name, is_final, sort_order, status_after)
	VALUES (3, 1, 'Prepare a report','Підготувати доповідь', true , 5, 'Доповідь підготовлено') 
	ON CONFLICT (id) DO NOTHING;
	
INSERT INTO operation(
	id, process_id, name, display_name, is_final, sort_order, status_after)
	VALUES (4, 1, 'Check the personnel book','Перевірити книгу обліку', false , 3, 'Книгу обліку перевірено') 
	ON CONFLICT (id) DO NOTHING;	
	
INSERT INTO operation(
	id, process_id, name, display_name, is_final, sort_order, status_after)
	VALUES (5, 1, 'Check for discrepancies','Перевірити розбіжності в обліку', false , 4, 'Розбіжності в обліку перевірено') 
	ON CONFLICT (id) DO NOTHING;		

INSERT INTO next_steps(
	operation_id, parent_id, is_default, sort_order)
	VALUES (2, 1, true, 0);
	
INSERT INTO next_steps(
	operation_id, parent_id, is_default, sort_order)
	VALUES (3, 2, true, 0);
	
INSERT INTO parallel_steps(
	operation_id, parent_id, is_required)
	VALUES (4, 3, false);
	
INSERT INTO parallel_steps(
	operation_id, parent_id, is_required)
	VALUES (5, 3, true);

SELECT p.display_name, o.display_name FROM A4699.process AS P
LEFT JOIN A4699.operation as o ON o.process_id = p.id
