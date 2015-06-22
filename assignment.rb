require "csv"

class User
  attr_accessor :name, :pin, :balance 
  
  def initialize(name, pin, balance)
    @name = name
    @pin = pin
    @balance = balance
  end

  def name
    @name
  end

  def balance
    @balance.to_1
  end

  def check_balance
    puts "Your current balance is #{balance}"
  end

  def withdraw
    @balance.withdraw_amount
  end
end

accounts = []
csv = CSV.foreach('./users.csv', :headers => true, :header_converters => :symbol) { |row|
  row.to_hash
  user = User.new(row[:name], row[:pin], row[:balance])
  accounts.push(user)
}

def prompt_input(text)
  input = ""
  while input == ""
    puts text
    print "> "
    input = gets.chomp
  end
  input
end

current_user_name = ""
while current_user_name == ""
  current_user_name = prompt_user("Please Enter Your Name")
end 

current_user_pin = ""
while current_user_pin == ""
  current_user_pin = prompt_user("Please Enter Your Pin")
end

user_exists = false
current_user = nil

existing_users.each do |user|
  if user[ :name] == current_user_name && user[ :pin] == current_user_pin
    current_user = user 
  end
end

if current_user
  options = ["1. Check Balance", "2. Withdraw Funds", "3. Cancel"]
  selected_option = nil
  until (1..options.length).include?(selected_option) do
    selected_option = prompt_user(options.join("\n")).to_i
  end
  
  case selected_option
  when 1
    puts "Your Balance Is #{current_user[:available_funds]}"
  when 2
    requested_amount = prompt_user("How Much Do You Want?")
    if requested_amount >= atm_available_funds
      puts "This machine does not have enough funds"
    elsif requested_amount >= current_user[:available_funds]
      puts "Insufficient funds"
    else
      puts "Please Take Your Money"
      current_user[:available_funds] -= requested_amount
      puts "New Balance: #{current_user[:available_funds]}"
    end
    
  when 3
    puts "Thank You, Come Again!"
  end
else
  puts "Incorrect Information"
end
