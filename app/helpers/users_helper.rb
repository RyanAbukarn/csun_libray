module UsersHelper
    def name_format(f,l)
        "Hello #{f} #{l}"
    end
    def name_format2(user)
        "#{user.lname}, #{user.fname}"
    end
end
