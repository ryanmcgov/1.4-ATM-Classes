# What are my main concepts?
# What are the nouns?
# We have a USER interacting with an ATM

# A User can be described as having a
#   * name
#   * pin
#   * balance
# 
# What are the actions on the screen
# that the user can take (except exit)?
# What are the VERBS?
#   * check balance
#     * we RETURN the User instance's balance
#   * withdraw
#     * we SET the User instance's balance and
#       either return TRUE/FALSE or return a balance check
#
# With this little bit of information
# we are able to describe our class
# and its actions (aka, methods)

class User
  attr_accessor :____, :____, :____

  def check_balance
  end

  def withdraw
  end
end