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

def user_input(text)
  input = ""
  while input == ""
    puts text
    print "> "
    input = gets.chomp
  end
  input
end

