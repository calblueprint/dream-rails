# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
$teachers = []
$courses = []
$course_names = ["Math 4: Introduction to Algebra", "English 2: Reading Comprehension",
                "Music 1: Constructing Harmonies", "CS 4: Data Structures",
                "Chemistry 2: Molecules and Bonds", "Geography 3: Natural Environments",
                "Math 7: Introduction to Calculus", "French 5: Reading Analysis",
                "Biology 2: Human Anatomy", "Stats 1: Introduction to Statistics",
                ]

Faker::Config.locale = 'es'
Faker::Config.random = Random.new(42)

def make_teachers
  1.upto(5) do |n|
    teacher = Teacher.create(
      admin: false,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      dream_id: n,
      email: "user#{n}@gmail.com",
      password: "password",
      password_confirmation: "password",
      phone: Faker::PhoneNumber.cell_phone.gsub(/-/, ''),
    )
    $teachers << teacher
  end
  admin = Teacher.create(
    admin: true,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dream_id: 6,
    email: "admin@gmail.com",
    password: "password",
    password_confirmation: "password",
    phone: Faker::PhoneNumber.cell_phone.gsub(/-/, ''),
  )
  admin.id = 6
  admin.save
end

def make_courses
  six_months_ago = Date.yesterday.advance(months: -6)
  1.upto(10) do |n|
    course = Course.create(
      title: $course_names[n],
      teacher_id1: n % ($teachers.length - 1) + 1,
      teacher_id2: n % ($teachers.length - 1) + 2,
      start_date: six_months_ago.advance(months: n),
      end_date: six_months_ago.advance(months: n + 2),
      is_active: Faker::Boolean.boolean,
      course_nickname: Faker::Educator.course,
      site: Faker::Educator.campus,
      program: rand(0..5),
      notes: Faker::HarryPotter.quote
    )
    $courses << course
  end
end

def make_teacher_courses
  $courses.each do |course|
    CoursesTeacher.create(
      course_id: course.id,
      teacher_id: course.id % ($teachers.length - 1) + 1,
    )
    CoursesTeacher.create(
      course_id: course.id,
      teacher_id: course.id % ($teachers.length - 1) + 2,
    )
  end
end

def make_sessions
  weekday_list = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ]
  1.upto(10) do |n|
    session = Session.create(
      weekday: weekday_list[n%5],
      start_time: Faker::Time.between(2.days.ago, Date.today, :afternoon),
      end_time: Faker::Time.between(2.days.ago, Date.today, :evening),
      number: 0,
    )
    session.course = Course.find(n)
    session.save
  end
end

def make_students
  1.upto(10) do |m|
    student = Student.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      birthday: Faker::Date.birthday(3, 18),
      address: Faker::Address.street_address,
      nickname: Faker::LordOfTheRings.character,
      created_at: Faker::Date.between(1000.days.ago, 50.days.ago),
      updated_at: Faker::Date.between(49.days.ago, Date.today),
      primary_contact: Faker::Name.name,
      primary_contact_phone: Faker::PhoneNumber.cell_phone,
      dream_id: m,
      is_active: rand(0..1),
      sex: rand(0..1),
      facebook_name: Faker::Name.name,
      notes: Faker::TheFreshPrinceOfBelAir.quote,
      document_type: rand(0..5),
      level: rand(0..4),
      phone: Faker::PhoneNumber.cell_phone,
      phone_2: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
      primary_language: rand(0..2),
      past_dream_participant: rand(0..1)
    )
    student.id = m
    student.save
  end
end

def make_courses_students
  1.upto(10) do |n|
    1.upto(5) do |m|
      course_student = CoursesStudent.create(
        student_id: n % 4 + m,
        course_id: n
      )
    end
  end
end

def make_attendances
  today = Date.today
  CoursesStudent.all.each do |student|
    1.upto(10) do |k|
      attendance = Attendance.create(
        courses_student_id: student.id,
        date: today.advance(days: k)
      )
    end
  end
end

make_teachers
make_courses
make_teacher_courses
make_sessions
make_students
make_courses_students
make_attendances
