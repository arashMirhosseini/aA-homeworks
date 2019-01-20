require "byebug"

class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def sub_salary
    sum = 0
    @employees.each do |employee|
        if employee.is_a?(Manager)
          # byebug
            sum += employee.salary + employee.sub_salary
        else
          # byebug
            sum += employee.salary
        end
    end
    # byebug
    sum 
  end

  def bonus(multiplier)
      sub_salary * multiplier
  end
end

david = Employee.new("David", "TA", 10000, "Darren")
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78000, "Ned", [shawna, david])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])

p ned.bonus(5)
# p ned.employees[0].employees.length
# p ned.sub_salary
p darren.bonus(4)
p david.bonus(3)
