DO $$
BEGIN
  -- 1) students кестесі бар ма
  IF NOT EXISTS (SELECT 1 FROM information_schema.tables
                 WHERE table_name = 'students') THEN
    RAISE EXCEPTION 'students кестесі табылмады';
  END IF;

  -- 2) student_id бағаны
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'students' AND column_name = 'student_id') THEN
    RAISE EXCEPTION 'students.student_id бағаны жоқ';
  END IF;

  -- 3) PRIMARY KEY бар ма
  IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints
                 WHERE table_name = 'students' AND constraint_type = 'PRIMARY KEY') THEN
    RAISE EXCEPTION 'students кестесінде PRIMARY KEY жоқ';
  END IF;

  -- 4) first_name: NOT NULL және ұзындығы 100 (ALTER жасалған ба)
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'students' AND column_name = 'first_name'
                   AND is_nullable = 'NO'
                   AND character_maximum_length = 100) THEN
    RAISE EXCEPTION 'first_name жоқ, NOT NULL емес немесе VARCHAR(100) емес';
  END IF;

  -- 5) email бағаны қосылған ба (ALTER ADD COLUMN)
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'students' AND column_name = 'email'
                   AND character_maximum_length = 150) THEN
    RAISE EXCEPTION 'email бағаны жоқ немесе VARCHAR(150) емес';
  END IF;

  -- 6) 3 студент енгізілген бе
  IF (SELECT COUNT(*) FROM students) <> 3 THEN
    RAISE EXCEPTION 'students кестесінде 3 жол болуы керек, қазір: %',
                    (SELECT COUNT(*) FROM students);
  END IF;

  -- 7) AYAT бар ма
  IF NOT EXISTS (SELECT 1 FROM students WHERE first_name = 'AYAT') THEN
    RAISE EXCEPTION 'AYAT студенті табылмады';
  END IF;

  RAISE NOTICE 'Барлық тексеру сәтті өтті!';
END $$;
