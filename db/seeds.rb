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
      dream_id: Faker::Number.number(7),
      email: Faker::Internet.free_email(),
      phone: Faker::PhoneNumber.phone_number,
    )
    teacher.id = n
    teacher.save
  end
end

def make_courses
  1.upto(5) do |n|
    course = Course.create(
      title: Faker::Educator.course,
      is_active: Faker::Boolean.boolean,
    )
    course.id = n
    course.save
  end
end

# def make_attendances
#   1.upto(5) do |n|
#     attendance = Attendance.create(
#
#     )
#     attendance.id = n
#     attendance.save
#   end
# end


make_teachers
make_courses
