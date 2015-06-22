# Accesses the csv file with user info
require "csv"

#Creates a User class with appropriate methods
class User
  attr_accessor :name, :pin
  
  # def initialize(name, pin, balance)
  #   @name = name
  #   @pin = pin
  #   @balance = balance
  # end

  # def name
  #   @name
  # end

  def balance
    @balance.to_i
  end

  def check_balance
    puts "Your current balance is #{balance}"
  end

  def withdraw
    @balance.withdraw_amount
  end
end

atm_available_funds = 50000

# Creates a new has from the csv information
accounts = []
csv = CSV.foreach('./users.csv', :headers => true, :header_converters => :symbol) { |row|
  row.to_hash
  user = User.new(row[:name], row[:pin], row[:balance])
  accounts.push(user)
}

# Universal prompt
def prompt_input(text)
  input = ""
  while input == ""
    puts text
    print "> "
    input = gets.chomp
  end
  input
end

#Gets user name
current_user_name = ""
while current_user_name == ""
  current_user_name = prompt_user("Please Enter Your Name")
end 

#Gets user pin
current_user_pin = ""
while current_user_pin == ""
  current_user_pin = prompt_user("Please Enter Your Pin")
end

current_user = nil

# Checks the input name and pin against the ones present in accounts
accounts.each do |user|
  if user[ :name] == current_user_name && user[ :pin] == current_user_pin
    current_user = user 
  end
end

# The next set of options if a vaild user is found
if current_user
  options = ["1. Check Balance", "2. Withdraw Funds", "3. Cancel"]
  selected_option = nil
  until (1..options.length).include?(selected_option) do
    selected_option = prompt_user(options.join("\n")).to_i
  end
  
  case selected_option
  when 1
    puts "#{current_user.check_balance}"
  when 2
    requested_amount = prompt_user("How Much Do You Want?")
    if requested_amount >= atm_available_funds
      puts "This machine does not have enough funds"
    elsif requested_amount >= current_user.balance
      puts "Insufficient funds"
    else
      puts "Please Take Your Money"
      current_user.balance -= requested_amount
      puts "New Balance: #{current_user.balance}"
    end
    
  when 3
    puts "Thank You, Come Again!"
  end
else
  puts "Incorrect Information"
end
