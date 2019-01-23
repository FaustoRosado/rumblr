class Validate
  def self.login(email, password)
    user = User.find_by(email: email)
    user && password == user.password
  end

  def self.register(email, password, reenter_password, firstname, lastname, birthday)
    error_list = []

    if firstname.length == 0
      error_list.push('You must enter a first name.')
    end

    if lastname.length == 0
      error_list.push('You must enter a last name.')
    end

    unless /.+@.+\.\w+/.match(email)
      error_list.push('You must enter a valid email address. (e.g. example@example.com)')
    end

    if password.length < 6 || password.length > 32
      error_list.push('Your password must be between 6 and 32 characters.')
    end

    if password != reenter_password
      error_list.push('Your passwords do not match.')
    end

  

    error_list.length > 0 ? error_list : true
  end

  def self.post(title)
    if title.length == 0
      return 'You must have a title.'
    end

    true
  end
end