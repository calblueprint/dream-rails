class TeacherAbility
  include CanCan::Ability

  def initialize(teacher)
    teacher ||= Teacher.new

    can :manage, Teacher, id: teacher.id
    can :read, Teacher

    can :manage, Course do |course|
      teacher.courses.include? course 
    end
end
