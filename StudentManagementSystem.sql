--Mục 1
--Tao CSDL
CREATE DATABASE StudentManagementSystem
GO
--Active Database
USE StudentManagementSystem
GO

--Mục 2 => tạo table
-- Tạo class table
create table Class(
    ClassId int not null,
    ClassCode NVARCHAR(50)
)

-- tạo Student class
CREATE TABLE Student(
    StudentId int not NULL,
    StudentName NVARCHAR(50),
    BirthDate datetime,
    ClassId int 
)


--Tạo Subject
CREATE table Subject(
    SubjectId int not null,
    SubjectName NVARCHAR(100),
    SessionCount int
)

--Tạo bảng quản lý điểm thi
CREATE TABLE Result(
    StudentId int not null,
    SubjectId int not null,
    Mark FLOAT
)
GO

--mục 3: tạo constranint
alter table Class 
add constraint PK_Class PRIMARY KEY (ClassId)

alter table Student 
add constraint PK_Student PRIMARY KEY (StudentId) 

alter table Subject
add constraint PK_Subject PRIMARY KEY (SubjectId)

alter TABLE Result
add constraint PK_Result PRIMARY KEY (SubjectId, StudentId)

alter table Student 
add constraint FK_Student_Class foreign key (ClassId) references Class (ClassId)

alter table Result 
add constraint FK_Result_Student foreign key (StudentId) references Student (StudentId)

alter table Result 
add constraint FK_Result_Subject foreign key (SubjectId) references Subject (SubjectId)

---Check
alter TABLE Subject
add constraint CH_Subject_SessionCount check (SessionCount > 0)

--Mục 4: Insert Data
insert into Class(ClassId, ClassCode)
VALUES
(1, 'C1106KV'),
(2, 'C1107KV'),
(3, 'C1108KV'),
(4, 'C1109KV'),
(5, 'C1101KV')

insert into Student(StudentId, StudentName, BirthDate, ClassId)
VALUES
(1, 'Nguyen Trong Nghia', '2002-06-15', 1),
(2, 'Nguyen Thi Loan', '2002-06-14', 1),
(3, 'Nguyen Huu Thao', '2002-06-13', 2),
(4, 'Trinh Le Quoc Cuong', '2002-06-12', 2),
(5, 'Nguyen Hai Anh', '2002-06-11', 3)

insert into Subject(SubjectId, SubjectName, SessionCount)
VALUES
(1, 'C++ Programming', 22),
(2, ' Web Design', 18),
(3, 'Database Management', 23)

insert into Result(StudentId, SubjectId, Mark)
VALUES
(1, 1, 8),
(1, 2, 7),
(2, 3, 5),
(3, 2, 6),
(4, 3, 9),
(5, 2, 8)

select * from Class
select * from Student
select * from Subject
select * from Result

---Mục 5 : Query

select StudentId 'Ma Sinh Vien', StudentName 'Ten Sinh Vien', Birthdate 'Ngay Sinh'
from Student
where BirthDate Between '2002-06-15' and '2002-06-30'

---Dem Sinh vien trong lop
select Class.ClassId, Class.ClassCode, Count(Student.StudentId) TotalStudent
from Class left JOIN Student on Class.ClassId = Student.ClassId
GROUP by Class.ClassId, Class.ClassCode

---Hiển Thị Tổng Điểm của sinh viên
select Student.StudentId 'Ma Sinh Vien', Student.StudentName 'Ten Sinh Vien', Sum(Result.Mark) ToTalMark
from Student left join Result on Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
order by ToTalMark DESC 

---Hiển Thị Điểm Sinh Viên có tổng điểm lớn hơn 10
select Student.StudentId 'Ma Sinh Vien', Student.StudentName 'Ten Sinh Vien', Sum(Result.Mark) ToTalMark
from Student left join Result on Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
Having Sum(Result.Mark) > 10
order by ToTalMark DESC 
