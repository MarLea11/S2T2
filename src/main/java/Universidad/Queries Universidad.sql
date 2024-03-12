-- 1 Returns a list with the first last name, second last name and first name of all the students. 
-- The list must be ordered alphabetically from lowest to highest by first last name, second last name and first name.
SELECT CONCAT(persona.apellido1, ' ',  persona.apellido2, ' ', persona.nombre) AS nombre_completo FROM persona ORDER BY nombre_completo ASC;

-- 2 Find out the first and last names of the students who have not registered their phone number in the database.
SELECT persona.apellido1, persona.apellido2 FROM persona WHERE persona.telefono IS NULL AND persona.tipo = 'alumno';

-- 3 Returns the list of students who were born in 1999.
SELECT * FROM persona WHERE YEAR(persona.fecha_nacimiento) = 1999 AND persona.tipo = 'alumno'; 

-- 4 Returns the list of teachers who have not registered their phone number 
-- in the database and also their NIF ends in K.
SELECT * FROM persona WHERE persona.telefono IS NULL AND persona.nif LIKE '%K' AND persona.tipo = 'profesor';

-- 5 Returns the list of subjects that are taught in the first semester, in the third course 
-- of the grade that has the identifier 7.
SELECT * FROM asignatura WHERE asignatura.cuatrimestre = 1 AND asignatura.curso = 3 AND asignatura.id_grado = 7;

-- 6 Returns a list of professors along with the name of the department to which they are linked. 
-- The listing should return four columns, first last name, second last name, first name and department name. 
-- The result will be sorted alphabetically from lowest to highest by last name and first name.
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor, departamento.nombre AS nombre_departamento FROM persona INNER JOIN profesor ON profesor.id_profesor = persona.id INNER JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 7 Returns a list with the name of the subjects, start year and end year of the 
-- student's school year with NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM alumno_se_matricula_asignatura INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE persona.nif = '26902806M';

-- 8 Returns a list with the name of all the departments that have professors who 
-- teach a subject in the Degree in Computer Engineering (Plan 2015).
SELECT DISTINCT departamento.nombre FROM departamento INNER JOIN profesor ON departamento.id = profesor.id_departamento INNER JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor INNER JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingenieria Informática (Plan 2015)';

-- 9 Returns a list of all students who have enrolled in a subject during the 2018/2019 school year.
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2 FROM alumno_se_matricula_asignatura INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;

-- Solve the following 6 queries using the LEFT JOIN and RIGHT JOIN clauses.

-- 1 Returns a list with the names of all the professors and the departments they are linked to. 
-- The list must also show those professors who do not have any associated department. 
-- The listing must return four columns, department name, first last name, second last name and teacher's name. 
-- The result will be sorted alphabetically from lowest to highest by department name, last name and first name.
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor, departamento.nombre AS nombre_departamento FROM persona LEFT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 2 Returns a list of professors who are not associated with a department.
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id RIGHT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' AND profesor.id_departamento IS NULL;

-- 3 Returns a list of departments that do not have associate professors.
SELECT departamento.nombre AS nombre_departamento  FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;

-- 4 Returns a list of teachers who do not teach any subjects.
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

-- 5 Returns a list of subjects that do not have an assigned teacher.
SELECT asignatura.nombre AS nombre_asignatura FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id_profesor IS NULL;

-- 6 Returns a list with all departments that have not taught subjects in any school year.
SELECT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

-- Queries Summary

-- 1 Returns the total number of students.
SELECT COUNT(persona.id) AS total_alumnos FROM persona WHERE persona.tipo = 'alumno';

-- 2 Calculate how many students were born in 1999.
SELECT COUNT(persona.id) AS alumnos_nacidos_en_1999 FROM persona WHERE YEAR(persona.fecha_nacimiento) = 1999;

-- 3 Calculate how many teachers there are in each department. 
-- The result should only show two columns, one with the name of the department and another 
-- with the number of teachers in that department. 
-- The result must only include the departments that have associate professors and must be ordered 
-- from highest to lowest by the number of professors.
SELECT departamento.nombre, COUNT(DISTINCT profesor.id_profesor) AS total_profesores_departamento FROM departamento INNER JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY total_profesores_departamento DESC;

-- 4 Returns a list with all the departments and the number of professors in each of them. 
-- Keep in mind that there may be departments that do not have associate professors. 
-- These departments must also appear in the list.
SELECT departamento.nombre, COUNT(DISTINCT profesor.id_profesor) AS total_profesores_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre;

-- 5 Returns a list with the name of all the existing degrees in the database and 
-- the number of subjects each one has. Note that there may be degrees that do not have associated subjects. 
-- These grades must also appear in the listing. The result must be ordered from 
-- highest to lowest by the number of subjects.
SELECT grado.nombre, COUNT(DISTINCT asignatura.id) AS total_asignatura_grado FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY total_asignatura_grado DESC;
 
-- 6 Returns a list with the name of all the existing degrees in the database and 
-- the number of subjects each has, of the degrees that have more than 40 associated subjects.
SELECT grado.nombre, COUNT(DISTINCT asignatura.id) AS total_asignatura_grado FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING total_asignatura_grado > 40;

-- 7 Returns a list showing the name of the degrees and the sum of the total number of credits 
-- for each type of subject. The result must have three columns: name of the degree, type of subject and 
-- the sum of the credits of all subjects of that type.
SELECT DISTINCT grado.nombre AS nombre_grado, asignatura.tipo AS tipo_asignatura, asignatura.creditos AS creditos_asignatura FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado;

-- 8 Returns a list that shows how many students have enrolled in a subject in each of the school years. 
-- The result must show two columns, one column with the start year of the school year and 
-- another with the number of enrolled students.
SELECT curso_escolar.anyo_inicio, COUNT(*) AS total_alumnos_matriculados_asignatura FROM curso_escolar INNER JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;

-- 9 Returns a list with the number of subjects taught by each teacher. 
-- The list must take into account those professors who do not teach any subjects. 
-- The result will show five columns: id, name, first last name, second last name and number of subjects. 
-- The result will be ordered from highest to lowest by the number of subjects.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id_profesor) AS numero_asignatura FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE persona.tipo = 'profesor' GROUP BY persona.id;

-- 10 Returns all the data of the youngest student.
SELECT * FROM persona WHERE persona.fecha_nacimiento = (SELECT MAX(persona.fecha_nacimiento) FROM persona WHERE persona.tipo = 'alumno');

-- 11 Returns a list of professors who have an associated department and who do not teach any subjects.
SELECT CONCAT(persona.nombre, ' ', persona.apellido1, ' ', persona.apellido2) AS nombre_completo_profesor FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor INNER JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE profesor.id_departamento IS NOT NULL AND asignatura.id_profesor IS NULL;