# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def make_teachers
  1.upto(5) do |n|
    teacher = Teacher.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      dream_id: n,
      email: "user#{n}@gmail.com",
      password: "password",
      password_confirmation: "password",
      phone: Faker::PhoneNumber.cell_phone.gsub(/-/, ''),
    )
    teacher.id = n
    teacher.save
  end
end

def make_courses
  six_months_ago = Date.yesterday.advance(months: -6)
  1.upto(10) do |n|
    course = Course.create(
      course_name: Faker::Educator.course,
      teacher_id1: n % 4 + 1,
      teacher_id2: n % 4 + 2,
      start_date: six_months_ago.advance(months: n),
      end_date: six_months_ago.advance(months: n + 2),
      is_active: Faker::Boolean.boolean,
      course_nickname: Faker::Educator.course,
      site: Faker::Educator.campus,
      program: Faker::Educator.university,
      notes: Faker::HarryPotter.quote
    )
    course.teachers << Teacher.find(course.teacher_id1)
    course.teachers << Teacher.find(course.teacher_id2)

    course.id = n
    course.save
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
  1.upto(10) do |n|
    1.upto(5) do |m|
      student = Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        birthday: Faker::Date.birthday(3, 18),
        address: Faker::Address.street_address,
        year: Faker::Number.between(0, 12),
        nickname: Faker::LordOfTheRings.character,
        created_at: Faker::Date.between(1000.days.ago, 50.days.ago),
        updated_at: Faker::Date.between(49.days.ago, Date.today),
        primary_contact: Faker::Name.name,
        primary_contact_phone: Faker::PhoneNumber.phone_number,
        dream_id: (n-1) * 5 + m,
        is_active: [true, false].sample,
        sex: [0, 1].sample,
        facebook_name: Faker::Name.name,
        notes: Faker::TheFreshPrinceOfBelAir.quote,
        document_type: [0, 1, 2, 3, 4, 5].sample,
        level: [0, 1, 2, 3, 4].sample,
        phone: Faker::PhoneNumber.phone_number,
        phone_2: Faker::PhoneNumber.phone_number,
        email: Faker::Internet.email,
        primary_language: [0, 1, 2].sample,
        past_dream_participant: [true, false].sample
      )
      student.id = (n-1) * 5 + m
      student.save
    end
  end
end

def make_courses_students
  1.upto(10) do |n|
    1.upto(5) do |m|
      course_student = CoursesStudent.create(
        student_id: (n-1) * 5 + m,
        course_id: n
      )
    end
  end
end

make_teachers
make_courses
make_sessions
make_students
make_courses_students
