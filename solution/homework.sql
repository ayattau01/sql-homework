CREATE TABLE students (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL
  );

ALTER TABLE students ADD COLUMN email VARCHAR(150);
ALTER TABLE students ALTER COLUMN first_name SET DATA TYPE VARCHAR(100);

insert into students(student_id,first_name,email)
values(1,'AYAT','ayattau@gmail.com'),
  (2,'NUR','nur@example.com'),
  (3,'DIMA','dima@gmail.com');

select*from students;
