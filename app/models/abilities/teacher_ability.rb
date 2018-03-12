module Abilities
  class TeacherAbility
    include CanCan::Ability

    def initialize(teacher)
      teacher ||= Teacher.new
      can :manage, Teacher, id: teacher.id
      can :read, Teacher

      can [
        :index,
        :show,
        :create,
      ], CoursesTeacher

      can :manage, Student do |student|
        teacher.courses.exists? student.course_id
      end

      can :manage, Course do |course|
        teacher.courses.include? course
      end

      can :manage, Attendance do |attendance|
        teacher.courses.exists? attendance.course_id
      end

      can :manage, Session do |session|
        teacher.courses.exists? sessions.course_id
      end
    end

  end
end
